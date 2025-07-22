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
  
/*-----------------------------------------------------------------------------*/
/* Duplicate Form : WGWARGEN.W
   ModiFy By : Porntiwa P.  A53-0111  16/09/2010
-------------------------------------------------------------------------------*/
/* Modify By : Porntiwa P. A53-0362  11/11/2010
             : แก้ไข Insure Code
-------------------------------------------------------------------------------*/
/* Modify By : Porntiwa P. A54-0317  31/10/2011
             : 1. แก้ไข Insure Code เป็นค่าว่างกรณีมีเลขกรมธรรม์ต่ออายุถูกต้องแต่ไม่พบกรมธรรม์
               2. ปลดล๊อคการ Check เลขที่ตัวถังก่อนการนำเข้า
               3. กรณีโอนงานเข้า Premium ไฟล์ Confirm ให้เรียงตามเลขที่กรมธรรม์ที่นำเข้า
-------------------------------------------------------------------------------*/       
/* Modify By : Narin L. ขยาย Format ระบุชื่อผู้ขับขี่ [A54-0396]  
-------------------------------------------------------------------------------
  Modify By : Suthida T. A55-0064 20-04-12
            -> ปรับโปรแกรม Running Insure Branch 1 หลัก ถ้าเต็ม 7 หลัก
               แล้วให้ Running เป็น 10 หลัก
-------------------------------------------------------------------------------*/ 
Modify By : Porntiwa P.  A55-0235   03/08/2012
             1. เพิ่มเติมรายละเอียดช่อง Memo Text
             2. เพิ่มเติมการใช้ Campaign
             3. เพิ่มเติม Promotion
             4. เพิ่ม Cloumn งาน New & User Car "ธนาคารแถม"
             5. เพิ่ม Code Rebate Check ค่า Agent/Broker
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A54-0112  26/11/2012
           : เพิ่มเลขทะเบียนรถจาก 10 เป็น 11 หลัก   
           : ปรับ Agent/Broker ของงานต่ออายุให้ใช้จากค่าข้อมูลจากหน้าจอ       
------------------------------------------------------------------------*/
/* Modify By : Porntiwa P.   A56-0171  21/05/2013
             : ปรับ Insure Code Branch A;B เป็น Running Auto 10 หลัก
------------------------------------------------------------------------*/
/* Modify By : Porntiwa P.  A59-0070  29/03/2016
             : ปรับการนำเข้าโปรแกรม Thanachat                           */ 
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Modify by : Ranu I. A60-0327 27/07/2017 
            : ปรับเงื่อนไขการเช็ค Garage และให้ยึดเบี้ยตามไฟล์         */
/*---------------------------------------------------------------------*/
/* Modify by : Ranu I. A60-0383 11/09/2017 
            : เพิ่มการเก็บข้อมูล agent, producer, แคมเปญ ,เช็ค Class พรบ. จากเบี้ยพรบ.
              เช็คเลขบัตรประชาชน 13 หลัก */
/*Modify by : Ranu I. A60-0545 Date: 20/12/2017
            : เปลี่ยน format File แจ้งงานป้ายแดง   */      
/*Modify by : Ranu I. A61-0512 Date 05/11/2018 
             เพิ่มการเก็บข้อมูลใน Memo (F8)                 */      
/* Modify By : Porntiwa T. A62-0105  Date : 18/07/2019 : Change Host => TMSth*/ 
/* Modify by : Ranu I. A63-0174 แก้ไข Pack งานป้ายแดงและงานต่ออายุ   */                                                
/* Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/* Modify by : Ranu I. A64-0205 เพิ่มเงื่อนไขการเช็ค producer /Agent และเพิ่มงานต่ออายุTM เดิม */
/* Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by   : Kridtiya i. A66-0160 add color and campaign = Producer  */
/*---------------------------------------------------------------------*/
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
{wgw\wgwtagen.i} /*ประกาศตัวแปร*//*A53-0111*/
/*note add 08/11/05*/
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
/*end note add*/
DEF NEW SHARED VAR nv_riskno   LIKE  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   LIKE  sicuw.uwm301.itemno. 
DEF            VAR  nv_row  AS  INT  INIT  0.
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS INTE INIT 0.
DEF VAR nv_uom2_v AS INTE INIT 0.
DEF VAR nv_uom5_v AS INTE INIT 0.
DEF VAR nv_uom7_v AS INTE INIT 0.
DEF VAR chkred    AS logi INIT NO.

DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR . /*block for test assign a490166*/
DEF VAR nv_clmtext AS CHAR INIT  "".
DEF VAR n_renew    AS LOGI.
DEF VAR nv_massage AS CHAR .
DEF VAR nv_comper  AS DECI INIT 0.
DEF VAR nv_comacc  AS DECI INIT 0.
DEF VAR NO_prem2   AS INTE INIT 0.
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .
DEF NEW SHARED VAR nv_seat41 AS INTEGER FORMAT ">>9".
DEF NEW SHARED VAR nv_totsi  AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_polday AS INTE    FORMAT ">>9".
DEF New SHARED VAR nv_uom6_u AS CHAR.     /* Accessory  */
DEF VAR nv_chk AS  logic.

DEF NEW  SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".
DEF NEW  SHARED VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.

/*DEF NEW  SHARED VAR   nv_gapprm  AS DECI    FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.*/
DEF NEW  SHARED VAR  nv_gapprm  AS DECI    FORMAT ">>>,>>>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_gapprm1 AS DECI    FORMAT ">>>,>>>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_pdprm   AS DECI    FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_prvprm  AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR  nv_41prm   AS INTEGER FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.

DEF NEW  SHARED VAR  nv_ded1prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_aded1prm AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_ded2prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_dedod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_addod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_dedpd    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_prem1    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_addprm   AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_totded   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_totdis   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.

DEF NEW  SHARED VAR   nv_41cod1   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_41cod2   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_41       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_411prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_412prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_411var1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_411var2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_411var   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_412var1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_412var2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_412var   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_42cod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_42       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_42prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_42var1   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_42var2   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_42var    AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_43cod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_43       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_43prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_43var1   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_43var2   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_43var    AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_campcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_camprem   AS DECI      FORMAT ">>>9".
DEF NEW  SHARED VAR   nv_campvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_campvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_campvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_compcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_compprm   AS DECI      FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_compvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_compvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_compvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_basecod   AS CHAR      FORMAT "X(4)".
/*DEF NEW  SHARED VAR   nv_baseprm   AS DECI      FORMAT ">>,>>>,>>9.99-". */
DEF NEW  SHARED VAR   nv_baseprm   AS DECI      FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF NEW  SHARED VAR   nv_basevar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_basevar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_basevar   AS CHAR      FORMAT "X(60)".
/******** load ***********/
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
/*********** staff ***********/
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
/*********** dsic ***********/
DEF NEW  SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar  AS CHAR     FORMAT "X(60)".
/*********** NCB ***********/
DEF NEW  SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_ncbper   LIKE sicuw.uwm301.ncbper.
DEF NEW  SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncb1     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".
/***********fleet***********/
DEF NEW  SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEF NEW  SHARED VAR   nv_flet     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_fletvar1 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar2 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar  AS CHAR    FORMAT "X(60)".
/***********nv_comp***********/
DEF NEW  SHARED VAR  nv_vehuse LIKE sicuw.uwm301.vehuse.                 
DEF NEW  SHARED VAR  nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR  nv_grprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR  nv_grpvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR  nv_grpvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR  nv_grpvar  AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_othcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_othprm  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_othvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar  AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_dedod1_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod1_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod1var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var  AS CHAR   FORMAT "X(60)".            
                                                                        
DEF NEW  SHARED VAR   nv_dedod2_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod2_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod2var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var  AS CHAR   FORMAT "X(60)".            
                                                                     
DEF NEW  SHARED VAR   nv_dedpd_cod  AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedpd_prm  AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedpdvar1  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar2  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar   AS CHAR   FORMAT "X(60)".            
/*********usfbas************/
DEF NEW SHARED VAR nv_tariff  LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat  LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod  LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_class   AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_key_b   AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.

DEF NEW SHARED VAR   nv_drivno   AS INT       .
DEF NEW SHARED VAR   nv_drivcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_drivprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_drivvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar  AS CHAR  FORMAT "X(60)".
/*------usecod--------------------*/
DEF NEW SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
/*----------nv_sicod--------------*/
DEF NEW SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR   nv_uom6_c  AS CHAR.      /* Sum  si*/
DEF NEW SHARED VAR   nv_uom7_c  AS CHAR.      /* Fire/Theft*/
/*------------nv_bipcod-------------*/
DEF NEW SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
/*------------nv_biacod----------*/
DEF NEW SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
/*------------nv_pdacod------------*/
DEF NEW SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
/******** usoper **********/
DEF NEW SHARED VAR nv_engine LIKE sicsyac.xmm102.engine.
DEF NEW SHARED VAR nv_tons   LIKE sicsyac.xmm102.tons.
DEF NEW SHARED VAR nv_seats  LIKE sicsyac.xmm102.seats.
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".
DEF NEW SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".
DEF NEW SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".

DEF VAR  NO_CLASS AS CHAR INIT "".
DEF VAR no_tariff AS CHAR INIT "".
DEF  NEW  SHARED VAR  nv_poltyp   AS   CHAR   INIT  "".

DEF NEW SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_caryr   AS INTE  FORMAT ">>>9" .

DEF VAR s_recid1       AS RECID .     /* uwm100  */
DEF VAR s_recid2       AS RECID .     /* uwm120  */
DEF VAR s_recid3       AS RECID .     /* uwm130  */  
DEF VAR s_recid4       AS RECID .     /* uwm301  */                                    

DEF NEW SHARED  VAR nv_dspc      AS  DECI.
DEF NEW SHARED  VAR nv_mv1       AS  INT .
DEF NEW SHARED  VAR nv_mv1_s     AS  INT . 
DEF NEW SHARED  VAR nv_mv2       AS  INT . 
DEF NEW SHARED  VAR nv_mv3       AS  INT . 
DEF NEW SHARED  VAR nv_comprm    AS  INT .  
DEF NEW SHARED  VAR nv_model     AS  CHAR.  
/*DEF NEW SHARED  VAR n_Vehreg     AS  CHAR  FORMAT "X(10)".*//*Comment A54-0112*/
DEF NEW SHARED  VAR n_Vehreg    AS  CHAR  FORMAT "X(11)". /*A54-0112*/
DEF VAR nv_i AS INTE FORMAT "99".
/* ย้ายตัวแปรบางส่วนไปประกาศไว้ที่ wgwtagen.i เนื่องจาก Code เต็ม */

DEFINE VAR nv_deductdo   AS CHAR FORMAT "x(10)" INIT "" .  /*A54-0076*/
DEFINE VAR nv_engno      AS CHAR FORMAT "X(20)". /*A54-0317*/
DEFINE VAR nv_opnpol     AS CHAR FORMAT "X(100)". /*A55-0235*/
DEFINE VAR nv_bipp00     AS DECI FORMAT ">>,>>>,>>9.99-". /*A55-0235*/
DEFINE VAR nv_bipa00     AS DECI FORMAT ">>,>>>,>>9.99-". /*A55-0235*/
DEFINE VAR nv_bipd00     AS DECI FORMAT ">>,>>>,>>9.99-". /*A55-0235*/
DEFINE VAR nv_Camcode    AS CHAR FORMAT "X(20)". /*A55-0235*/
DEF    VAR nv_cover      AS CHAR FORMAT "x(2)" .
DEF VAR nv_ckaddr      AS CHAR  FORMAT "X(160)".
DEF VAR nv_chkexp   AS CHAR FORMAT "x(100)" . /*A64-0205*/
DEF VAR nv_ncnt     AS INT INIT 0 . /*A64-0205*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_camp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcampaign wdetail

/* Definitions for BROWSE br_camp                                       */
&Scoped-define FIELDS-IN-QUERY-br_camp wcampaign.cover wcampaign.campno wcampaign.pack wcampaign.nclass wcampaign.camp wcampaign.bi wcampaign.pd1 wcampaign.pd2 wcampaign.n41 wcampaign.n42 wcampaign.n43   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_camp   
&Scoped-define SELF-NAME br_camp
&Scoped-define QUERY-STRING-br_camp FOR EACH wcampaign
&Scoped-define OPEN-QUERY-br_camp OPEN QUERY br_camp FOR EACH wcampaign.
&Scoped-define TABLES-IN-QUERY-br_camp wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-br_camp wcampaign


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL.WARNING wdetail.poltyp wdetail.policy wdetail.renpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.access wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.drivnam1 wdetail.drivnam2 wdetail.drivbir1 wdetail.drivbir2 wdetail.drivage1 wdetail.drivage2 wdetail.producer wdetail.agent wdetail.comment wdetail.cancel wdetail.redbook wdetail.typreq   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_camp}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_camp fi_shown rapolicy fi_loaddat ~
fi_branch fi_package fi_producer fi_bchno fi_agent fi_prevbat fi_bchyr ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_campaign RECT-370 ~
RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_shown rapolicy fi_loaddat fi_branch ~
fi_package fi_producer fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt ~
fi_proname fi_agtname fi_completecnt fi_premtot fi_premsuc fi_campaign 

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
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_package AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_shown AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50.5 BY .62
     BGCOLOR 8 FGCOLOR 4 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rapolicy AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          " NEW ", 1,
" RENEW ", 2
     SIZE 27.67 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 11.91
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 6.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 3.57
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
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 106 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_camp FOR 
      wcampaign SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_camp C-Win _FREEFORM
  QUERY br_camp DISPLAY
      wcampaign.cover COLUMN-LABEL "Cover"  FORMAT "x(3)"
wcampaign.campno COLUMN-LABEL "Garage" FORMAT "x(2)"
wcampaign.pack  COLUMN-LABEL "Pack " FORMAT "x(1)"
wcampaign.nclass COLUMN-LABEL "Class" FORMAT "x(3)"
wcampaign.camp   COLUMN-LABEL "Campagin" FORMAT "x(15)"
wcampaign.bi   column-label "BI " format "x(10)"
wcampaign.pd1  column-label "PD1 " format "x(10)"
wcampaign.pd2  column-label "PD2 " format "x(10)"
wcampaign.n41  column-label "N41 " format "x(10)"
wcampaign.n42  column-label "N42 " format "x(10)"
wcampaign.n43  column-label "N43 " format "x(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 28.67 BY 4.81
         BGCOLOR 28 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL.WARNING   COLUMN-LABEL "Warning"
      wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.renpol  COLUMN-LABEL "Renew Policy"
        wdetail.tiname  COLUMN-LABEL "Title Name"   
        wdetail.insnam  COLUMN-LABEL "Insured Name" 
        wdetail.comdat  COLUMN-LABEL "Comm Date"
        wdetail.expdat  COLUMN-LABEL "Expiry Date"
        wdetail.compul  COLUMN-LABEL "Compulsory"

        wdetail.iadd1   COLUMN-LABEL "Ins Add1"
        wdetail.iadd2   COLUMN-LABEL "Ins Add2"
        wdetail.iadd3   COLUMN-LABEL "Ins Add3"
        wdetail.iadd4   COLUMN-LABEL "Ins Add4"
        wdetail.prempa  COLUMN-LABEL "Premium Package"
        wdetail.subclass COLUMN-LABEL "Sub Class" FORMAT "x(4)"
        wdetail.brand   COLUMN-LABEL "Brand"
        wdetail.model   COLUMN-LABEL "Model"
        wdetail.cc      COLUMN-LABEL "CC"
        wdetail.weight  COLUMN-LABEL "Weight"
        wdetail.seat    COLUMN-LABEL "Seat"
        wdetail.body    COLUMN-LABEL "Body"
        wdetail.vehreg  COLUMN-LABEL "Vehicle Register"
        wdetail.engno   COLUMN-LABEL "Engine NO."
        wdetail.chasno  COLUMN-LABEL "Chassis NO."
        wdetail.caryear COLUMN-LABEL "Car Year" 
        wdetail.carprovi COLUMN-LABEL "Car Province"
        wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
        wdetail.garage  COLUMN-LABEL "Garage"
        wdetail.stk     COLUMN-LABEL "Sticker"
        wdetail.access  COLUMN-LABEL "Accessories"
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.volprem COLUMN-LABEL "Voluntory Prem"
        wdetail.Compprem COLUMN-LABEL "Compulsory Prem"
        wdetail.benname COLUMN-LABEL "Benefit Name" 
        wdetail.n_user  COLUMN-LABEL "User"
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.drivnam  COLUMN-LABEL "Driver Name"
        wdetail.drivnam1 COLUMN-LABEL "Driver Name1"
        wdetail.drivnam2 COLUMN-LABEL "Driver Name2"
        wdetail.drivbir1 COLUMN-LABEL "Driver Birth1"
        wdetail.drivbir2 COLUMN-LABEL "Driver Birth2"
        wdetail.drivage1 COLUMN-LABEL "Driver Age1"
        wdetail.drivage2 COLUMN-LABEL "Driver Age2"
        
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        wdetail.cancel  COLUMN-LABEL "Cancel"
        wdetail.redbook COLUMN-LABEL "RedBook"  
        wdetail.typreq COLUMN-LABEL "Vat Code"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 120.5 BY 5
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_camp AT ROW 5.19 COL 96.83
     fi_shown AT ROW 20.29 COL 35.83 COLON-ALIGNED NO-LABEL
     rapolicy AT ROW 3.14 COL 97.83 NO-LABEL
     fi_loaddat AT ROW 4.19 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 5.24 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_package AT ROW 4.05 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 6.29 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.29 COL 16.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 7.33 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.38 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.38 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.43 COL 28.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.43 COL 92.67
     fi_output1 AT ROW 10.48 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.52 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.57 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.62 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.62 COL 74.33 NO-LABEL
     buok AT ROW 10.48 COL 104.5
     bu_exit AT ROW 12.29 COL 104.67
     fi_brndes AT ROW 5.1 COL 49.33 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.24 COL 4.5
     bu_hpbrn AT ROW 5.19 COL 37.83
     bu_hpacno1 AT ROW 6.29 COL 46.67
     fi_impcnt AT ROW 21.71 COL 62.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 7.33 COL 46.67
     fi_proname AT ROW 6.19 COL 49.33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 7.29 COL 49.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.71 COL 62.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.71 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.76 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_campaign AT ROW 4.05 COL 105.17 COLON-ALIGNED NO-LABEL
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY 1.05 AT ROW 5.19 COL 20.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.29 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 13.62 COL 93
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 13.62 COL 28.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11.33 BY .62 AT ROW 4.29 COL 95.67
          BGCOLOR 8 FGCOLOR 1 
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY 1.05 AT ROW 6.29 COL 12.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR THANACHAT (MOTOR LINE 70/72)" VIEW-AS TEXT
          SIZE 122 BY .95 AT ROW 1.71 COL 3.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 13.62 COL 73.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 11.43 COL 6.17
          BGCOLOR 8 FGCOLOR 1 
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.48 COL 10.17
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 23.81
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package Renew :" VIEW-AS TEXT
          SIZE 17.67 BY .62 AT ROW 4.33 COL 50.83
          BGCOLOR 8 FGCOLOR 1 
     "  15/08/2023":60 VIEW-AS TEXT
          SIZE 19 BY .81 AT ROW 13.81 COL 103.5 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 62 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 7.33 COL 15.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY 1.05 AT ROW 8.33 COL 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1.05 AT ROW 4.14 COL 17.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 12.57 COL 11.67
          BGCOLOR 8 FGCOLOR 1 
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 9.38 COL 6.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 62 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Type  :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1 AT ROW 4.19 COL 17.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1.05 AT ROW 8.38 COL 66.66 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1.33 COL 2.5
     RECT-372 AT ROW 2.91 COL 2.5
     RECT-373 AT ROW 14.81 COL 2.5
     RECT-374 AT ROW 21 COL 2.5
     RECT-375 AT ROW 21.24 COL 4
     RECT-376 AT ROW 21.48 COL 5.5
     RECT-377 AT ROW 10.19 COL 103.5
     RECT-378 AT ROW 12 COL 103.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 23.81
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
         TITLE              = "Load Excel File Thanachat To GW"
         HEIGHT             = 23.86
         WIDTH              = 127.33
         MAX-HEIGHT         = 46.1
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.1
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
/* BROWSE-TAB br_camp 1 fr_main */
/* BROWSE-TAB br_wdetail fi_brndes fr_main */
ASSIGN 
       br_camp:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

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
          SIZE 12.83 BY 1.05 AT ROW 8.38 COL 66.66 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 13.62 COL 28.33 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 13.62 COL 73.17 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 62 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 62 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_camp
/* Query rebuild information for BROWSE br_camp
     _START_FREEFORM
OPEN QUERY br_camp FOR EACH wcampaign.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_camp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Excel File Thanachat To GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Excel File Thanachat To GW */
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
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.renpol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.compul:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  

          wdetail.iadd1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd3:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd4:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.brand:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.cc:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.weight:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.vehreg:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.engno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.chasno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.caryear:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.carprovi:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.access:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.Compprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_user:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.drivnam1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivage1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivage2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.typreq:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
   
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.renpol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.compul:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  

          wdetail.iadd1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd4:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.brand:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cc:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.weight:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.engno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.carprovi:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.volprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.Compprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_user:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.drivnam1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivage1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivage2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.typreq:BGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
            
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0.

    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.

    /*chk first */
    IF fi_branch = " " THEN DO: /*note add 10/11/2005*/
         MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
         APPLY "entry" TO fi_branch.
         RETURN NO-APPLY.
    END. /*end note add 10/11/2005*/

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
    /***---a490166 ---***/
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    /*---- Comment A53-0111 renew ---
    IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END.
    IF fi_usrprem <= 0  THEN DO:
        MESSAGE "Total Net Premium can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrprem.
        RETURN NO-APPLY.
    END.
    --- End Comment ---*/
    /***---a490166 ---***/
    ASSIGN
        fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.

    IF fi_output1 = "" THEN DO:
      MESSAGE "Please Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output1.
      RETURN NO-APPLY.
    END.

    IF fi_output2 = "" THEN DO:
      MESSAGE "Please Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output2.
      RETURN NO-APPLY.
    END.

    IF fi_output3 = "" THEN DO:
      MESSAGE "Please Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output3.
      RETURN NO-APPLY.
    END.

    nv_batchyr = INPUT fi_bchyr.
    
    /*--- Batch No ---*/
    IF nv_batprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */

      FIND LAST uzm700 USE-INDEX uzm70001
          WHERE uzm700.acno    = TRIM(fi_producer)  AND
                uzm700.branch  = TRIM(nv_batbrn) AND
                uzm700.bchyr = nv_batchyr
      NO-LOCK NO-ERROR .
      IF AVAIL uzm700 THEN DO:   /*ได้ running 4 หลักหลัง Branch */

        nv_batrunno = uzm700.runno.

        FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
            WHERE uzm701.bchno = TRIM(fi_producer) + TRIM(nv_batbrn) + STRING(nv_batrunno,"9999") 
        NO-LOCK NO-ERROR.
        IF AVAIL uzm701 THEN DO:

          nv_batcnt = uzm701.bchcnt .
          nv_batrunno = nv_batrunno + 1.

        END.
      END.
      ELSE DO:  /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
        ASSIGN
          nv_batcnt = 1
          nv_batrunno = 1.
      END.

      nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").

    END.
    ELSE DO:  /* ระบุ batch file เดิมที่เคยนำเข้าแล้ว */
      nv_batprev = INPUT fi_prevbat.

      FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
          WHERE uzm701.bchno = CAPS(nv_batprev)
      NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL uzm701 THEN DO:
        MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
              + " on file uzm701" .
        APPLY "entry" TO fi_prevbat.
        RETURN NO-APPLY.
      END.
      IF AVAIL uzm701 THEN DO:
        nv_batcnt  = uzm701.bchcnt + 1.
        nv_batchno = CAPS(TRIM(nv_batprev)).

      END.
    END.
    /*----------------*/

    /*end chk first*/
    ASSIGN
         fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
         fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
         /*a490166*/
         fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
         fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
         nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
         nv_tmppolrun = 0                    nv_daily        = ""
         nv_reccnt    = 0                    nv_completecnt  = 0
         nv_netprm_t  = 0                    nv_netprm_s     = 0
         nv_batbrn    = fi_branch .

    RUN PROC_GENDATA.

    FOR EACH wdetail:    
        IF WDETAIL.POLTYP = "70" OR WDETAIL.POLTYP = "72" THEN DO:
            ASSIGN
            nv_reccnt      =  nv_reccnt   + 1
            nv_netprm_t    =  nv_netprm_t + DECIMAL(wdetail.prem_t) 
            wdetail.pass   = "Y"
            WDETAIL.POLTYP = "V" + WDETAIL.POLTYP.     
        END.
        ELSE DO :    
            DELETE WDETAIL.
        END.
    END.
    
    /***--- ไมมี Record ไม่ Run Batch ---***/
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /* comment by :Ranu I. A64-0205 ....
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
    ... end A64-0205 */
    /***---A490166 Run Batch No. ---***/ 
    RUN wgw\wgwbatch.p    (INPUT        fi_loaddat ,     /* DATE  */
                           INPUT        nv_batchyr ,     /* INT   */
                           INPUT        fi_producer,     /* CHAR  */ 
                           INPUT        nv_batbrn  ,     /* CHAR  */
                           INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT        "WGWTAGEN" ,     /* CHAR  */
                           INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                           INPUT        nv_imppol  ,     /* INT   */
                           INPUT        nv_impprem       /* DECI  */
                           ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    
    DISP  fi_bchno   WITH FRAME fr_main.
    
    RUN proc_chktest1.

    fi_shown = "Data Complete".
    DISP fi_shown WITH FRAME fr_main.

    FOR EACH wdetail WHERE wdetail.pass = "y"  :
        ASSIGN
         nv_completecnt = nv_completecnt + 1
         nv_netprm_s    = nv_netprm_s    + DECIMAL(wdetail.prem_t) . 
    END.
    
    /***--- start a490166 ---***/

    /***------------ update ข้อมูลที่  uzm701 ------------***/
    /*note เอง*/
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 

    /*--- Check Record ---*/
    /*---- A53-0111 ---
    IF nv_imppol <> nv_rectot OR
       nv_imppol <> nv_recsuc OR
       nv_rectot <> nv_recsuc THEN
       nv_batflg = NO.
    ELSE /*--- Check Premium ---*/
    IF nv_impprem  <> nv_netprm_t OR
       nv_impprem  <> nv_netprm_s OR
       nv_netprm_t <> nv_netprm_s THEN
        nv_batflg = NO.
    ELSE 
        nv_batflg = YES.
   ---- End Comment ---*/

    IF /*nv_imppol <> nv_rectot OR
       nv_imppol <> nv_recsuc OR*/
       nv_rectot <> nv_recsuc THEN
       nv_batflg = NO.
    ELSE /*--- Check Premium ---*/
    IF /*nv_impprem  <> nv_netprm_t OR
       nv_impprem  <> nv_netprm_s OR*/
       nv_netprm_t <> nv_netprm_s THEN
        nv_batflg = NO.
    ELSE 
        nv_batflg = YES.

    FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10009 ---> uzm70102 31/10/2006*/
        WHERE uzm701.bchyr = nv_batchyr AND
              uzm701.bchno = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt 
    NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
        /*uzm701.rec_suc     = nv_recsuc */  /***--- 26-10-2006 change field Name ---***/
          uzm701.recsuc      = nv_recsuc     /***--- 31-10-2006 change field Name ---***/
          uzm701.premsuc     = nv_netprm_s   /*nv_premsuc*/
          
        /*uzm701.rec_tot     = nv_rectot*/   /***--- 26-10-2006 change field Name ---***/
          uzm701.rectot      = nv_rectot     /***--- 26-10-2006 change field Name ---***/
          uzm701.premtot     = nv_netprm_t   /*nv_premtot*/
          
        /*uzm701.sucflg1     = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.impflg      = nv_batflg    /***--- 26-10-2006 change field Name ---***/
        /*uzm701.batchsta    = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.cnfflg      = nv_batflg    
         /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
            NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */
          .
    END.
    /***---------- END update ข้อมูลที่  uzm701 ---------***/
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .

    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    
    /*--- ปลดล็อค Database ---*/
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE brstat.detaitem.
    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp. /*A54-0076*/
    /*A64-0138*/
    /***--- a490166 05/10/2006 ---***/
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
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
    /*A64-0138*/
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    /*output*/
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
/*/*A64-0138*/
    /*--- ปลดล็อค Database ---*/
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE brstat.detaitem.

    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp. /*A54-0076*/
/*A64-0138*/*/
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
       
       FILTERS     "CSV (Comma Delimited)"   "*.csv",
                   "Data Files (*.dat)"     "*.dat",
                   "Data Files (*.txt)"     "*.txt"
                            
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
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
         sicsyac.xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" 
             VIEW-AS ALERT-BOX.
             APPLY "Entry" To  fi_agent.
             RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
            fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
            fi_agent   =  CAPS(INPUT  fi_agent) /*note modi 08/11/05*/
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
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


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
  fi_Campaign = CAPS(INPUT fi_Campaign).
  DISP fi_Campaign WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON RETURN OF fi_campaign IN FRAME fr_main
DO:
  fi_Campaign = CAPS(INPUT fi_Campaign).
  DISP fi_Campaign WITH FRAME fr_main.
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


&Scoped-define SELF-NAME fi_package
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_package C-Win
ON LEAVE OF fi_package IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_package C-Win
ON RETURN OF fi_package IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. /*nv_batprev <> " "*/
    
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  IF  fi_producer <> " " THEN DO:
  FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
       sicsyac.xmm600.acno  =  Input fi_producer  
  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
                Apply "Entry" To  fi_producer.
                RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO:
                ASSIGN
                fi_proname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer) /*note modi 08/11/05*/
                nv_producer = fi_producer .             /*note add  08/11/05*/
                
            END.
  END.

  Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt C-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem C-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rapolicy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rapolicy C-Win
ON LEAVE OF rapolicy IN FRAME fr_main
DO:
  rapolicy = 1.
  rapolicy = INPUT rapolicy.

  /* Add by : A64-0278...*/
  IF rapolicy = 1 THEN DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      DISP "B3MLTTB201" @ fi_Producer WITH FRAME fr_main. 
      DISP "B3MLTTB200" @ fi_agent    WITH FRAME fr_main.  
  END.
  ELSE DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      DISP "B3MLTTB101" @ fi_Producer WITH FRAME fr_main.   
      DISP "B3MLTTB100" @ fi_agent    WITH FRAME fr_main.   
  END.
  /*... end A64-0278...*/
  /* comment by : A64-0278...
  IF rapolicy = 1 THEN DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      /*DISP "A0M0039" @ fi_Producer WITH FRAME fr_main.*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      DISP "B3MLTMB201" @ fi_Producer WITH FRAME fr_main.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      /*DISP "B300303" @ fi_agent    WITH FRAME fr_main.*/
      /*DISP "B3M0055" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
      DISP "B3MLTMB200" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
  END.
  ELSE DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      /*DISP "A0M0049" @ fi_Producer WITH FRAME fr_main.*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      DISP "B3MLTMB101" @ fi_Producer WITH FRAME fr_main.    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
      DISP "B3M0004"    @ fi_agent    WITH FRAME fr_main.    /*A63-0174*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      DISP "B3MLTMB100" @ fi_agent    WITH FRAME fr_main.    /*A63-0174*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
  END.
  ... end A64-0278...*/

  fi_branch = INPUT fi_branch.
  fi_Producer = INPUT fi_Producer.
  fi_agent  = INPUT fi_agent.

  fi_producer = INPUT fi_producer.
  IF  fi_producer <> " " THEN DO:
  FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
       sicsyac.xmm600.acno  =  Input fi_producer  
  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
                Apply "Entry" To  fi_producer.
                RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO:
                ASSIGN
                fi_proname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  CAPS(INPUT  fi_producer) /*note modi 08/11/05*/
                nv_producer = fi_producer .             /*note add  08/11/05*/
                
            END.
  END.

  DISP  fi_producer  fi_proname  WITH FRAME  fr_main.   

  fi_agent = INPUT fi_agent.
  IF fi_agent <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
         sicsyac.xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             MESSAGE  "Not on Name & Address Master File xmm600" 
             VIEW-AS ALERT-BOX.
             APPLY "Entry" To  fi_agent.
             RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
            fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
            fi_agent   =  CAPS(INPUT  fi_agent) /*note modi 08/11/05*/
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
  END. /*Then fi_agent <> ""*/
    
  DISP  fi_agent  fi_agtname  WITH FRAME  fr_main.     

  IF  Input fi_branch  =  ""  THEN DO:
       MESSAGE "กรุณาระบุ Branch Code ." VIEW-AS ALERT-BOX.
       APPLY "Entry"  TO  fi_branch.
  END.
  ELSE DO:
  FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
       sicsyac.xmm023.branch   =  INPUT  fi_branch 
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
               MESSAGE  "Not on Description Master File xmm023" 
               VIEW-AS ALERT-BOX.
               APPLY "Entry"  To  fi_branch.
               RETURN NO-APPLY.
        END.
  fi_branch  =  CAPS(INPUT fi_branch) .
  fi_brndes  =  sicsyac.xmm023.bdes.
  END. /*else do:*/

  DISP fi_branch  fi_brndes  WITH FRAME  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rapolicy C-Win
ON VALUE-CHANGED OF rapolicy IN FRAME fr_main
DO:
  rapolicy = 1.
  rapolicy = INPUT rapolicy.

  /* add by : A64-0278 */
  IF rapolicy = 1 THEN DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      DISP "B3MLTTB201" @ fi_Producer WITH FRAME fr_main. 
      DISP "B3MLTTB200" @ fi_agent    WITH FRAME fr_main.  

  END.
  ELSE DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      DISP "B3MLTTB101" @ fi_Producer WITH FRAME fr_main. 
      DISP "B3MLTTB100" @ fi_agent    WITH FRAME fr_main. 
  END.
  /*....end A64-0278..*/
 /* comment by : A64-0278...
  IF rapolicy = 1 THEN DO:
      DISP "M" @ fi_branch WITH FRAME fr_main.
      /*DISP "A0M0039" @ fi_Producer WITH FRAME fr_main.*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      DISP "B3MLTMB201" @ fi_Producer WITH FRAME fr_main.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      /*DISP "B300303" @ fi_agent    WITH FRAME fr_main.*/
      /*DISP "B3M0055" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/       
      DISP "B3MLTMB200" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/       

  END.
  ELSE DO:
      /*RUN wgw\wgwlogex.*/
      DISP "M" @ fi_branch WITH FRAME fr_main.
      /*DISP "A0M0049" @ fi_Producer WITH FRAME fr_main.*//*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
      DISP "B3MLTMB101" @ fi_Producer WITH FRAME fr_main.    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    

      /*DISP "B3M0004"    @ fi_agent    WITH FRAME fr_main.*/          /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      DISP "B3MLTMB100" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
  END.
  ....end A64-0278..*/

  fi_branch = INPUT fi_branch.
  fi_Producer = INPUT fi_Producer.
  fi_agent  = INPUT fi_agent.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_camp
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

SESSION:SUPPRESS-WARNINGS = YES.
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwtagen".
  gv_prog  = "Load Excle & Generate Thanachat".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
  fi_producer = ""
  fi_agent    = ""
  fi_bchyr    = YEAR(TODAY)
  fi_package   = "PACK RENEW" /*a63-0174*/
  fi_campaign = "TNC_COVER" . /*A60-0383*/
  RUN proc_campaign. /*A60-0383*/
  DISP fi_producer fi_agent fi_bchyr fi_campaign br_camp fi_package WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.
   

  fi_branch = INPUT fi_branch.
  fi_Producer = INPUT fi_Producer.
  fi_agent  = INPUT fi_agent.
 
  DISP "M" @ fi_branch WITH FRAME fr_main.
  /*DISP "A0M0039" @ fi_Producer WITH FRAME fr_main.*/  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
  /*DISP "B3MLTMB201" @ fi_Producer WITH FRAME fr_main.   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/*/ /*A64-0278*/
  /*DISP "B300303" @ fi_agent    WITH FRAME fr_main.*/  /*A63-0174*/
  /*DISP "B3M0055" @ fi_agent    WITH FRAME fr_main.    /*A63-0174*/*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
  /*DISP "B3MLTMB200" @ fi_agent    WITH FRAME fr_main. /*A63-0174*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/*/ /*A64-0278*/   
  DISP "B3MLTTB201" @ fi_Producer WITH FRAME fr_main. /*A64-0278*/
  DISP "B3MLTTB200" @ fi_agent    WITH FRAME fr_main. /*A64-0278*/
  APPLY "ENTRY" TO rapolicy IN FRAME fr_main.

  fi_branch = "".
  fi_Producer = "".
  fi_agent  = "".

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
  DISPLAY fi_shown rapolicy fi_loaddat fi_branch fi_package fi_producer fi_bchno 
          fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname 
          fi_agtname fi_completecnt fi_premtot fi_premsuc fi_campaign 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_camp fi_shown rapolicy fi_loaddat fi_branch fi_package fi_producer 
         fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 
         fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_campaign RECT-370 RECT-372 RECT-373 
         RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcCampaign C-Win 
PROCEDURE ProcCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Assign A55-0235      
  - กรณี Seat มีการ Set ค่าไว้ที่ Campaign ให้ดึงค่า Seat จาก Campaign
  - กรณี มีการ Set Base Premium ไว้ที่ Campaign ให้ดึงค่า Base จาก Campaign
  - กรณี มีการ Set Dspc ไว้ที่ Campaign ให้ดึงค่า Dscp จาก Campaign
  *** หากไม่มีการ Set ไว้ให้ดึงค่าปกติ ทั้งนี้การดึงค่า campaign ต้องเป็นงาน New 
      หากเป็นงาน User Car หรืองาน Renew ให้ดึงค่าปกติไม่ดึงจาก Campaign ***
------------------------------------------------------------------------------*/
ASSIGN
    nv_bipp00 = 0
    nv_bipa00 = 0
    nv_bipd00 = 0.

IF CAN-FIND(FIRST brstat.campaign) THEN DO:
     FIND FIRST brstat.campaign WHERE 
                TRIM(SUBSTRING(brstat.campaign.tltc,INDEX(brstat.campaign.tltc,"|") + 1,4)) = wdetail.subclass AND
                brstat.campaign.makdes = wdetail.brand    AND
                wdetail.Model MATCHES "*" + brstat.campaign.moddes + "*" AND
                brstat.campaign.effdat <= DATE(wdetail.comdat)  NO-LOCK NO-ERROR.
     IF AVAIL brstat.campaign THEN DO:
         ASSIGN
             wdetail.seat41   = brstat.campaign.mv1s
             wdetail.baseprem = brstat.campaign.baseprm
             nv_dss_per       = brstat.campaign.dspc.

         IF INDEX(brstat.campaign.tltc,"|") <> 0 THEN
             nv_Camcode = TRIM(SUBSTRING(brstat.campaign.tltc,1,INDEX(brstat.campaign.tltc,"|") - 1)).
         ELSE
             nv_camcode = "".

         FIND FIRST brstat.clastab_fil USE-INDEX clastab01 WHERE
                    brstat.clastab_fil.class  = brstat.campaign.class  AND
                    brstat.clastab_fil.covcod = brstat.campaign.covcod AND
                    brstat.clastab_fil.Tariff = "X" NO-LOCK NO-ERROR.
         IF AVAIL brstat.clastab_fil THEN DO:
             ASSIGN
                 WDETAIL.no_41    = brstat.clastab_fil.si_41unp
                 WDETAIL.no_42    = brstat.clastab_fil.si_42
                 WDETAIL.no_43    = brstat.clastab_fil.si_43
                 nv_bipp00        = brstat.clastab_fil.uom1_si
                 nv_bipa00        = brstat.clastab_fil.uom2_si
                 nv_bipd00        = brstat.clastab_fil.uom5_si
                 wdetail.prempa   = SUBSTRING(brstat.clastab_fil.class,1,1)
                 wdetail.subclass = SUBSTRING(brstat.clastab_fil.class,2,3)
                 wdetail.seat41   = brstat.clastab_fil.dri_41 + brstat.clastab_fil.pass_41.
     
         END.
         ELSE DO:
             ASSIGN
                 WDETAIL.no_41    = 0
                 WDETAIL.no_42    = 0
                 WDETAIL.no_43    = 0
                 /*wdetail.seat41   = 0*/
                 nv_bipp00        = 0
                 nv_bipa00        = 0
                 nv_bipd00        = 0
                 wdetail.prempa   = wdetail.prempa
                 wdetail.subclass = wdetail.subclass
                 /*wdetail.baseprem = 0*/.
         END.
     END.
     ELSE DO:
         ASSIGN
             WDETAIL.no_41    = 0
             WDETAIL.no_42    = 0
             WDETAIL.no_43    = 0
             wdetail.seat41   = 0
             nv_bipp00        = 0
             nv_bipa00        = 0
             nv_bipd00        = 0
             wdetail.prempa   = wdetail.prempa
             wdetail.subclass = wdetail.subclass
             wdetail.baseprem = 0
             nv_Camcode       = "".
     END.
END.
ELSE DO:
    ASSIGN
        WDETAIL.no_41    = 0
        WDETAIL.no_42    = 0
        WDETAIL.no_43    = 0
        wdetail.seat41   = 0
        nv_bipp00        = 0
        nv_bipa00        = 0
        nv_bipd00        = 0
        wdetail.prempa   = wdetail.prempa
        wdetail.subclass = wdetail.subclass
        wdetail.baseprem = 0
        nv_Camcode       = "".
END.

IF wdetail.prempa = "" THEN wdetail.prempa   = wdetail.prempa.
IF wdetail.subclass = "" THEN wdetail.subclass = wdetail.subclass.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72 C-Win 
PROCEDURE Proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Check Compusory" + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
/************** v72 comp y **********/
ASSIGN
    wdetail.tariff   = "9"
    wdetail.covcod   = "T". 
IF wdetail.poltyp = "V72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN /*a490166*/
            wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
            wdetail.pass    = "N"
            WDETAIL.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                wdetail.pass    = ""
                WDETAIL.OK_GEN  = "N".
            /*--end amparat C. A51-0253--*/
    END.    
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =  wdetail.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "V72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Type นี้"
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
    sicsyac.xmm106.class   = wdetail.subclass /*"110"*//*A53-0111*/ AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
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
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.

IF wdetail.pass <> "N" THEN
        ASSIGN wdetail.comment = "COMPLETE"
               WDETAIL.WARNING = ""
               wdetail.pass    = "Y".

/*--- Add Renew A53-0111 ---*/
FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
END.
/*--- End Add Renew A53-0111 ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_722 C-Win 
PROCEDURE Proc_722 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Update Detaitem" + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
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
IF NOT AVAILABLE sic_bran.uwm130 THEN 
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
            nv_comper     = DECI(sicsyac.xmm016.si_d_t[8]) 
            nv_comacc     = DECI(sicsyac.xmm016.si_d_t[9])                                           
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
    s_recid3  = RECID(sic_bran.uwm130).
    /*---------------  U W M 3 0 1 --------------*/ 
    nv_covcod =   wdetail.covcod.
    nv_makdes  =  wdetail.brand.
    nv_moddes  =  wdetail.model.
    /*--Str Amparat C. A51-0253--*/
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
    /*--End Amparat C. A51-0253--*/       
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
        END. /*transaction*/
    END.                                                          
    ASSIGN            /*a490166 ใช้ร่วมกัน*/
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = nv_covcod
        sic_bran.uwm301.cha_no   = wdetail.chasno
        sic_bran.uwm301.eng_no   = wdetail.engno
        sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine   = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = "" /*wdetail.garage*/
        sic_bran.uwm301.body     = wdetail.body
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg /*+ nv_provi*//*A53-0111*/
        sic_bran.uwm301.trareg    = nv_uwm301trareg
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.vehgrp   = wdetail.cargrp
        /*sic_bran.uwm301.moddes   = wdetail.model    */  /*A63-00472*/
        sic_bran.uwm301.moddes   = trim(wdetail.Brand) + " " + trim(wdetail.model)          /*A63-00472*/
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt         /* bchcnt     */  
        sic_bran.uwm301.car_color = wdetail.ncolor  .  /*A66-0160*/
    /*-----compul-----*/
    IF wdetail.compul = "y" AND wdetail.poltyp = "V72" THEN DO:
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
        /*--- Comment A53-0362 --
        /*--create detaitem--*/
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
            brStat.Detaitem.serailno   = wdetail.stk   NO-ERROR NO-WAIT.
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
        --- End Comment A530362 ----*/ 
        RUN Proc_detaitem.  /*-- Add A53-0362 --*/
    END.
    ELSE sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    /***--- modi by note a490166 ---***/
    IF wdetail.redbook <> "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
             sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod       = sicsyac.xmm102.modcod
                SUBSTRING(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                SUBSTRING(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                sic_bran.uwm301.Tons         = sicsyac.xmm102.tons
                sic_bran.uwm301.engine       = sicsyac.xmm102.engine
                sic_bran.uwm301.moddes       = sicsyac.xmm102.modest
                sic_bran.uwm301.seats        = sicsyac.xmm102.seats
                sic_bran.uwm301.vehgrp       = sicsyac.xmm102.vehgrp
                wdetail.weight               = STRING(sicsyac.xmm102.tons)
                wdetail.cc                   = STRING(sicsyac.xmm102.engine)
                wdetail.seat                 = STRING(sicsyac.xmm102.seats)
                wdetail.redbook              = sicsyac.xmm102.modcod
                wdetail.brand                = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model                = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.
        ELSE DO:  /*A63-00472*/
            /*FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                      stat.maktab_fil.sclass = SUBSTRING(wdetail.subclass,2,3) AND*/
            FIND LAST  stat.maktab_fil WHERE 
                stat.maktab_fil.modcod = wdetail.redbook NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.maktab_fil THEN DO:
               ASSIGN
               sic_bran.uwm301.modcod  = stat.maktab_fil.modcod                                    
               /*sic_bran.uwm301.moddes  = trim(wdetail.Brand) + " " + trim(wdetail.model)*/ 
               sic_bran.uwm301.vehgrp  = stat.maktab_fil.prmpac
               sic_bran.uwm301.body    = stat.maktab_fil.body  
               sic_bran.uwm301.Tons    = stat.maktab_fil.tons  
               sic_bran.uwm301.engine  = stat.maktab_fil.engine 
               sic_bran.uwm301.seats   = stat.maktab_fil.seats   
               wdetail.weight          = STRING(stat.maktab_fil.tons)  
               wdetail.cc              = STRING(stat.maktab_fil.engine)
               wdetail.seat            = STRING(stat.maktab_fil.seats) 
                   .
           END.
        END.   /*A63-00472*/
    END.
    ELSE DO:
        FIND LAST sicsyac.xmm102 WHERE 
            sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
            sicsyac.xmm102.engine = INTE(wdetail.cc) AND 
            sicsyac.xmm102.tons   = INTE(wdetail.weight) AND
            sicsyac.xmm102.seats  = INTE(wdetail.seat)
            NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod      = sicsyac.xmm102.modcod
                SUBSTRING(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                SUBSTRING(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                sic_bran.uwm301.Tons        = sicsyac.xmm102.tons
                sic_bran.uwm301.engine      = sicsyac.xmm102.engine
                sic_bran.uwm301.moddes      = sicsyac.xmm102.modest
                sic_bran.uwm301.seats       = sicsyac.xmm102.seats
                sic_bran.uwm301.vehgrp      = sicsyac.xmm102.vehgrp
                wdetail.weight              = STRING(sicsyac.xmm102.tons)  
                wdetail.cc                  = STRING(sicsyac.xmm102.engine)
                wdetail.seat                = STRING(sicsyac.xmm102.seats)
                wdetail.redbook             = sicsyac.xmm102.modcod
                wdetail.brand               = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model               = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.
    END.
    /*add A52-0172*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_723 C-Win 
PROCEDURE Proc_723 :
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
       sicsyac.xmm107.class  = wdetail.subclass   AND
       sicsyac.xmm107.tariff = wdetail.tariff
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE sicsyac.xmm107 THEN DO:
      FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE sicsyac.xmd107 THEN DO:
         CREATE sic_bran.uwd132.

         FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
              sicsyac.xmm016.class = wdetail.subclass
         NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL sicsyac.xmm016 THEN DO:
            sic_bran.uwd132.gap_ae = NO.
            sic_bran.uwd132.pd_aep = "E".
         END.

         ASSIGN 
             sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   
             sic_bran.uwd132.policy = wdetail.policy
             sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  
             sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
             sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp  
             sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
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
              sicsyac.xmm105.tariff = wdetail.tariff  AND
              sicsyac.xmm105.bencod = sicsyac.xmd107.bencod 
         NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
         ELSE DO:
             ASSIGN
                wdetail.comment = wdetail.comment + "| ไม่พบ Tariff ที่ xmm105"
                wdetail.OK_GEN  = "N"
                wdetail.pass    = "N".
           /*MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.*//*Comment A54-0076*/
         END.

         IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
             IF           wdetail.subclass      = "110" THEN nv_key_a = INTE(wdetail.cc).
             ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = INTE(wdetail.seat).
             ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = INTE(wdetail.cc).
             ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = INTE(wdetail.weight).
     
             nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
     
             FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601          WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff    AND 
                        sicsyac.xmm106.bencod  = uwd132.bencod     AND 
                        sicsyac.xmm106.class   = wdetail.subclass  AND 
                        sicsyac.xmm106.covcod  = wdetail.covcod    AND 
                        sicsyac.xmm106.key_a  >= nv_key_a          AND 
                        sicsyac.xmm106.key_b  >= nv_key_b          AND 
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
             NO-LOCK NO-ERROR NO-WAIT.
             IF AVAILABLE sicsyac.xmm106 THEN DO:
               sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
               sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
               nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
               nv_prem                = nv_prem + sic_bran.uwd132.prem_c.  
             END.
             ELSE nv_message = "NOTFOUND".
         END.
         ELSE DO:
             FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass AND
                        sicsyac.xmm106.covcod  = wdetail.covcod   AND
                        sicsyac.xmm106.key_a  >= 0                AND
                        sicsyac.xmm106.key_b  >= 0                AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
             NO-LOCK NO-ERROR NO-WAIT.
     
             FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff      AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass    AND 
                        sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                        sicsyac.xmm106.key_a   = 0                   AND 
                        sicsyac.xmm106.key_b   = 0                   AND 
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
             NO-LOCK NO-ERROR NO-WAIT.
             IF AVAILABLE sicsyac.xmm106 THEN DO:
               sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
               RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
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
                    sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
                    sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
                    sic_bran.uwd132.bchcnt  = nv_batcnt          /* bchcnt     */      
                    n_rd132                 = RECID(sic_bran.uwd132).
     
             FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                  sicsyac.xmm016.class = wdetail.subclass
             NO-LOCK NO-ERROR.
             IF AVAIL sicsyac.xmm016 THEN DO:
               sic_bran.uwd132.gap_ae = NO.
               sic_bran.uwd132.pd_aep = "E".
             END.

             FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                  sicsyac.xmm105.tariff = wdetail.tariff  AND
                  sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
             NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
             ELSE 
               ASSIGN
                wdetail.comment = wdetail.comment + "| ไม่พบ Tariff ที่ xmm107"
                wdetail.OK_GEN  = "N"
                wdetail.pass    = "N".
               /*--- Comment A54-0076
               MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                       "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.*/
     
             IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                
                IF           wdetail.subclass      = "110" THEN nv_key_a = INTE(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = INTE(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = INTE(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = INTE(wdetail.weight).
                
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                           sicsyac.xmm106.tariff  = wdetail.tariff   AND
                           sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                           sicsyac.xmm106.class   = wdetail.subclass AND
                           sicsyac.xmm106.covcod  = wdetail.covcod   AND
                           sicsyac.xmm106.key_a  >= nv_key_a         AND
                           sicsyac.xmm106.key_b  >= nv_key_b         AND
                           sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    ASSIGN
                          sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                          sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                          nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                          nv_prem                = nv_prem + sic_bran.uwd132.prem_c. 
                END.
             END.
             ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                          sicsyac.xmm106.tariff  = wdetail.tariff           AND
                          sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                          sicsyac.xmm106.class   = wdetail.subclass         AND
                          sicsyac.xmm106.covcod  = wdetail.covcod           AND
                          sicsyac.xmm106.key_a  >= 0                        AND
                          sicsyac.xmm106.key_b  >= 0                        AND
                          sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                NO-LOCK NO-ERROR NO-WAIT.

                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                          sicsyac.xmm106.tariff  = wdetail.tariff            AND
                          sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                          sicsyac.xmm106.class   = wdetail.subclass          AND
                          sicsyac.xmm106.covcod  = wdetail.covcod            AND
                          sicsyac.xmm106.key_a   = 0                         AND
                          sicsyac.xmm106.key_b   = 0                         AND
                          sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                NO-LOCK NO-ERROR NO-WAIT.
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
         END. /*loop_def*/
      END.
  END.
  ELSE DO:    /*  Not Avail xmm107 */
    s_130fp1 = 0.
    s_130bp1 = 0.
       
    ASSIGN
      wdetail.comment = wdetail.comment + "| ไม่พบ Class/Tariff ที่ xmm107"
      wdetail.OK_GEN  = "N"
      wdetail.pass    = "N".

    /*--- Comment A54-0076 ---
    MESSAGE "ไม่พบ Class " wdetail.subclass " ใน Tariff  " wdetail.tariff  SKIP
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.*/
  END.

  ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
         sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                             /* uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */
  s_130fp1 = sic_bran.uwm130.fptr03.

  DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
    FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwd132 THEN DO:
      s_130fp1 = sic_bran.uwd132.fptr.

      IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:

        IF           wdetail.subclass      = "110" THEN nv_key_a = INTE(wdetail.cc).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = INTE(wdetail.seat).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = INTE(wdetail.cc).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = INTE(wdetail.weight).

        nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.

        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff          AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                   sicsyac.xmm106.class   = wdetail.subclass        AND
                   sicsyac.xmm106.covcod  = wdetail.covcod          AND
                   sicsyac.xmm106.key_a  >= nv_key_a                AND 
                   sicsyac.xmm106.key_b  >= nv_key_b                AND 
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
        NO-LOCK NO-ERROR NO-WAIT.
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
                   sicsyac.xmm106.class   = wdetail.subclass    AND 
                   sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                   sicsyac.xmm106.key_a  >= 0                   AND 
                   sicsyac.xmm106.key_b  >= 0                   AND 
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
        NO-LOCK NO-ERROR NO-WAIT.

        FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff   AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                   sicsyac.xmm106.class   = wdetail.subclass    AND
                   sicsyac.xmm106.covcod  = wdetail.covcod   AND
                   sicsyac.xmm106.key_a   = 0               AND
                   sicsyac.xmm106.key_b   = 0               AND
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
        NO-LOCK NO-ERROR NO-WAIT.

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

RUN Proc_724.
RUN proc_chktest4.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_724 C-Win 
PROCEDURE Proc_724 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_stm_per = 0.4.
nv_tax_per = 7.0.

FIND sicsyac.xmm020 USE-INDEX xmm02001 WHERE
     sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
     sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN DO:
    ASSIGN
        nv_stm_per = sicsyac.xmm020.rvstam
        nv_tax_per = sicsyac.xmm020.rvtax
        sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
END.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.

ASSIGN
    nv_gap2  = 0
    nv_prem2 = 0
    nv_rstp  = 0
    nv_rtax  = 0
    nv_com1_per = 0
    nv_com1_prm = 0.

FIND sicsyac.xmm031 WHERE 
     sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp 
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm031 THEN DO:
    nv_com1_per = sicsyac.xmm031.comm1.
END.

FOR EACH sic_bran.uwm120 WHERE
         sic_bran.uwm120.policy = wdetail.policy AND
         sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwm120.bchyr  = nv_batchyr AND
         sic_bran.uwm120.bchno  = nv_batchno AND
         sic_bran.uwm120.bchcnt = nv_batcnt :

    nv_gap  = 0.
    nv_prem = 0.

    FOR EACH sic_bran.uwm130 WHERE
             sic_bran.uwm130.policy = wdetail.policy AND
             sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
             sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
             sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
             sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
             sic_bran.uwm130.bchyr  = nv_batchyr  AND
             sic_bran.uwm130.bchno  = nv_batchno  AND
             sic_bran.uwm130.bchcnt = nv_batcnt NO-LOCK:

        nv_fptr = sic_bran.uwm130.fptr03.

        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
            NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sic_bran.uwd132 THEN LEAVE.

            ASSIGN
                nv_fptr = sic_bran.uwd132.fptr
                nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                nv_prem = nv_prem + sic_bran.uwd132.prem_c. 
        END.
    END.

    sic_bran.uwm120.gap_r  =  nv_gap.
    sic_bran.uwm120.prem_r =  nv_prem.
    sic_bran.uwm120.rstp_r =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
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
        ASSIGN
            sic_bran.uwm120.com1ae = NO
            sic_bran.uwm120.com1p  = nv_com1_per
            sic_bran.uwm120.com1_r = (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
            nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
    END.
    ELSE DO:
        IF nv_com1_per = 0 AND
           sic_bran.uwm120.com1ae = NO THEN DO:
            ASSIGN
                sic_bran.uwm120.com1p  = 0
                sic_bran.uwm120.com1_r = 0
                sic_bran.uwm120.com1_r = 0
                nv_com1_prm            = 0.
        END.
    END.
END.

FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.

ASSIGN
    sic_bran.uwm100.gap_p = nv_gap2
    sic_bran.uwm100.prem_t = nv_prem2
    sic_bran.uwm100.rstp_t = nv_rstp
    sic_bran.uwm100.rtax_t = nv_rtax
    sic_bran.uwm100.com1_t = nv_com1_prm.

fi_shown = "Please Wait Premium Compulsory" + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
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

               ASSIGN fi_shown = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_shown WITH FRAM fr_main. 
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
              
               /*
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_assign C-Win 
PROCEDURE Proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_tariff    = sic_bran.uwm301.tariff
    nv_class     = wdetail.subclass
    nv_comdat    = sic_bran.uwm100.comdat
    nv_engine    = DECI(wdetail.cc)
    nv_tons      = DECI(wdetail.weight)
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse
    /*nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc)*/ 
    nv_seats     = INTE(wdetail.seat)
    nv_tons      = DECI(wdetail.weight)
    /*nv_dss_per   = IF rapolicy = 1 THEN 0 ELSE nv_dss_per*/     
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
    nv_ncbper    = nv_ncbper
    nv_ncb       = nv_ncb
    nv_totsi     = nv_si .


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
DEFINE INPUT-OUTPUT PARAMETER  np_tambon        as char init "".  /* wdetail.iadd1       */  
DEFINE INPUT-OUTPUT PARAMETER  np_mail_amper    as char init "".  /* wdetail.iadd2       */  
DEFINE INPUT-OUTPUT PARAMETER  np_mail_country  as char init "".  /* wdetail.iadd3       */  
DEFINE INPUT-OUTPUT PARAMETER  np_mail_country2 as char init "".  /* wdetail.iadd4       */  
DEFINE INPUT-OUTPUT PARAMETER  np_occupation    as char init "".  /* wdetail.occup       */  
DEFINE INPUT-OUTPUT PARAMETER  np_codeocc       as char init "".  /* wdetail.codeocc     */  
DEFINE INPUT-OUTPUT PARAMETER  np_codeaddr1     as char init "".  /* wdetail.codeaddr1   */  
DEFINE INPUT-OUTPUT PARAMETER  np_codeaddr2     as char init "".  /* wdetail.codeaddr2   */  
DEFINE INPUT-OUTPUT PARAMETER  np_codeaddr3     as char init "".  /* wdetail.codeaddr3). */  
DEFINE VAR nv_address AS CHAR INIT  "".
/*ตลาดไอยรา ม.9 ต.คลองสอง       อ.คลองหลวง ปทุมธานี     12120
--ไม่มี จังหวัดมา
*/
ASSIGN 
    nv_address       = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country + " " + np_mail_country2 )  
    np_mail_country2 = ""
    nv_postcd        = "".

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
ELSE  DO:
          FIND LAST brstat.insure   WHERE 
              brstat.insure.compno = "999"    AND 
               INDEX(nv_address,brstat.Insure.FName) <> 0 NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL brstat.insure THEN  
              ASSIGN 
                  np_mail_country = trim(SUBSTR(nv_address,r-INDEX(nv_address,brstat.Insure.FName))) 
                  nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,brstat.Insure.FName)  - 1 )).
             /* MESSAGE "1" np_mail_country VIEW-AS ALERT-BOX.*/

END.

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
IF      index(np_mail_country,"กรุงเทพ") <> 0  OR index(np_mail_country,"กทม")     <> 0 THEN 
    ASSIGN 
    np_tambon       = nv_address + " แขวง" + trim(np_tambon)    
    np_mail_amper   = "เขต"  + trim(np_mail_amper) . 
ELSE ASSIGN 
    np_tambon       = nv_address + " ต." +  trim(np_tambon)    
    np_mail_amper   = "อ." +  trim(np_mail_amper)  
    np_mail_country = "จ." +  trim(np_mail_country).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_AssignClear C-Win 
PROCEDURE Proc_AssignClear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_ncb = 0
    nv_ncbper    = 0
    nv_tariff = ""
    nv_baseprm = 0
    n_firstdat = ?
    nv_dspc = 0
    nv_loadclm = ""
    nv_fleet = ""
    nv_deductpd = ""
    nv_deductda = ""
    nv_deductdo = ""
    nv_stf_per = 0.

/*ASSIGN
    nv_tariff    = ""
    nv_class     = ""
    nv_comdat    = ? 
    nv_engine    = 0 
    nv_tons      = 0
    nv_covcod    = ""
    nv_vehuse    = ""
    /*nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc)*/ 
    nv_seats     = 0
    nv_tons      = 0
    /*nv_dss_per   = IF rapolicy = 1 THEN 0 ELSE nv_dss_per*/     
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
    nv_ncb       = 0
    nv_totsi     = 0 
    nv_deductpd  = "".*/

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
DO:
    /*--- nv_drivcod ----*/
    nv_drivvar1 = wdetail.drivnam1.
    nv_drivvar2 = wdetail.drivnam2.
    IF wdetail.drivnam = "N" THEN DO:
        ASSIGN nv_drivvar  = " "
               nv_drivcod  = "A000"
               nv_drivvar1 = "     Unname Driver"
               nv_drivvar2 = "0"
               SUBSTR(nv_drivvar,1,30)   = nv_drivvar1
               SUBSTR(nv_drivvar,31,30)  = nv_drivvar2.
    END.
    ELSE DO:
        IF nv_drivno > 2 THEN DO:
            MESSAGE " Driver'S NO. must not over 2. "  VIEW-AS ALERT-BOX.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
            /*NEXT. *//*a490166*/
        END.
        ASSIGN nv_drivvar   = " "
               nv_drivvar1  = "     Driver name person = "
               nv_drivvar2  = STRING(nv_drivno)
               SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
               SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.
        RUN proc_usdcod.
    END.
     /*-- Add A55-0235 ---*/
    IF nv_bipp00 = 0 THEN nv_bipp00 = if wdetail.uom1_V <> 0 then wdetail.uom1_V else  sic_bran.uwm130.uom1_v. /*A60-0383 */ 
    IF nv_bipa00 = 0 THEN nv_bipa00 = if wdetail.uom2_V <> 0 then wdetail.uom2_V else  sic_bran.uwm130.uom2_v. /*A60-0383 */ 
    IF nv_bipd00 = 0 THEN nv_bipd00 = if wdetail.uom5_V <> 0 then wdetail.uom5_V else  sic_bran.uwm130.uom5_v. /*A60-0383 */ 
    /*-- End Add A55-0235 ---*/
    
    IF wdetail.baseprem <> 0 THEN nv_baseprm = wdetail.baseprem.
    ELSE RUN Proc_Chkbase.
    
    IF NO_basemsg <> " " THEN wdetail.WARNING = NO_basemsg.
    IF nv_baseprm = 0 THEN DO:
        ASSIGN wdetail.pass    = "N"
               wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
    END.
    ASSIGN nv_basevar = ""
           nv_prem1    = nv_baseprm
           nv_basecod  = "BASE"
           nv_basevar1 = "     Base Premium = "
           nv_basevar2 = STRING(nv_baseprm)
           SUBSTRING(nv_basevar,1,30)   = nv_basevar1
           SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    
    /*--- nv_add perils ---*/
    ASSIGN nv_41 =  WDETAIL.no_41  
           nv_42 =  WDETAIL.no_42  
           nv_43 =  WDETAIL.no_43
           nv_seat41 = INTEGER(wdetail.seat41).
    /*comment by : A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                          nv_class,
                          nv_key_b,
                          nv_comdat).*/
    ASSIGN  nv_411var = ""      nv_412var = ""
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
    nv_42var    = " ".      /* -------fi_42---------*/
    ASSIGN nv_42cod   = "42"
           nv_42var1  = "     Medical Expense = "
           nv_42var2  = STRING(nv_42)
           SUBSTRING(nv_42var,1,30)   = nv_42var1
           SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".      /*---------fi_43--------------*/
    ASSIGN  nv_43prm   = nv_43
            nv_43cod   = "43"
            nv_43var1  = "     Airfrieght = "
            nv_43var2  =  STRING(nv_43)
            SUBSTRING(nv_43var,1,30)   = nv_43var1
            SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /*comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                          nv_class,
                          nv_key_b,
                          nv_comdat).*/
    /*---- nv_usecod ---*/
    ASSIGN nv_usevar  = ""
           nv_usecod  = "USE" + TRIM(wdetail.vehuse)
           nv_usevar1 = "     Vehicle Use = "
           nv_usevar2 =  wdetail.vehuse
           SUBSTRING(nv_usevar,1,30)  = nv_usevar1
           SUBSTRING(nv_usevar,31,30) = nv_usevar2.
    /*--- nv_engcod ---*/
    /*ASSIGN nv_sclass = SUBSTRING(wdetail.subclass,2,3).*//*A53-0111*/
     
    RUN wgs\wgsoeng.
    /*----- nv_yrcod ------*/
    ASSIGN  nv_yrvar = ""
            nv_caryr   = (YEAR(nv_comdat)) - INTEGER(wdetail.caryear) + 1
            nv_yrvar1  = "     Vehicle Year = "
            nv_yrvar2  =  STRING(wdetail.caryear)
            nv_yrcod   = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr)
                                           ELSE "YR99"
            SUBSTRING(nv_yrvar,1,30)    = nv_yrvar1
            SUBSTRING(nv_yrvar,31,30)   = nv_yrvar2.
    /*----- nv_sicod ------*/
    ASSIGN  nv_sivar = ""
            nv_sicod     = "SI"
            nv_sivar1    = "     Own Damage = "
            nv_sivar2    =  STRING(wdetail.si)
            SUBSTRING(nv_sivar,1,30)  = nv_sivar1
            SUBSTRING(nv_sivar,31,30) = nv_sivar2
            nv_totsi     =  INTE(wdetail.si).
    /*------ nv_grpcod -----*/
    ASSIGN  nv_grpvar = ""
            nv_grpcod      = "GRP" + wdetail.cargrp
            nv_grpvar1     = "     Vehicle Group = "
            nv_grpvar2     = wdetail.cargrp
            SUBSTRING(nv_grpvar,1,30)  = nv_grpvar1
            SUBSTRING(nv_grpvar,31,30) = nv_grpvar2.
    /*------ nv_bipcod ------*/
    ASSIGN  nv_bipvar = ""
            nv_bipcod      = "BI1"
            nv_bipvar1     = "     BI per Person = "
            nv_bipvar2     = STRING(nv_bipp00)
            SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
            SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*------ nv_biacod -------*/
    ASSIGN  nv_biavar      = ""
            nv_biacod      = "BI2"
            nv_biavar1     = "     BI per Accident = "
            nv_biavar2     = STRING(nv_bipa00)
            SUBSTRING(nv_biavar,1,30)  = nv_biavar1
            SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*------- nv_pdacod --------*/
    ASSIGN  nv_pdavar = ""
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     = STRING(nv_bipd00)
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
        /*A60-0327*/
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO:
    
        ASSIGN  nv_usevar3 = ""
                nv_usecod3  = IF      (wdetail.covcod = "2.1") THEN "U" + TRIM(nv_vehuse) + "21" 
                              ELSE IF (wdetail.covcod = "2.2") THEN "U" + TRIM(nv_vehuse) + "22" 
                              ELSE IF (wdetail.covcod = "3.1") THEN "U" + TRIM(nv_vehuse) + "31"
                              ELSE "U" + TRIM(nv_vehuse) + "32" 
                nv_usevar4 = "     Vehicle Use = "
                nv_usevar5 =  wdetail.vehuse
                Substring(nv_usevar3,1,30)   = nv_usevar4
                Substring(nv_usevar3,31,30)  = nv_usevar5.
        /*-------------------base 3----------------------*/
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
            IF AVAIL xmm106 THEN DO:
                nv_baseprm3 = xmm106.min_ap.
            END.
            ELSE DO:
                 nv_baseprm3 = 0.
                 NO_basemsg = "Base Premium3 is Not in Range " .
            END.
        IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
        ASSIGN nv_basevar3 = ""
             nv_basevar4 = "     Base Premium3 = "
             nv_basevar5 = STRING(nv_baseprm3)
             SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
             SUBSTRING(nv_basevar3,31,30)  = nv_basevar5. 
        /*---------------- SI 2+3+ ----------------------------*/
         ASSIGN nv_sivar3 = ""
            nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                           ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                           ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
            nv_sivar4    = "     Own Damage = "                                        
            nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE  string(deci(wdetail.si)) 
            wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
            SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
            SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
            nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
    END.
    /* end A60-0327*/    
    /*------- deduct --------*/
    /*dod0 = INTEGER(wdetail.deductda).*//*A53-0111*/
   /*DEF VAR dod0 AS INTEGER.
    DEF VAR dod1 AS INTEGER.
    DEF VAR dod2 AS INTEGER.
    DEF VAR dpd0 AS INTEGER.*/
    ASSIGN  dod0 = 0 
            dod1 = 0 
            dod2 = 0 
            dpd0 = 0 .
    dod0 = INTEGER(nv_deductda).
    IF dod0 > 3000 THEN DO:
       dod1 = 3000.
       dod2 = dod0 - dod1.
    END.
    
    ASSIGN nv_dedod1var = ""
           nv_odcod = "DC01"
           nv_prem  = dod1.
    IF dod1 <> 0 THEN DO:
        RUN Wgs\Wgsmx024( nv_tariff,                    /*a490166 note modi*/
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap).
         
        IF NOT nv_chk THEN DO:
            MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  VIEW-AS ALERT-BOX.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
            /*NEXT.*/
        END.
        ASSIGN  nv_ded1prm        = nv_prem
                nv_dedod1_prm     = nv_prem
                nv_dedod1_cod     = "DOD"
                nv_dedod1var1     = "     Deduct OD = "
                nv_dedod1var2     = STRING(dod1)
                SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
                SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
    END.
    ASSIGN  nv_dedod2var = " "
            nv_cons      = "AD"
            nv_ded       = dod2.
    /*comment by : A64-0138..
    RUN  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                             nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat,
                             nv_cons,
                             OUTPUT nv_prem).*/
    IF dod2 <> 0 THEN
        ASSIGN  nv_aded1prm     = nv_prem
                nv_dedod2_cod   = "DOD2"
                nv_dedod2var1   = "     Add Ded.OD = "
                nv_dedod2var2   =  STRING(dod2)
                SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
                SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
                nv_dedod2_prm   = nv_prem.
    /*------ pd -------*/
    ASSIGN  nv_dedpdvar  = " "
            dpd0     = 0
            dpd0     = INTE(nv_deductpd) 
            nv_cons  = "PD"
            nv_ded   = dpd0.
    /*comment by : A64-0138..
    RUN  Wgs\Wgsmx025(INPUT  nv_ded, /*a490166 note modi*/
                             nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat,
                             nv_cons,
                             OUTPUT nv_prem).
    nv_ded2prm  = nv_prem.*/
    IF dpd0 <> 0 THEN
    ASSIGN  nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem.
    
    /*------- NCB ---------*/
    DEF VAR nv_ncbyrs AS INTE.
    /*nv_ncbper = INTE(wdetail.ncb).*/
    nv_ncbper = nv_ncb.
    nv_ncbvar = " " .
    IF nv_ncbper <> 0 THEN DO:
        FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
                   sicsyac.xmm104.tariff = nv_tariff   AND
                   sicsyac.xmm104.class  = nv_class    AND
                   sicsyac.xmm104.covcod = nv_covcod   AND
                   sicsyac.xmm104.ncbper = INTE(nv_ncbper) NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm104 THEN DO:
            /*Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.*/
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
            /*NEXT.*//*a490166 Load all no Comment*/
        END.
        IF AVAIL sicsyac.xmm104 THEN
            ASSIGN  nv_ncbper  = xmm104.ncbper
                    nv_ncbyrs  = xmm104.ncbyrs.
    END.
    ELSE DO:
        ASSIGN  nv_ncbyrs  = 0
                nv_ncbper  = 0
                nv_ncb     = 0.
    END.
    /*comment by : A64-0138..
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               /*-- Comment A55-0235 --*/
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).
                               /*--- End Add A55-0235 ---*/*/
    
    nv_ncbvar   = " ".
    IF nv_ncb <> 0 THEN
        ASSIGN  nv_ncbvar1   = "     NCB % = "
                nv_ncbvar2   =  STRING(nv_ncbper)
                SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
                SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
    nv_ncb = 0.
    nv_ncbper = 0.
    nv_ncbyrs = 0.
    
    /*------- fleet ---------*/
    /*nv_flet_per = INTE(wdetail.fleet).*//*A53-0111*/
    nv_flet_per = INTE(nv_fleet).
    IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
        /*Message  " Fleet Percent must be 0 or 10. " View-as alert-box.*/
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
        /*NEXT.  *//*a490166*/
    END.
    IF nv_flet_per = 0 THEN DO:
        ASSIGN nv_flet    = 0
               nv_fletvar = " ".
    END.  
    /*comment by : A64-0138..
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               /*-- Comment A55-0235 --*/
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).*/
                               /*--- End Add A55-0235 ---*/
    ELSE 
    ASSIGN  nv_fletvar     = " "
            nv_fletvar1    = "     Fleet % = "
            nv_fletvar2    =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.        
    
    IF nv_flet  = 0 THEN nv_fletvar = " ".
    /*-------- load claim ---------*/
    /*nv_cl_per   = DECI(wdetail.loadclm).*//*A53-0111*/
    nv_cl_per   = DECI(nv_loadclm).
    nv_clmvar   = " ".
    IF nv_cl_per <> 0 THEN
       ASSIGN nv_clmvar1   = " Load Claim % = "
            nv_clmvar2   =  STRING(nv_cl_per)
            SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
            SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    /*comment by : A64-0138..
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               /*nv_bipp00,
                               nv_bipa00,
                               nv_bipd00).*/
                               /*-- Comment A55-0235 --*/
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).
                               /*--- End Add A55-0235 ---*/
    nv_clmvar = " ".
    IF nv_cl_per <> 0 THEN
        ASSIGN  nv_clmvar1   = " Load Claim % = "
                nv_clmvar2   =  STRING(nv_cl_per)
                SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2. 
   end A64-0138..*/
   nv_dss_per = nv_dspc.
   IF  nv_dss_per   <> 0  THEN
       ASSIGN
           nv_dsspcvar1   = "     Discount Special % = "
           nv_dsspcvar2   =  STRING(nv_dss_per)
           SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
           SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
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
    ASSIGN fi_shown = "Create data to base..." + wdetail.policy .
    DISP fi_shown WITH FRAM fr_main.
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
         nv_class   = TRIM(wdetail.subclass) 
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
         nv_access  = sic_bran.uwm130.uom6_u                                          
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = nv_uom1_v             
         nv_tpbi2si = nv_uom2_v             
         nv_tppdsi  = nv_uom5_v             
         nv_411si   = wdetail.no_41       
         nv_412si   = wdetail.no_41       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = wdetail.no_42                
         nv_43si    = wdetail.no_43                
         nv_seat41  = wdetail.seat41   
         nv_dedod   = DOD1       
         nv_addod   = DOD2                                
         nv_dedpd   = DPD0                                     
         nv_ncbp    = deci(nv_ncb)                                     
         nv_fletp   = deci(nv_fleet)                                  
         nv_dspcp   = deci(nv_dss_per)                                      
         nv_dstfp   = deci(nv_stf_per)                                                     
         nv_clmp    = deci(nv_loadclm) 
         /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(wdetail.netprem) /* เบี้ยสุทธิ */                                                
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
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.cc) ELSE INT(wdetail.cc).
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
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                      stat.maktab_fil.sclass = SUBSTRING(wdetail.subclass,2,3) AND
                      stat.maktab_fil.modcod = wdetail.redbook NO-LOCK NO-ERROR NO-WAIT.
           IF AVAIL stat.maktab_fil THEN  
               ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
                   wdetail.cargrp          =  stat.maktab_fil.prmpac
                   sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                   nv_vehgrp               =  stat.maktab_fil.prmpac. 
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
                       OUTPUT nv_uom1_c,  
                       OUTPUT nv_uom2_c,  
                       OUTPUT nv_uom5_c,  
                       OUTPUT nv_uom6_c,
                       OUTPUT nv_uom7_c,
                       OUTPUT nv_status, 
                       OUTPUT nv_message ).

    /*IF nv_gapprm <> DECI(wdetail.netprem) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + "  ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.netprem + 
        nv_message  VIEW-AS ALERT-BOX.
        ASSIGN wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.netprem.
         wdetail.pass     = "Y"     
            wdetail.OK_GEN  = "N". */ /*comment by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_message   /*  by Kridtiya i. A65-0035*/  
               wdetail.WARNING = wdetail.WARNING + "|" + nv_message . /*  by Kridtiya i. A65-0035*/  
    END.
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate(input DATE(wdetail.comdat),
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaign C-Win 
PROCEDURE proc_campaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcampaign :
    DELETE wcampaign.
END.
FOR EACH brstat.insure USE-INDEX insure03 WHERE brstat.insure.compno = TRIM(fi_campaign) AND 
                                                brstat.insure.insno  = TRIM(fi_campaign) NO-LOCK.
  /* comment by A63-0174 ...
   FIND LAST wcampaign WHERE wcampaign.pack   = trim(brstat.insure.text3) AND  /*pack */
                              wcampaign.nclass = trim(brstat.insure.text1) AND  /*class */
                              wcampaign.camp   = trim(brstat.insure.text2) AND  /*campaign*/
                              wcampaign.cover  = trim(brstat.insure.vatcode) NO-ERROR NO-WAIT. */  /*cover*/
   /* IF NOT AVAIL wcampaign  THEN DO:*/
        CREATE wcampaign.
        ASSIGN wcampaign.bi     = brstat.insure.lname   
               wcampaign.pd1    = brstat.insure.addr1   
               wcampaign.pd2    = brstat.insure.addr2   
               wcampaign.n41    = brstat.insure.addr3   
               wcampaign.n42    = brstat.insure.addr4   
               wcampaign.n43    = brstat.insure.telno   
               wcampaign.nclass = brstat.insure.text1   
               wcampaign.camp   = brstat.insure.text2   
               wcampaign.pack   = brstat.insure.text3   
               wcampaign.cover  = brstat.insure.vatcode
               wcampaign.campno = brstat.insure.text4.  /* Garage : A63-0174*/
   /* END.*/
END.
RELEASE brstat.insure.
OPEN QUERY br_camp FOR EACH wcampaign .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Chassic C-Win 
PROCEDURE Proc_Chassic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF SUBSTRING(wdetail.chasno,1,1) = "'" THEN DO:
    wdetail.chasno = SUBSTRING(wdetail.chasno,2,LENGTH(wdetail.chasno)).
END.
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = wdetail.chasno.
    loop_chk1:
    REPEAT:
        fi_shown = "Please Wait Check chassic 1" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        fi_shown = "Please Wait Check chassic 2" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        fi_shown = "Please Wait Check chassic 3" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        fi_shown = "Please Wait Check chassic 4" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        fi_shown = "Please Wait Check chassic 5" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        fi_shown = "Please Wait Check chassic 6" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        fi_shown = "Please Wait Check chassic 7" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        fi_shown = "Please Wait Check chassic 8" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        fi_shown = "Please Wait Check chassic 9" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        fi_shown = "Please Wait Check chassic 10" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        fi_shown = "Please Wait Check chassic 11" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        fi_shown = "Please Wait Check chassic 12" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        fi_shown = "Please Wait Check chassic 13" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        fi_shown = "Please Wait Check chassic 14" + nv_uwm301trareg.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        fi_shown = "Please Wait Check chassic 15" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        fi_shown = "Please Wait Check chassic 16" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        fi_shown = "Please Wait Check chassic 17" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        fi_shown = "Please Wait Check chassic 18" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
        IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        fi_shown = "Please Wait Check chassic 19" + wdetail.chasno.
        DISP fi_shown WITH FRAME fr_main.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Chkbase C-Win 
PROCEDURE Proc_Chkbase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Check Base" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
DEFINE VAR nv_bencod1 AS CHARACTER FORMAT "X(4)" INITIAL "" NO-UNDO.

nv_bencod1 = "BASE".
NO_basemsg = " " .

FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff =  nv_tariff  AND
           sicsyac.xmm106.bencod =  nv_bencod1 AND
           sicsyac.xmm106.class  =  nv_class   AND
           sicsyac.xmm106.covcod =  nv_covcod  AND
           sicsyac.xmm106.key_b  GE nv_key_b   AND
           sicsyac.xmm106.effdat LE nv_comdat
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
   IF nv_drivcod = "A000" THEN DO:
     nv_baseprm = sicsyac.xmm106.max_ap.
   END.
   ELSE DO:
     nv_baseprm = sicsyac.xmm106.min_ap.
   END.
END.
/*--- A53-0111 Fix Base ---*/
IF rapolicy = 1 THEN DO:
    IF SUBSTRING(wdetail.subclass,2,3) = "110" THEN nv_baseprm = 7600.
    ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN nv_baseprm = 12000.
    ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN nv_baseprm = 13000.
END.
IF rapolicy = 2 THEN DO:
    IF wdetail.covcod = "3" /*AND rapolicy = 2*/ THEN DO:
        IF wdetail.prempa = "R" THEN DO:    
            IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) <= 2000 THEN ASSIGN nv_ncb = 30 nv_baseprm = 2468.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) > 2000 THEN ASSIGN nv_ncb = 40 nv_baseprm = 2535.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN ASSIGN nv_ncb = 30 nv_baseprm = 3410.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN ASSIGN nv_ncb = 30 nv_baseprm = 4140.
        END.
        IF wdetail.prempa = "V" THEN DO:
            IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) <= 2000 THEN nv_baseprm = 2646.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) > 2000 THEN nv_baseprm = 2657.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN nv_baseprm = 3553.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN nv_baseprm = 4051.
        END.
        IF wdetail.prempa = "Z" THEN DO:
            IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) <= 2000 THEN nv_baseprm = 2691.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) > 2000 THEN nv_baseprm = 2341.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN nv_baseprm = 3245.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN nv_baseprm = 3750.
        END.
        IF wdetail.prempa = "P" THEN DO:
            IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) <= 2000 THEN nv_baseprm = 2638.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "110" AND INTE(wdetail.cc) > 2000 THEN nv_baseprm = 2295.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN nv_baseprm = 3925.
            ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN nv_baseprm = 3740.
        END.
        /*--- Comment A53-0362 ---
        ELSE DO:
            FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                       sicsyac.xmm106.tariff =  nv_tariff  AND
                       sicsyac.xmm106.bencod =  nv_bencod1 AND
                       sicsyac.xmm106.class  =  nv_class   AND
                       sicsyac.xmm106.covcod =  nv_covcod  AND
                       sicsyac.xmm106.key_b  GE nv_key_b   AND
                       sicsyac.xmm106.effdat LE nv_comdat
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm106 THEN DO:
               IF nv_drivcod = "A000" THEN DO:
                 nv_baseprm = sicsyac.xmm106.max_ap.
               END.
               ELSE DO:
                 nv_baseprm = sicsyac.xmm106.min_ap.
               END.
            END.
        END.  ---- End Comment ----*/
        wdetail.baseprem = nv_baseprm.
        /*MESSAGE wdetail.baseprem.*/
    END.
    ELSE IF wdetail.covcod = "1" THEN DO:
        IF SUBSTRING(wdetail.subclass,2,3) = "110" THEN nv_baseprm = 7600.
        ELSE IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN nv_baseprm = 12000.
        ELSE IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN nv_baseprm = 13000.
    END.
    
END.
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
    
 
 IF wdetail.finit <> "" THEN DO: /*dealer code */
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.finit) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.finit + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.finit + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.financecd <> "" THEN DO: /* finance code */
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
 END.*/
 IF wdetail.typreq <> "" THEN DO: /*vat code */
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.typreq) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.typreq + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.typreq + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
 END.
 RELEASE sicsyac.xmm600.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Chkprovi C-Win 
PROCEDURE proc_Chkprovi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-----
/*1*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "กระบี่"        THEN nv_vehreg = "กบ".
/*2*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "กรุงเทพมหานคร" THEN nv_vehreg = "กท".
/*3*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "กาญจนบุรี"     THEN nv_vehreg = "กจ".
/*4*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "กาฬสินธุ์"     THEN nv_vehreg = "กส".
/*5*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "กำแพงเพชร"     THEN nv_vehreg = "กพ".
/*6*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ขอนแก่น"       THEN nv_vehreg = "ขก".
/*7*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "จันทบุรี"      THEN nv_vehreg = "จท".
/*8*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ฉะเชิงเทรา"    THEN nv_vehreg = "ฉท".
/*9*/   IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ชลบุรี"        THEN nv_vehreg = "ชบ".
/*10*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ชัยนาท"        THEN nv_vehreg = "ชน".
/*11*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ชัยภูมิ"       THEN nv_vehreg = "ชย".
/*12*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ชุมพร"         THEN nv_vehreg = "ชพ".
/*13*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "เชียงราย"      THEN nv_vehreg = "ชร".
/*14*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "เชียงใหม่"     THEN nv_vehreg = "ชม".
/*15*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ตรัง"          THEN nv_vehreg = "ตง".
/*16*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ตราด"          THEN nv_vehreg = "ตร".
/*17*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ตาก"           THEN nv_vehreg = "ตก".
/*18*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครนายก"       THEN nv_vehreg = "นย".
/*19*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครปฐม"        THEN nv_vehreg = "นฐ".
/*20*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครพนม"        THEN nv_vehreg = "นพ".
/*21*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครราชสีมา"    THEN nv_vehreg = "นม".
/*22*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครศรีธรรมราช" THEN nv_vehreg = "นศ".
/*23*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นครสวรรค์"     THEN nv_vehreg = "นว".
/*24*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นนทบุรี"       THEN nv_vehreg = "นบ".
/*25*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "นราธวาส"       THEN nv_vehreg = "นธ".
/*26*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "น่าน"          THEN nv_vehreg = "นน".
/*27*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "บุรีรัมย์"     THEN nv_vehreg = "บร".
/*28*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ปทุมธานี"      THEN nv_vehreg = "ปท".
/*29*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ประจวบคีรีขันธ์" THEN nv_vehreg = "ปข".
/*30*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ปราจีนบุรี"   THEN nv_vehreg = "ปจ".
/*31*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ปัตตานี"      THEN nv_vehreg = "ปน".
/*32*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พระนครศรีอยุธยา" OR wImport.vehreg = "อยุธยา" THEN nv_vehreg = "อย".
/*33*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พะเยา"        THEN nv_vehreg = "พย".
/*34*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พังงา"        THEN nv_vehreg = "พง".
/*35*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พัทลุง"       THEN nv_vehreg = "พท".
/*36*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พิจิตร"       THEN nv_vehreg = "พจ".
/*37*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "พิษณุโลก"     THEN nv_vehreg = "พล".
/*38*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "เพชรบุรี"     THEN nv_vehreg = "พบ".
/*39*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "เพชรบูรณ์"    THEN nv_vehreg = "พช".
/*40*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "แพร่"         THEN nv_vehreg = "พร".
/*41*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ภูเก็ต"       THEN nv_vehreg = "ภก".
/*42*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "มหาสารคาม"    THEN nv_vehreg = "มค".
/*43*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "มุกดาหาร"     THEN nv_vehreg = "มห".
/*44*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "แม่ฮ่องสอน"   THEN nv_vehreg = "มส".
/*45*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ยะลา"         THEN nv_vehreg = "ยล".
/*46*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ร้อยเอ็ด"     THEN nv_vehreg = "รอ".
/*47*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ระนอง"        THEN nv_vehreg = "รน".
/*48*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ระยอง"        THEN nv_vehreg = "รย".
/*49*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ราชบุรี"      THEN nv_vehreg = "รบ".
/*50*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ลพบุรี"       THEN nv_vehreg = "ลบ".
/*51*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ลำปาง"        THEN nv_vehreg = "ลป".
/*52*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ลำพูน"        THEN nv_vehreg = "ลพ".
/*53*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "เลย"          THEN nv_vehreg = "ลย".
/*54*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ศรีสะเกษ"     THEN nv_vehreg = "ศก".
/*55*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สกลนคร"       THEN nv_vehreg = "สน".
/*56*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สงขลา"        THEN nv_vehreg = "สข".
/*57*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สระแก้ว"      THEN nv_vehreg = "สก".
/*58*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สระบุรี"      THEN nv_vehreg = "สบ".
/*59*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สิงห์บุรี"    THEN nv_vehreg = "สห".
/*60*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุโขทัย"      THEN nv_vehreg = "สท".
/*61*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุพรรณบุรี"   THEN nv_vehreg = "สพ".
/*62*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุราษฎร์ธานี" THEN nv_vehreg = "สฎ".
/*63*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุรินทร์"     THEN nv_vehreg = "สร".
/*64*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "หนองคาย"      THEN nv_vehreg = "นค".
/*65*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "หนองบัวลำพู"  THEN nv_vehreg = "นล".
/*66*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อ่างทอง"      THEN nv_vehreg = "อท".
/*67*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อำนาจเจริญ"   THEN nv_vehreg = "อจ".
/*68*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อุดรธานี"     THEN nv_vehreg = "อด".
/*69*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อุตรดิตถ์"    THEN nv_vehreg = "อต".
/*70*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อุทัยธานี"    THEN nv_vehreg = "อท".
/*71*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "อุบลราชธานี"  THEN nv_vehreg = "อบ".
/*72*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "ยโสธร"        THEN nv_vehreg = "ยส".
/*73*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สตูล"         THEN nv_vehreg = "สต".
/*74*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุมทรปราการ"  THEN nv_vehreg = "สป".
/*75*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุมทรสงคราม"  THEN nv_vehreg = "สส".
/*76*/  IF TRIM(SUBSTRING(wImport.vehreg,8,30)) = "สุมทรสาคร"    THEN nv_vehreg = "สค".
-----*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Chktest0 C-Win 
PROCEDURE Proc_Chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---
IF wdetail.vehreg = " " AND wdetail.renpol  = " " THEN DO: 
   ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.renpol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        DEF  VAR  nv_vehreg  AS   CHAR  INIT  " ".
        DEF  VAR  s_polno    LIKE sicuw.uwm100.policy   INIT " ".
        FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE  
                  sicuw.uwm301.vehreg = wdetail.vehreg NO-LOCK NO-ERROR NO-WAIT.
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
                sicuw.uwm100.expdat > DATE(wdetail.comdat)       NO-LOCK NO-ERROR NO-WAIT.
            If AVAIL sicuw.uwm100 THEN 
                s_polno     =   sicuw.uwm100.policy.
        END.        /*avil 301*/
    END.            /*จบการ Check ทะเบียนรถ*/
END.                /*note end else*/   /*end note vehreg*/
----*//*Comment A53-0111*/

fi_shown = "Please Wait Check Data Thanachat" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
IF wdetail.vehreg = " " THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.

IF wdetail.cancel = "ca"  THEN  
    ASSIGN
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| cancel"
        WDETAIL.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N".
IF wdetail.drivnam = "y" AND wdetail.drivnam1 =  " "   THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
        wdetail.pass    = "N" 
        WDETAIL.OK_GEN  = "N".
IF wdetail.subclass = " " THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        WDETAIL.OK_GEN  = "N".
END. /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"        
        WDETAIL.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
IF wdetail.cc    = " " THEN 
    
    ASSIGN
        wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N".
IF INTE(wdetail.seat)  = 0 THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        WDETAIL.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        WDETAIL.OK_GEN  = "N".
ASSIGN
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred = NO.   
/*---
IF wdetail.poltyp = "V70" OR wdetail.poltyp = "70" THEN wdetail.subclass = wdetail.prempa + wdetail.subclass.
ELSE wdetail.subclass = wdetail.subclass. 

wdetail.subclass = wdetail.prempa + wdetail.subclass. /*A53-0111*/
----*//*A53-0111*/
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
               stat.maktab_fil.sclass = wdetail.subclass   AND 
               stat.maktab_fil.modcod = wdetail.redbook    NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL  stat.maktab_fil  THEN DO:
        ASSIGN
            nv_modcod         =  stat.maktab_fil.modcod                                    
            nv_moddes         =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp    =  stat.maktab_fil.prmpac
            chkred            =  YES                     /*note chk found redbook*/
            wdetail.brand     =  stat.maktab_fil.makdes
            wdetail.model     =  stat.maktab_fil.moddes
            wdetail.caryear   =  STRING(stat.maktab_fil.makyea)
            wdetail.cc        =  STRING(stat.maktab_fil.engine)
            wdetail.subclass  =  stat.maktab_fil.sclass   
            wdetail.redbook   =  stat.maktab_fil.modcod                                    
            wdetail.seat41    =  stat.maktab_fil.seats
            nv_si             =  stat.maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
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
                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN DO:
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.subclass + "   Make/Model:" + wdetail.model + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                            wdetail.pass    = "N"    
                            WDETAIL.OK_GEN  = "N".

                    END.
                    ELSE
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                            + "  Class:"  + wdetail.subclass + ")"
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
    END.          
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 WHERE 
               stat.makdes31.makdes = "X"  AND     /*Lock X*/
               stat.makdes31.moddes = wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE makdes31 THEN DO: 
        FIND FIRST stat.maktab_fil USE-INDEX      maktab04         WHERE
             stat.maktab_fil.makdes   =     wdetail.brand            AND                  
             INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0 AND
             stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
             stat.maktab_fil.engine   =     INTEGER(wdetail.cc)   AND
             stat.maktab_fil.sclass   =     SUBSTRING(wdetail.subclass,2,3)      AND
             (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100 ) LE INTE(wdetail.si)   AND 
              stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100 ) GE INTE(wdetail.si) ) AND
             stat.maktab_fil.seats    =   INTE(wdetail.seat)     NO-LOCK NO-ERROR NO-WAIT.
        IF  AVAIL stat.maktab_fil  THEN 
         ASSIGN
             nv_modcod        =  stat.maktab_fil.modcod                                    
             nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
             wdetail.cargrp   =  stat.maktab_fil.prmpac
             wdetail.redbook  =  stat.maktab_fil.modcod.
        IF nv_modcod = ""  THEN  RUN proc_maktab.
    END.

    /*IF   SUBSTRING(wdetail.subclass,2,3) = "110" THEN INTE(wdetail.seat) = 7.
    ELSE INTE(wdetail.seat) = 12.
    Find First stat.maktab_fil USE-INDEX      maktab04         WHERE
         stat.maktab_fil.makdes   =     wdetail.brand            AND                  
         INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0 AND
         stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
         stat.maktab_fil.engine   =     INTEGER(wdetail.cc)   AND
         stat.maktab_fil.sclass   =     SUBSTRING(wdetail.subclass,2,3)      AND
         (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE INTE(wdetail.si)   AND 
          stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE INTE(wdetail.si) ) AND
         stat.maktab_fil.seats    =   INTE(wdetail.seat)     NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL stat.maktab_fil  THEN 
     ASSIGN
         nv_modcod        =  stat.maktab_fil.modcod                                    
         nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
         wdetail.cargrp   =  stat.maktab_fil.prmpac
         wdetail.redbook  =  stat.maktab_fil.modcod.
    IF nv_modcod = ""  THEN  RUN proc_maktab.*/
END.  /*nv_modcod = blank*/
/*end note add &  modi*/
ASSIGN                  
    NO_CLASS  = wdetail.subclass 
    /*nv_poltyp = "V" + SUBSTRING(wdetail.policy,3,2).*//*Comment A53-0111*/
    nv_poltyp = wdetail.poltyp.

IF no_class  <>  " " THEN DO:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp AND
        sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN DO:
        ASSIGN
            wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
            wdetail.pass    = "N"   
            WDETAIL.OK_GEN  = "N".
    END.
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
         sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sicsyac.xmm016 THEN 
       ASSIGN
            wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
            wdetail.pass    = "N"    
            WDETAIL.OK_GEN  = "N".
    ELSE 
        ASSIGN    
            wdetail.tariff  =   sicsyac.xmm016.tardef
            no_class        =   sicsyac.xmm016.class
            nv_sclass       =   SUBSTR(no_class,2,3).
END.
FIND sicsyac.sym100 USE-INDEX sym10001       WHERE
     sicsyac.sym100.tabcod = "u014"          AND 
     sicsyac.sym100.itmcod =  wdetail.vehuse NO-LOCK NO-ERROR NO-WAIT.
 IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
        wdetail.pass    = "N" 
        WDETAIL.OK_GEN  = "N".
 FIND  sicsyac.sym100 USE-INDEX sym10001  WHERE
     sicsyac.sym100.tabcod = "u013"         AND
     sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR NO-WAIT.
 IF NOT AVAIL sicsyac.sym100 THEN 
     ASSIGN
         wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
         wdetail.pass    = "N"    
         WDETAIL.OK_GEN  = "N".
 /*--- Comment A53-0111 ---
 /*---------- fleet -------------------*/
 IF INTE(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 THEN 
     ASSIGN
         wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
         wdetail.pass    = "N"    
         WDETAIL.OK_GEN  = "N".
 ---- End Comment A53-0111 ---*/  
 /*----------  access -------------------*/
 IF  wdetail.access  =  "y"  THEN DO:  
     IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR
         nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
         THEN  wdetail.access  =  "y".         
     ELSE DO:
         MESSAGE "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  VIEW-AS ALERT-BOX.
         ASSIGN
             wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
             wdetail.pass    = "N"    
             WDETAIL.OK_GEN  = "N".
     END.
 END.  

 /*----------  ncb -------------------*/
 IF (DECI(nv_ncb) = 0 )  OR (DECI(nv_ncb) = 20 ) OR
    (DECI(nv_ncb) = 30 ) OR (DECI(nv_ncb) = 40 ) OR
    (DECI(nv_ncb) = 50 )    THEN DO:
 END.
 ELSE 
     ASSIGN
         wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
         wdetail.pass    = "N"   
         WDETAIL.OK_GEN  = "N".
 
 NV_NCBPER = INTE(nv_NCB).
 IF nv_ncbper  <> 0 THEN DO:
     FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
         sicsyac.xmm104.tariff = wdetail.tariff    AND
         sicsyac.xmm104.class  = wdetail.subclass  AND
         sicsyac.xmm104.covcod = wdetail.covcod    AND
         sicsyac.xmm104.ncbper = INTE(nv_ncb) NO-LOCK NO-ERROR NO-WAIT.
     IF NOT AVAIL  sicsyac.xmm104  THEN 
         ASSIGN
             wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
             wdetail.pass    = "N"     
             WDETAIL.OK_GEN  = "N".
     ELSE ASSIGN nv_ncbper = xmm104.ncbper   /*A63-0174*/
                 nv_ncbyrs = xmm104.ncbyrs.  /*A63-0174*/
    
 END. /*ncb <> 0*/

 /******* drivernam **********/
 nv_sclass = wdetail.subclass. 
 IF  wdetail.drivnam = "y" AND SUBSTR(nv_sclass,2,1) = "2"   THEN 
     ASSIGN
         wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
         wdetail.pass    = "N"    
             WDETAIL.OK_GEN  = "N".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 C-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
        /*wdetail.subclass = wdetail.prempa + wdetail.subclass.*/
        /*------------------  renew ---------------------*/
    RUN proc_cr_2.
    ASSIGN 
        nv_ncb    = 0 /*a63-0174*/
        nv_ncbper = 0 /*a63-0174*/
        n_rencnt  = 0
        n_endcnt  = 0
        nv_chkexp = "" .  /*A64-0205 เช็คข้อมูลฝั่งใบเตือน */

     /* create by : A60-0383*/
    ASSIGN nv_cover = "".
    IF wdetail.covcod = "2+" THEN DO:
        ASSIGN nv_cover       = "2+" 
               wdetail.covcod = "2.2" .
    END.
    ELSE IF  wdetail.covcod = "3+" THEN DO:
        ASSIGN nv_cover       = "3+" 
               wdetail.covcod = "3.2" .
    END.
    ELSE IF INDEX(wdetail.covcod,"2.") <> 0 THEN ASSIGN nv_cover = "2+".
    ELSE IF INDEX(wdetail.covcod,"3.") <> 0 THEN ASSIGN nv_cover = "3+".
    ELSE ASSIGN nv_cover = trim(wdetail.covcod) .
    
    ASSIGN 
        nv_postcd          = ""  
        wdetail.br_insured = "00000".
    RUN proc_assign2addr  (INPUT-OUTPUT wdetail.iadd1    
                          ,INPUT-OUTPUT wdetail.iadd2    
                          ,INPUT-OUTPUT wdetail.iadd3 
                          ,INPUT-OUTPUT wdetail.iadd4  
                          ,INPUT-OUTPUT wdetail.occup   
                          ,INPUT-OUTPUT wdetail.codeocc   
                          ,INPUT-OUTPUT wdetail.codeaddr1 
                          ,INPUT-OUTPUT wdetail.codeaddr2 
                          ,INPUT-OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN  wdetail.postcd  = nv_postcd.
    
    ASSIGN nv_ckaddr = wdetail.iadd1.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add01:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd2 = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd2
                    nv_ckaddr     = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        ASSIGN wdetail.iadd1 = nv_ckaddr.
            
    END.
    nv_ckaddr     = wdetail.iadd2.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd3    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd3
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd2 = nv_ckaddr.
    END.
    nv_ckaddr = wdetail.iadd3.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd4    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd4
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd3 = nv_ckaddr.
    END.
    RUN proc_matchtypins (INPUT wdetail.tiname      
                         ,INPUT trim(wdetail.insnam)
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    RUN proc_susspect.
    RUN proc_colorcode .  /*A66-0160*/
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF nv_cover = "1" AND trim(wdetail.camp) <> "" THEN DO:
         FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                   wcampaign.nclass = trim(wdetail.subclass) AND
                                   /*wcampaign.pack   = trim(wdetail.Prempa)   AND */
                                   wcampaign.camp   = trim(wdetail.camp)    NO-LOCK NO-ERROR.
        IF AVAIL wcampaign THEN DO:
            ASSIGN /* wdetail.camp   = wcampaign.camp */
                    wdetail.NO_41  = deci(wcampaign.n41) 
                    wdetail.NO_42  = deci(wcampaign.n42) 
                    wdetail.NO_43  = deci(wcampaign.n43) 
                    wdetail.uom1_v = deci(wcampaign.bi) 
                    wdetail.uom2_v = deci(wcampaign.pd1) 
                    wdetail.uom5_v = deci(wcampaign.pd2) .
        END.
        ELSE ASSIGN wdetail.NO_41  =  0
                    wdetail.NO_42  =  0
                    wdetail.NO_43  =  0
                    wdetail.uom1_v =  0
                    wdetail.uom2_v =  0
                    wdetail.uom5_v =  0.
    END.
    ELSE DO:
    /* END A60-0545*/
        FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                  wcampaign.campno = TRIM(wdetail.garage) AND /*A63-0174*/
                                  wcampaign.nclass = trim(wdetail.subclass) AND
                                  wcampaign.pack   = trim(wdetail.Prempa)   NO-LOCK NO-ERROR.
            IF AVAIL wcampaign THEN DO:
                ASSIGN  wdetail.camp   = wcampaign.camp
                        wdetail.NO_41  = deci(wcampaign.n41) 
                        wdetail.NO_42  = deci(wcampaign.n42) 
                        wdetail.NO_43  = deci(wcampaign.n43) 
                        wdetail.uom1_v = deci(wcampaign.bi) 
                        wdetail.uom2_v = deci(wcampaign.pd1) 
                        wdetail.uom5_v = deci(wcampaign.pd2) .
            END.
            ELSE ASSIGN wdetail.NO_41  =  0
                        wdetail.NO_42  =  0  
                        wdetail.NO_43  =  0  
                        wdetail.uom1_v =  0  
                        wdetail.uom2_v =  0  
                        wdetail.uom5_v =  0  .
            /* end A60-0383*/
    END.
    IF wdetail.poltyp = "V70" THEN DO:
        IF wdetail.renpol <> "" THEN DO:
            RUN proc_renew.
           
            IF wdetail.Producer = "A0M0049" AND wdetail.renpol <> "" THEN DO: 
                IF LENGTH(wdetail.renpol) < 12 THEN ASSIGN wdetail.Producer = "B3MLTTB101" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" .  /*A64-0205*/
                ELSE ASSIGN wdetail.Producer = "B3MLTTB105" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . /*A64-0205*/
            END.
            ELSE IF wdetail.Producer = "B3MLTTB101" AND wdetail.renpol <> "" THEN 
                ASSIGN wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTTB105" AND wdetail.renpol <> "" THEN 
                ASSIGN wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . /*A64-0205*/  
            
            RUN proc_chkcode . /* A64-0205 */

            RUN Proc_Renew01.
            RUN Proc_RePolicy.
            RUN Proc_Renew02.
            RUN Proc_Renew03.
        END.
        ELSE DO:
            IF      wdetail.Producer = "A0M0039"    THEN ASSIGN  wdetail.Producer = "B3MLTTB201" 
                                                                 wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "B3MLTTB201" THEN ASSIGN  wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "A0M0049"    THEN ASSIGN  wdetail.Producer = "B3MLTTB101" 
                                                                 wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTTB101" THEN ASSIGN  wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "A0M0014"    THEN ASSIGN  wdetail.Producer = "B3MLTTB102" 
                                                                 wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTTB102" THEN ASSIGN  wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTTB105" THEN ASSIGN  wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . /*A64-0205*/

            ASSIGN
                wdetail.seat41   = 0
                nv_bipp00        = 0
                nv_bipa00        = 0
                nv_bipd00        = 0
                wdetail.prempa   = wdetail.prempa
                wdetail.subclass = wdetail.subclass
                nv_Camcode       = "".
            wdetail.subclass = trim(wdetail.prempa) + trim(wdetail.subclass).

            RUN proc_chkcode . /* A64-0205 */

            RUN proc_chktest0.
            RUN proc_policy . 
            RUN proc_chktest2.
            RUN proc_chktest3.
        END.
            
        RUN proc_chktest4.
    END.

    IF wdetail.poltyp = "V72" THEN DO:
        
        IF wdetail.renpol <> " " THEN DO:
            RUN proc_renew.
            IF LENGTH(wdetail.subclass) = 3 THEN wdetail.subclass = wdetail.subclass.
            ELSE wdetail.subclass = SUBSTRING(wdetail.subclass,2,3).
            wdetail.poltyp   = "V72".
        END.
        /* create by : A60-0383*/
        IF rapolicy = 2 THEN DO:
            IF DECI(wdetail.Comppre)      = 645.21   THEN wdetail.subclass = "110".
            ELSE IF DECI(wdetail.comppre) = 967.28   THEN wdetail.subclass = "140A".
            ELSE IF DECI(wdetail.comppre) = 1182.35  THEN wdetail.subclass = "120A".
            ELSE IF DECI(wdetail.comppre) = 1408.12  THEN wdetail.subclass = "140C".
            ELSE IF DECI(wdetail.comppre) = 2493.10  THEN wdetail.subclass = "220A".
        END. /* end A60-0383*/
        ELSE DO:
            IF wdetail.subclass = "320" THEN wdetail.subclass = "140A".
            IF wdetail.subclass = "210" THEN wdetail.subclass = "120A".
            IF wdetail.subclass = "220" THEN wdetail.subclass = "220A".
        END.

        ASSIGN 
            n_rencnt  = 0
            n_endcnt  = 0 .

        RUN proc_chkcode . /* A64-0205 */
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message). 
    END.
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1-bp C-Win 
PROCEDURE proc_chktest1-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
        /*wdetail.subclass = wdetail.prempa + wdetail.subclass.*/
        /*------------------  renew ---------------------*/
    RUN proc_cr_2.
    ASSIGN 
        nv_ncb   = 0 /*a63-0174*/
        nv_ncbper = 0 /*a63-0174*/
        n_rencnt = 0
        n_endcnt = 0.
     /* create by : A60-0383*/
    ASSIGN nv_cover = "".
    IF wdetail.covcod = "2+" THEN DO:
        ASSIGN nv_cover       = "2+" 
               wdetail.covcod = "2.2" .
    END.
    ELSE IF  wdetail.covcod = "3+" THEN DO:
        ASSIGN nv_cover       = "3+" 
               wdetail.covcod = "3.2" .
    END.
    ELSE IF INDEX(wdetail.covcod,"2.") <> 0 THEN ASSIGN nv_cover = "2+".
    ELSE IF INDEX(wdetail.covcod,"3.") <> 0 THEN ASSIGN nv_cover = "3+".
    ELSE ASSIGN nv_cover = trim(wdetail.covcod) .
    /*a60-0545*/
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /*ตัวอย่าง
    wdetail.iadd1  = "291/40 ชุมชนบ้านมนังคศิลา" 
    wdetail.iadd2  = "แขวงสี่แยกมหานาค"
    wdetail.iadd3  = "เขตดุสิต กรุงเทพมหานคร" 
    wdetail.iadd4  = "10300". */
    ASSIGN 
        nv_postcd          = ""  
        wdetail.br_insured = "00000".
    RUN proc_assign2addr  (INPUT-OUTPUT wdetail.iadd1    
                          ,INPUT-OUTPUT wdetail.iadd2    
                          ,INPUT-OUTPUT wdetail.iadd3 
                          ,INPUT-OUTPUT wdetail.iadd4  
                          ,INPUT-OUTPUT wdetail.occup   
                          ,INPUT-OUTPUT wdetail.codeocc   
                          ,INPUT-OUTPUT wdetail.codeaddr1 
                          ,INPUT-OUTPUT wdetail.codeaddr2 
                          ,INPUT-OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN  wdetail.postcd  = nv_postcd.
    
    ASSIGN nv_ckaddr = wdetail.iadd1.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add01:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd2 = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd2
                    nv_ckaddr     = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        ASSIGN wdetail.iadd1 = nv_ckaddr.
            
    END.
    nv_ckaddr     = wdetail.iadd2.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd3    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd3
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd2 = nv_ckaddr.
    END.
    nv_ckaddr = wdetail.iadd3.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd4    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd4
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd3 = nv_ckaddr.
    END.
    RUN proc_matchtypins (INPUT wdetail.tiname      
                         ,INPUT trim(wdetail.insnam)
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).

    wdetail.insnam = TRIM(trim(wdetail.firstname)  + " " + trim(wdetail.lastName)) . /*A64-0205*/

    RUN proc_susspect.
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF nv_cover = "1" AND trim(wdetail.camp) <> "" THEN DO:
         FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                   wcampaign.nclass = trim(wdetail.subclass) AND
                                   /*wcampaign.pack   = trim(wdetail.Prempa)   AND */
                                   wcampaign.camp   = trim(wdetail.camp)    NO-LOCK NO-ERROR.
        IF AVAIL wcampaign THEN DO:
            ASSIGN /* wdetail.camp   = wcampaign.camp */
                    wdetail.NO_41  = deci(wcampaign.n41) 
                    wdetail.NO_42  = deci(wcampaign.n42) 
                    wdetail.NO_43  = deci(wcampaign.n43) 
                    wdetail.uom1_v = deci(wcampaign.bi) 
                    wdetail.uom2_v = deci(wcampaign.pd1) 
                    wdetail.uom5_v = deci(wcampaign.pd2) .
        END.
        ELSE ASSIGN wdetail.NO_41  =  0
                    wdetail.NO_42  =  0
                    wdetail.NO_43  =  0
                    wdetail.uom1_v =  0
                    wdetail.uom2_v =  0
                    wdetail.uom5_v =  0.
    END.
    ELSE DO:
    /* END A60-0545*/
        FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                  wcampaign.campno = TRIM(wdetail.garage) AND /*A63-0174*/
                                  wcampaign.nclass = trim(wdetail.subclass) AND
                                  wcampaign.pack   = trim(wdetail.Prempa)   NO-LOCK NO-ERROR.
            IF AVAIL wcampaign THEN DO:
                ASSIGN  wdetail.camp   = wcampaign.camp
                        wdetail.NO_41  = deci(wcampaign.n41) 
                        wdetail.NO_42  = deci(wcampaign.n42) 
                        wdetail.NO_43  = deci(wcampaign.n43) 
                        wdetail.uom1_v = deci(wcampaign.bi) 
                        wdetail.uom2_v = deci(wcampaign.pd1) 
                        wdetail.uom5_v = deci(wcampaign.pd2) .
            END.
            ELSE ASSIGN wdetail.NO_41  =  0
                        wdetail.NO_42  =  0  
                        wdetail.NO_43  =  0  
                        wdetail.uom1_v =  0  
                        wdetail.uom2_v =  0  
                        wdetail.uom5_v =  0  .
            /* end A60-0383*/
    END.
    IF wdetail.poltyp = "V70" THEN DO:
        IF wdetail.renpol <> "" THEN DO:
            RUN proc_renew.
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            IF      wdetail.Producer = "A0M0049"    AND wdetail.renpol <> "" THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB101" AND wdetail.renpol <> "" THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . 
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            ELSE IF wdetail.Producer = "B3MLTMB105" AND wdetail.renpol <> "" THEN ASSIGN wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . /*A64-0205*/  
            
            RUN Proc_Renew01.
            RUN Proc_RePolicy.
            RUN Proc_Renew02.
            RUN Proc_Renew03.
        END.
        ELSE DO:
            /*--- Add A55-0235 ---*/
            /* comment by A60-0545.............
            IF rapolicy = 1 AND SUBSTRING(wdetail.cedpol,6,1) <> "U" THEN DO: 
                RUN ProcCampaign.
            END.
            ELSE DO:
            ... end A60-0545.......*/
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            IF      wdetail.Producer = "A0M0039"    THEN ASSIGN wdetail.Producer = "B3MLTMB201" wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "B3MLTMB201" THEN ASSIGN wdetail.Producer = "B3MLTMB201" wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "A0M0049"    THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB101" THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "A0M0014"    THEN ASSIGN wdetail.Producer = "B3MLTMB102" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB102" THEN ASSIGN wdetail.Producer = "B3MLTMB102" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            ELSE IF wdetail.Producer = "B3MLTMB105" THEN ASSIGN  wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . /*A64-0205*/
            ASSIGN
               /* WDETAIL.no_41    = 0  -- A60-0383--*/
               /* WDETAIL.no_42    = 0  -- A60-0383--*/
               /* WDETAIL.no_43    = 0  -- A60-0383--*/
                wdetail.seat41   = 0
                nv_bipp00        = 0
                nv_bipa00        = 0
                nv_bipd00        = 0
                wdetail.prempa   = wdetail.prempa
                wdetail.subclass = wdetail.subclass
                nv_Camcode       = "".
           /* END. */ /*A60-0545*/
            /*--- END Add A55-0235 ---*/
            wdetail.subclass = trim(wdetail.prempa) + trim(wdetail.subclass).
            /*--- Comment Renew A53-0111 ---
            RUN proc_chktest0.
            RUN proc_policy . 
            RUN proc_chktest2.      
            RUN proc_chktest3.      
            RUN proc_chktest4.
            
            IF wdetail.compul = "Y" THEN DO:
                wdetail.subclass = SUBSTRING(wdetail.subclass,2,LENGTH(wdetail.subclass)).
                ASSIGN
                    wdetail.poltyp = "V72"
                    wdetail.policy = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
                    wdetail.cr_2   = "70" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
                RUN proc_72.
                RUN proc_policy. 
                RUN proc_722.
                RUN proc_723 (INPUT  s_recid1,       
                              INPUT  s_recid2,
                              INPUT  s_recid3,
                              INPUT  s_recid4,
                              INPUT-OUTPUT nv_message).    
            END. 
            ---- End Comment Renew A53-0111 ----*/
            IF      wdetail.Producer = "A0M0014"        THEN ASSIGN wdetail.Producer =  "B3MLTMB102"  wdetail.campaign_ov  = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB102"     THEN ASSIGN wdetail.Producer =  "B3MLTMB102"  wdetail.campaign_ov  = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "A0M0039"        THEN ASSIGN wdetail.Producer =  "B3MLTMB201"  wdetail.campaign_ov  = "REDPLATE" wdetail.financecd = "FNB" .   
            ELSE IF wdetail.Producer = "B3MLTMB201"     THEN ASSIGN wdetail.Producer =  "B3MLTMB201"  wdetail.campaign_ov  = "REDPLATE" wdetail.financecd = "FNB" .   

            RUN proc_chktest0.
            RUN proc_policy . 
            RUN proc_chktest2.
            RUN proc_chktest3.
        END.
            
        RUN proc_chktest4.
        /*--- Comment A54-0076 ---
        IF wdetail.compul = "Y" THEN DO:
            
            wdetail.subclass = TRIM(SUBSTRING(wdetail.subclass,2,LENGTH(wdetail.subclass))).
            /*--- Comment A53-0111 Edit Vol.1 13/10/2010
            IF wdetail.subclass = "320" THEN wdetail.subclass = "140A".
            IF wdetail.subclass = "210" THEN wdetail.subclass = "120A".
            IF wdetail.subclass = "220" THEN wdetail.subclass = "220A".
            ----*/

            ASSIGN
                wdetail.poltyp = "V72"
                wdetail.policy = TRIM("72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)))
                wdetail.cr_2   = TRIM("70" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy))).
            /*--- Comment A53-0111 Edit Vol.1 13/10/2010
            RUN proc_72.
            RUN proc_policy. 
            RUN proc_722.
            RUN proc_723 (INPUT  s_recid1,       
                          INPUT  s_recid2,
                          INPUT  s_recid3,
                          INPUT  s_recid4,
                          INPUT-OUTPUT nv_message).
            -----*/    
        END. /* wdetail.compul = "Y" */ 
        --- End Comment A54-0076 --*/ 
    END.

    IF wdetail.poltyp = "V72" THEN DO:

        /*--- A54-0076 ---*/
        IF wdetail.renpol <> " " THEN DO:
            RUN proc_renew.
            IF LENGTH(wdetail.subclass) = 3 THEN wdetail.subclass = wdetail.subclass.
            ELSE wdetail.subclass = SUBSTRING(wdetail.subclass,2,3).
            wdetail.poltyp   = "V72".
        END.
        /* create by : A60-0383*/
        IF rapolicy = 2 THEN DO:
            IF DECI(wdetail.Comppre)      = 645.21   THEN wdetail.subclass = "110".
            ELSE IF DECI(wdetail.comppre) = 967.28   THEN wdetail.subclass = "140A".
            ELSE IF DECI(wdetail.comppre) = 1182.35  THEN wdetail.subclass = "120A".
            ELSE IF DECI(wdetail.comppre) = 1408.12  THEN wdetail.subclass = "140C".
            ELSE IF DECI(wdetail.comppre) = 2493.10  THEN wdetail.subclass = "220A".
        END. /* end A60-0383*/
        ELSE DO:
            IF wdetail.subclass = "320" THEN wdetail.subclass = "140A".
            IF wdetail.subclass = "210" THEN wdetail.subclass = "120A".
            IF wdetail.subclass = "220" THEN wdetail.subclass = "220A".
        END.
        /*--- Comment A54-0076 ---
        ASSIGN
           wdetail.poltyp = "V72"
           wdetail.policy = TRIM("72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy))).
         --- End Comment A54-0076 ---*/
            RUN proc_72.
            RUN proc_policy. 
            RUN proc_722.
            RUN proc_723 (INPUT  s_recid1,       
                          INPUT  s_recid2,
                          INPUT  s_recid3,
                          INPUT  s_recid4,
                          INPUT-OUTPUT nv_message). 
    END.
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1-bp2 C-Win 
PROCEDURE proc_chktest1-bp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
        /*wdetail.subclass = wdetail.prempa + wdetail.subclass.*/
        /*------------------  renew ---------------------*/
    RUN proc_cr_2.
    ASSIGN 
        nv_ncb    = 0 /*a63-0174*/
        nv_ncbper = 0 /*a63-0174*/
        n_rencnt  = 0
        n_endcnt  = 0
        nv_chkexp = "" .  /*A64-0205 เช็คข้อมูลฝั่งใบเตือน */

     /* create by : A60-0383*/
    ASSIGN nv_cover = "".
    IF wdetail.covcod = "2+" THEN DO:
        ASSIGN nv_cover       = "2+" 
               wdetail.covcod = "2.2" .
    END.
    ELSE IF  wdetail.covcod = "3+" THEN DO:
        ASSIGN nv_cover       = "3+" 
               wdetail.covcod = "3.2" .
    END.
    ELSE IF INDEX(wdetail.covcod,"2.") <> 0 THEN ASSIGN nv_cover = "2+".
    ELSE IF INDEX(wdetail.covcod,"3.") <> 0 THEN ASSIGN nv_cover = "3+".
    ELSE ASSIGN nv_cover = trim(wdetail.covcod) .
    /*a60-0545*/
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /*ตัวอย่าง
    wdetail.iadd1  = "291/40 ชุมชนบ้านมนังคศิลา" 
    wdetail.iadd2  = "แขวงสี่แยกมหานาค"
    wdetail.iadd3  = "เขตดุสิต กรุงเทพมหานคร" 
    wdetail.iadd4  = "10300". */
    ASSIGN 
        nv_postcd          = ""  
        wdetail.br_insured = "00000".
    RUN proc_assign2addr  (INPUT-OUTPUT wdetail.iadd1    
                          ,INPUT-OUTPUT wdetail.iadd2    
                          ,INPUT-OUTPUT wdetail.iadd3 
                          ,INPUT-OUTPUT wdetail.iadd4  
                          ,INPUT-OUTPUT wdetail.occup   
                          ,INPUT-OUTPUT wdetail.codeocc   
                          ,INPUT-OUTPUT wdetail.codeaddr1 
                          ,INPUT-OUTPUT wdetail.codeaddr2 
                          ,INPUT-OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN  wdetail.postcd  = nv_postcd.
    
    ASSIGN nv_ckaddr = wdetail.iadd1.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add01:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd2 = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd2
                    nv_ckaddr     = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        ASSIGN wdetail.iadd1 = nv_ckaddr.
            
    END.
    nv_ckaddr     = wdetail.iadd2.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd3    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd3
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd2 = nv_ckaddr.
    END.
    nv_ckaddr = wdetail.iadd3.
    IF LENGTH(nv_ckaddr) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_ckaddr) > 35 :
            IF R-INDEX(nv_ckaddr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.iadd4    = trim(SUBSTR(nv_ckaddr,r-INDEX(nv_ckaddr," "))) + " " + wdetail.iadd4
                    nv_ckaddr   = trim(SUBSTR(nv_ckaddr,1,r-INDEX(nv_ckaddr," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        ASSIGN wdetail.iadd3 = nv_ckaddr.
    END.
    RUN proc_matchtypins (INPUT wdetail.tiname      
                         ,INPUT trim(wdetail.insnam)
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    RUN proc_susspect.
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF nv_cover = "1" AND trim(wdetail.camp) <> "" THEN DO:
         FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                   wcampaign.nclass = trim(wdetail.subclass) AND
                                   /*wcampaign.pack   = trim(wdetail.Prempa)   AND */
                                   wcampaign.camp   = trim(wdetail.camp)    NO-LOCK NO-ERROR.
        IF AVAIL wcampaign THEN DO:
            ASSIGN /* wdetail.camp   = wcampaign.camp */
                    wdetail.NO_41  = deci(wcampaign.n41) 
                    wdetail.NO_42  = deci(wcampaign.n42) 
                    wdetail.NO_43  = deci(wcampaign.n43) 
                    wdetail.uom1_v = deci(wcampaign.bi) 
                    wdetail.uom2_v = deci(wcampaign.pd1) 
                    wdetail.uom5_v = deci(wcampaign.pd2) .
        END.
        ELSE ASSIGN wdetail.NO_41  =  0
                    wdetail.NO_42  =  0
                    wdetail.NO_43  =  0
                    wdetail.uom1_v =  0
                    wdetail.uom2_v =  0
                    wdetail.uom5_v =  0.
    END.
    ELSE DO:
    /* END A60-0545*/
        FIND LAST wcampaign WHERE wcampaign.cover  = trim(nv_cover) AND 
                                  wcampaign.campno = TRIM(wdetail.garage) AND /*A63-0174*/
                                  wcampaign.nclass = trim(wdetail.subclass) AND
                                  wcampaign.pack   = trim(wdetail.Prempa)   NO-LOCK NO-ERROR.
            IF AVAIL wcampaign THEN DO:
                ASSIGN  wdetail.camp   = wcampaign.camp
                        wdetail.NO_41  = deci(wcampaign.n41) 
                        wdetail.NO_42  = deci(wcampaign.n42) 
                        wdetail.NO_43  = deci(wcampaign.n43) 
                        wdetail.uom1_v = deci(wcampaign.bi) 
                        wdetail.uom2_v = deci(wcampaign.pd1) 
                        wdetail.uom5_v = deci(wcampaign.pd2) .
            END.
            ELSE ASSIGN wdetail.NO_41  =  0
                        wdetail.NO_42  =  0  
                        wdetail.NO_43  =  0  
                        wdetail.uom1_v =  0  
                        wdetail.uom2_v =  0  
                        wdetail.uom5_v =  0  .
            /* end A60-0383*/
    END.
    IF wdetail.poltyp = "V70" THEN DO:
        IF wdetail.renpol <> "" THEN DO:
            RUN proc_renew.
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            IF wdetail.Producer = "A0M0049" AND wdetail.renpol <> "" THEN DO: 
                IF LENGTH(wdetail.renpol) < 12 THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" .  /*A64-0205*/
                ELSE ASSIGN wdetail.Producer = "B3MLTMB105" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . /*A64-0205*/
            END.
            ELSE IF wdetail.Producer = "B3MLTMB101" AND wdetail.renpol <> "" THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . 
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            ELSE IF wdetail.Producer = "B3MLTMB105" AND wdetail.renpol <> "" THEN ASSIGN wdetail.campaign_ov = "RENEW"  wdetail.financecd = "FNB" . /*A64-0205*/  
            
            RUN proc_chkcode . /* A64-0205 */

            RUN Proc_Renew01.
            RUN Proc_RePolicy.
            RUN Proc_Renew02.
            RUN Proc_Renew03.
        END.
        ELSE DO:
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            IF      wdetail.Producer = "A0M0039"    THEN ASSIGN wdetail.Producer = "B3MLTMB201" wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "B3MLTMB201" THEN ASSIGN wdetail.Producer = "B3MLTMB201" wdetail.campaign_ov = "REDPLATE" wdetail.financecd = "FTB" . 
            ELSE IF wdetail.Producer = "A0M0049"    THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB101" THEN ASSIGN wdetail.Producer = "B3MLTMB101" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "A0M0014"    THEN ASSIGN wdetail.Producer = "B3MLTMB102" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            ELSE IF wdetail.Producer = "B3MLTMB102" THEN ASSIGN wdetail.Producer = "B3MLTMB102" wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . 
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            ELSE IF wdetail.Producer = "B3MLTMB105" THEN ASSIGN  wdetail.campaign_ov = "TRANSF"   wdetail.financecd = "FNB" . /*A64-0205*/
            ASSIGN
                wdetail.seat41   = 0
                nv_bipp00        = 0
                nv_bipa00        = 0
                nv_bipd00        = 0
                wdetail.prempa   = wdetail.prempa
                wdetail.subclass = wdetail.subclass
                nv_Camcode       = "".

            wdetail.subclass = trim(wdetail.prempa) + trim(wdetail.subclass).

            RUN proc_chkcode . /* A64-0205 */

            RUN proc_chktest0.
            RUN proc_policy . 
            RUN proc_chktest2.
            RUN proc_chktest3.
        END.
            
        RUN proc_chktest4.
    END.

    IF wdetail.poltyp = "V72" THEN DO:
        
        IF wdetail.renpol <> " " THEN DO:
            RUN proc_renew.
            IF LENGTH(wdetail.subclass) = 3 THEN wdetail.subclass = wdetail.subclass.
            ELSE wdetail.subclass = SUBSTRING(wdetail.subclass,2,3).
            wdetail.poltyp   = "V72".
        END.
        /* create by : A60-0383*/
        IF rapolicy = 2 THEN DO:
            IF DECI(wdetail.Comppre)      = 645.21   THEN wdetail.subclass = "110".
            ELSE IF DECI(wdetail.comppre) = 967.28   THEN wdetail.subclass = "140A".
            ELSE IF DECI(wdetail.comppre) = 1182.35  THEN wdetail.subclass = "120A".
            ELSE IF DECI(wdetail.comppre) = 1408.12  THEN wdetail.subclass = "140C".
            ELSE IF DECI(wdetail.comppre) = 2493.10  THEN wdetail.subclass = "220A".
        END. /* end A60-0383*/
        ELSE DO:
            IF wdetail.subclass = "320" THEN wdetail.subclass = "140A".
            IF wdetail.subclass = "210" THEN wdetail.subclass = "120A".
            IF wdetail.subclass = "220" THEN wdetail.subclass = "220A".
        END.

        ASSIGN 
            n_rencnt  = 0
            n_endcnt  = 0 .

        RUN proc_chkcode . /* A64-0205 */
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message). 
    END.
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 C-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Update Table UWM130/UWM301" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.

FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
     sic_bran.uwm130.policy = sic_bran.uwm100.policy  AND
     sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
     sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
     sic_bran.uwm130.riskgp = s_riskgp                AND
     sic_bran.uwm130.riskno = s_riskno                AND
     sic_bran.uwm130.itemno = s_itemno                AND
     sic_bran.uwm130.bchyr  = nv_batchyr              AND
     sic_bran.uwm130.bchno  = nv_batchno              AND
     sic_bran.uwm130.bchcnt = nv_batcnt               NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm130 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN
            sic_bran.uwm130.policy  = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt   
            sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp  = sic_bran.uwm120.riskgp   
            sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno  = s_itemno
            sic_bran.uwm130.bchyr   = nv_batchyr          /* batch Year */
            sic_bran.uwm130.bchno   = nv_batchno          /* bchno      */
            sic_bran.uwm130.bchcnt  = nv_batcnt.        /* bchcnt     */

        IF wdetail.access = "0" THEN DO:
            nv_uom6_u =  "A".
        END.
        ELSE DO:
           ASSIGN             
              nv_uom6_u     = ""
              nv_othcod     = ""
              nv_othvar1    = ""
              nv_othvar2    = ""
              SUBSTRING(nv_othvar,1,30)  = nv_othvar1
              SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        END.

        nv_sclass = SUBSTRING(wdetail.subclass,2,3).

        IF nv_uom6_u  =  "A"  THEN DO:
            IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR
                nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
            THEN  nv_uom6_u  =  "A".         
            ELSE
                ASSIGN
                    wdetail.pass    = "N".
                    wdetail.comment = wdetail.comment + "| Class นี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
        END. 

        IF CAPS(nv_uom6_u) = "A"  THEN DO:
            ASSIGN  nv_uom6_u              = "A"
                nv_othcod                  = "OTH"
                nv_othvar1                 = "     Accessory  = "
                nv_othvar2                 =  STRING(nv_uom6_u)
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        END.
        ELSE DO:
            ASSIGN  nv_uom6_u              = ""
                nv_othcod                  = ""
                nv_othvar1                 = ""
                nv_othvar2                 = ""
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        END.
        /*---- Cover Code ---*/
        IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")     OR
           (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR /* A60-0327*/
           (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: /* A60-0327*/
            ASSIGN
                sic_bran.uwm130.uom1_v   =  wdetail.uom1_v      /*A60-0383*/
                sic_bran.uwm130.uom2_v   =  wdetail.uom2_v      /*A60-0383*/
                sic_bran.uwm130.uom5_v   =  wdetail.uom5_v      /*A60-0383*/
                sic_bran.uwm130.uom6_v   = INTE(wdetail.si)
                sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        IF wdetail.covcod = "2"  THEN DO:
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        IF wdetail.covcod = "3"  THEN DO:
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = 0
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.

        /*--- ร.ย. ความคุ้มครอง ---*/
        /*--- Add A55-0235 ---*/
        IF wdetail.Tariff = "" THEN DO:
            IF wdetail.poltyp = "V70" THEN wdetail.Tariff = "X".
            ELSE IF wdetail.poltyp = "V72" THEN wdetail.Tariff = "9".
        END.
        
        FIND FIRST brstat.clastab_fil USE-INDEX clastab01 WHERE
                   brstat.clastab_fil.class   = trim(wdetail.subclass) AND
                   brstat.clastab_fil.covcod  = trim(wdetail.covcod)   NO-LOCK NO-ERROR.
        IF AVAIL brstat.clastab_fil THEN DO:
            /* create by A60-0383*/
            IF TRIM(wdetail.prempa) = "Z" THEN DO:
                Assign 
                sic_bran.uwm130.uom1_v     =  wdetail.uom1_v    
                sic_bran.uwm130.uom2_v     =  wdetail.uom2_v    
                sic_bran.uwm130.uom5_v     =  wdetail.uom5_v    
                nv_uom1_v                  =  wdetail.uom1_v    
                nv_uom2_v                  =  wdetail.uom2_v    
                nv_uom5_v                  =  wdetail.uom5_v    .
            END.
            /*end A60-0383*/
            ELSE DO:
                 ASSIGN
                    /* sic_bran.uwm130.uom1_v     =  brstat.clastab_fil.uom1_si*/ /*A60-0327*/
                    /* sic_bran.uwm130.uom2_v     =  brstat.clastab_fil.uom2_si*/ /*A60-0327*/
                    /* sic_bran.uwm130.uom5_v     =  brstat.clastab_fil.uom5_si*/ /*A60-0327*/
                     sic_bran.uwm130.uom1_v     = if wdetail.uom1_v <> 0 then wdetail.uom1_v else brstat.clastab_fil.uom1_si   /*A60-0383*/
                     sic_bran.uwm130.uom2_v     = if wdetail.uom2_v <> 0 then wdetail.uom2_v else brstat.clastab_fil.uom2_si   /*A60-0383*/
                     sic_bran.uwm130.uom5_v     = if wdetail.uom5_v <> 0 then wdetail.uom5_v else brstat.clastab_fil.uom5_si   /*A60-0383*/
                     nv_uom1_v                  = if wdetail.uom1_v <> 0 then wdetail.uom1_v else sic_bran.uwm130.uom1_v      /*A60-0383*/
                     nv_uom2_v                  = if wdetail.uom2_v <> 0 then wdetail.uom2_v else sic_bran.uwm130.uom2_v      /*A60-0383*/
                     nv_uom5_v                  = if wdetail.uom5_v <> 0 then wdetail.uom5_v else sic_bran.uwm130.uom5_v.     /*A60-0383*/
            END.

           FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
                      stat.clastab_fil.class  = brstat.clastab_fil.class  AND
                      stat.clastab_fil.covcod = brstat.clastab_fil.covcod NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                ASSIGN
                    sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
                    sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
                    sic_bran.uwm130.uom3_v     =  0
                    sic_bran.uwm130.uom4_v     =  0
                    wdetail.comper             =  stat.clastab_fil.uom8_si                
                    wdetail.comacc             =  stat.clastab_fil.uom9_si
                    sic_bran.uwm130.uom1_c     =  "D1"
                    sic_bran.uwm130.uom2_c     =  "D2"
                    sic_bran.uwm130.uom5_c     =  "D5"
                    sic_bran.uwm130.uom6_c     =  "D6"
                    sic_bran.uwm130.uom7_c     =  "D7".

                IF wdetail.no_41  = 0 THEN WDETAIL.no_41   = INTE(stat.clastab_fil.si_41unp).
                IF wdetail.no_42  = 0 THEN WDETAIL.no_42   = INTE(stat.clastab_fil.si_42).
                IF wdetail.no_43  = 0 THEN WDETAIL.no_43   = INTE(stat.clastab_fil.si_43).
                IF WDETAIL.seat41 = 0 THEN WDETAIL.seat41  = stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.
            END.
            ELSE DO:
                IF wdetail.no_41  = 0 THEN WDETAIL.no_41   = INTE(brstat.clastab_fil.si_41unp).
                IF wdetail.no_42  = 0 THEN WDETAIL.no_42   = INTE(brstat.clastab_fil.si_42).
                IF wdetail.no_43  = 0 THEN WDETAIL.no_43   = INTE(brstat.clastab_fil.si_43).
                IF WDETAIL.seat41 = 0 THEN WDETAIL.seat41  = brstat.clastab_fil.dri_41 + brstat.clastab_fil.pass_41.
            END.
        END.
        ELSE DO:
        /*END.
        IF SUBSTRING(wdetail.cedpol,6,1) = "U" THEN DO: */   /*A60-0383*/
            FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
                       stat.clastab_fil.class   = wdetail.subclass /*n_sclass72*//*A53-0111*/ AND
                       stat.clastab_fil.covcod  = wdetail.covcod   NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL stat.clastab_fil THEN DO: 
                ASSIGN 
                    sic_bran.uwm130.uom1_v     =  /*500000*/   if wdetail.uom1_v <> 0 then wdetail.uom1_v ELSE stat.clastab_fil.uom1_si      /*A60-0383*/
                    sic_bran.uwm130.uom2_v     =  /*10000000*/ if wdetail.uom2_v <> 0 then wdetail.uom2_v ELSE stat.clastab_fil.uom2_si      /*A60-0383*/
                    sic_bran.uwm130.uom5_v     =  /*1000000*/  if wdetail.uom5_v <> 0 then wdetail.uom5_v ELSE stat.clastab_fil.uom5_si      /*A60-0383*/
                    sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
                    sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
                    sic_bran.uwm130.uom3_v     =  0
                    sic_bran.uwm130.uom4_v     =  0
                    wdetail.comper             =  stat.clastab_fil.uom8_si                
                    wdetail.comacc             =  stat.clastab_fil.uom9_si
                    nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
                    nv_uom2_v                  =  sic_bran.uwm130.uom2_v
                    nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
                    sic_bran.uwm130.uom1_c     =  "D1"
                    sic_bran.uwm130.uom2_c     =  "D2"
                    sic_bran.uwm130.uom5_c     =  "D5"
                    sic_bran.uwm130.uom6_c     =  "D6"
                    sic_bran.uwm130.uom7_c     =  "D7".
        
                    IF wdetail.no_41 = 0 THEN WDETAIL.no_41   = INTE(stat.clastab_fil.si_41unp).
                    IF wdetail.no_42 = 0 THEN WDETAIL.no_42   = INTE(stat.clastab_fil.si_42).
                    IF wdetail.no_43 = 0 THEN WDETAIL.no_43   = INTE(stat.clastab_fil.si_43).
                    WDETAIL.seat41  =  stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41. 
            END.  /*stat.clastab_fil*/
        END.
        ASSIGN nv_riskno = 1    nv_itemno = 1.
    
        IF wdetail.covcod = "1" THEN DO:
            RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                    nv_riskno,
                                    nv_itemno).
        END.

    END. /*DO TRANSACTION*/
END. /*NOT AVAIL uwm130*/

s_recid3   = RECID(sic_bran.uwm130).
nv_covcod  = wdetail.covcod.
nv_makdes  = wdetail.brand.
/*nv_moddes  = wdetail.model.*/ /*A60-0383*/
nv_moddes  = IF index(wdetail.model," ") <> 0 THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE wdetail.model . /*A60-0383*/
nv_newsck  = " ".

RUN proc_chassic.

IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk.

FIND sic_bran.uwm301 USE-INDEX uwm30101  WHERE
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
        ASSIGN
            sic_bran.uwm301.policy    =  sic_bran.uwm120.policy                 
            sic_bran.uwm301.rencnt    =  sic_bran.uwm120.rencnt
            sic_bran.uwm301.endcnt    =  sic_bran.uwm120.endcnt
            sic_bran.uwm301.riskgp    =  sic_bran.uwm120.riskgp
            sic_bran.uwm301.riskno    =  sic_bran.uwm120.riskno
            sic_bran.uwm301.itemno    =  s_itemno
            sic_bran.uwm301.tariff    =  wdetail.tariff 
            sic_bran.uwm301.covcod    =  nv_covcod
            sic_bran.uwm301.cha_no    =  wdetail.chasno
            sic_bran.uwm301.trareg    =  nv_uwm301trareg
            sic_bran.uwm301.eng_no    =  wdetail.engno
            sic_bran.uwm301.Tons      =  INTEGER(wdetail.weight)
            sic_bran.uwm301.engine    =  INTEGER(wdetail.cc)
            sic_bran.uwm301.yrmanu    =  INTEGER(wdetail.caryear)
            /*sic_bran.uwm301.garage    =  IF SUBSTRING(wdetail.cedpol,6,1) = "U" THEN "" ELSE wdetail.garage*/ /*A60-0327*/
            sic_bran.uwm301.garage    =  IF nv_covcod <> "1" THEN "" ELSE trim(wdetail.garage)  /*A60-0327*/
            sic_bran.uwm301.body      =  wdetail.body
            sic_bran.uwm301.seats     =  INTEGER(wdetail.seat)
            sic_bran.uwm301.mv_ben83  =  wdetail.benname
            sic_bran.uwm301.vehreg    =  wdetail.vehreg 
            sic_bran.uwm301.vehgrp    =  TRIM(wdetail.cargrp)
            sic_bran.uwm301.yrmanu    =  INTE(wdetail.caryear)
            sic_bran.uwm301.vehuse    =  wdetail.vehuse
            sic_bran.uwm301.modcod    =  wdetail.redbook   /*A59-0070*/
            sic_bran.uwm301.moddes    =  wdetail.brand + " " + wdetail.model   
            sic_bran.uwm301.sckno     =  0
            sic_bran.uwm301.itmdel    =  NO
            sic_bran.uwm301.car_color = wdetail.ncolor       /*A66-0160*/
            /*sic_bran.uwm301.prmtxt    =  IF wdetail.renpol = "" AND rapolicy = 1 THEN wdetail.Text1 ELSE "". /*Add A53-0111*/*/ /*A60-0545*/
            sic_bran.uwm301.prmtxt    =  trim(wdetail.ACCESSORYtxt) .  /*A66-0160*/

       ASSIGN 
            sic_bran.uwm301.bchyr   = nv_batchyr       /* batch Year */
            sic_bran.uwm301.bchno   = nv_batchno       /* bchno      */
            sic_bran.uwm301.bchcnt  = nv_batcnt.      /* bchcnt     */

       IF wdetail.drivnam1 <> "" THEN wdetail.drivnam = "Y".
       RUN proc_mailtxt. /* driver name */
       s_recid4         = RECID(sic_bran.uwm301).

       /*---- Check RedBook ---*/
       /*--- Comment A59-0070 --*/
       IF wdetail.redbook <> "" THEN DO:
           FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                      stat.maktab_fil.sclass = SUBSTRING(wdetail.subclass,2,3) AND
                      stat.maktab_fil.modcod = wdetail.redbook NO-LOCK NO-ERROR NO-WAIT.
           IF AVAIL stat.maktab_fil THEN DO:
               ASSIGN
                   sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                   /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes *//*A63-00472*/
                   wdetail.cargrp          =  stat.maktab_fil.prmpac
                   sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                   sic_bran.uwm301.body    =  stat.maktab_fil.body.
           END.
       END.
       ELSE DO:
           FIND FIRST stat.makdes31 WHERE
                      stat.makdes31.makdes = "X" AND
                      stat.makdes31.moddes = wdetail.subclass NO-LOCK NO-ERROR.
           IF AVAIL stat.makdes31 THEN DO:
               FIND FIRST stat.maktab_fil WHERE
                          stat.maktab_fil.makdes   = wdetail.brand AND
                          INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0 AND
                          stat.maktab_fil.makyea   = INTE(wdetail.caryear)  AND
                          stat.maktab_fil.engine   = INTE(wdetail.CC) AND
                          stat.maktab_fil.sclass   = wdetail.subclass AND
                         (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100 ) LE INTE(wdetail.si) AND
                          stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100 ) GE INTE(wdetail.si) ) AND
                          stat.maktab_fil.seats    = INTE(wdetail.seat) NO-LOCK NO-ERROR.
               IF AVAIL stat.maktab_fil THEN DO:
                   ASSIGN
                       sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                                                /*A60-0383*/
                       sic_bran.uwm301.vehgrp  =  IF TRIM(wdetail.cargrp) <> "" THEN TRIM(wdetail.cargrp) ELSE stat.maktab_fil.prmpac   /*A60-0383*/
                       sic_bran.uwm301.body    =  IF TRIM(wdetail.body) <> "" THEN trim(wdetail.body) ELSE stat.maktab_fil.body         /*A60-0383*/
                       wdetail.cargrp          =  stat.maktab_fil.prmpac
                       wdetail.redbook         =  stat.maktab_fil.modcod .
               END.
           END.
       END.
       /*--- End Add A59-0070 --*/
       
       IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.

    END. /*DO TRANSACTION uwm301*/

END. /*sic_bran.uwm301*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Chktest2_Back C-Win 
PROCEDURE Proc_Chktest2_Back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Update Table UWM130/UWM301" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
           sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
           sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
           sic_bran.uwm130.bchyr  = nv_batchyr             AND 
           sic_bran.uwm130.bchno  = nv_batchno             AND 
           sic_bran.uwm130.bchcnt = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr = nv_batchyr          /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno          /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt.        /* bchcnt     */
    IF wdetail.access = "0" THEN DO:
        nv_uom6_u =  "A".
    END.
    ELSE DO:
       ASSIGN             
          nv_uom6_u     = ""
          nv_othcod     = ""
          nv_othvar1    = ""
          nv_othvar2    = ""
          SUBSTRING(nv_othvar,1,30)  = nv_othvar1
          SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    END.

    nv_sclass = SUBSTRING(wdetail.subclass,2,3).

    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR
            nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
            THEN  nv_uom6_u  =  "A".         
        ELSE
            ASSIGN
                wdetail.pass    = "N".
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.     

    IF CAPS(nv_uom6_u) = "A"  THEN
        ASSIGN  nv_uom6_u          = "A"
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = INTE(wdetail.si)
            sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    /*---
    IF wdetail.poltyp = "v72" THEN  n_sclass72 = "110".
    ELSE n_sclass72 = wdetail.subclass.
    ---*//*A53-0111*/
    FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               stat.clastab_fil.class   = wdetail.subclass /*n_sclass72*//*A53-0111*/       AND
               stat.clastab_fil.covcod  = wdetail.covcod   NO-LOCK  NO-ERROR NO-WAIT.
    IF AVAIL stat.clastab_fil THEN DO: 
        ASSIGN 
            sic_bran.uwm130.uom1_v     =  /*500000*/   stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     =  /*10000000*/ stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     =  /*1000000*/  stat.clastab_fil.uom5_si
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  stat.clastab_fil.uom8_si                
            wdetail.comacc             =  stat.clastab_fil.uom9_si
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c     = "D1"
            sic_bran.uwm130.uom2_c     = "D2"
            sic_bran.uwm130.uom5_c     = "D5"
            sic_bran.uwm130.uom6_c     = "D6"
            sic_bran.uwm130.uom7_c     = "D7".

        /*----
        IF  wdetail.garage  =  "G"  THEN
            ASSIGN
                WDETAIL.no_41   = 50000
                WDETAIL.no_42   = 50000
                WDETAIL.no_43   = 200000
                WDETAIL.seat41  = stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
         -----*/
       /* IF  STRING(wdetail.garage) =  "G"  THEN*/
            ASSIGN 
                WDETAIL.no_41   =  INTE(stat.clastab_fil.si_41unp)
                WDETAIL.no_42   =  INTE(stat.clastab_fil.si_42)
                WDETAIL.no_43   =  INTE(stat.clastab_fil.si_43)
                WDETAIL.seat41   = stat.clastab_fil.dri_41 + clastab_fil.pass_41. 

    END.           
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.

    IF wdetail.covcod = "1" THEN 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   wdetail.covcod.
    nv_makdes  =  wdetail.brand.
    nv_moddes  =  wdetail.model.
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
             sic_bran.uwm301.bchcnt = nv_batcnt                     
             NO-WAIT NO-ERROR.
         IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
             DO TRANSACTION:
                 CREATE sic_bran.uwm301.
             END. 
         END. 
  
         ASSIGN
             sic_bran.uwm301.policy    =  sic_bran.uwm120.policy                 
             sic_bran.uwm301.rencnt    =  sic_bran.uwm120.rencnt
             sic_bran.uwm301.endcnt    =  sic_bran.uwm120.endcnt
             sic_bran.uwm301.riskgp    =  sic_bran.uwm120.riskgp
             sic_bran.uwm301.riskno    =  sic_bran.uwm120.riskno
             sic_bran.uwm301.itemno    =  s_itemno
             sic_bran.uwm301.tariff    =  wdetail.tariff 
             sic_bran.uwm301.covcod    =  nv_covcod
             sic_bran.uwm301.cha_no    =  wdetail.chasno
             sic_bran.uwm301.trareg    =  nv_uwm301trareg
             sic_bran.uwm301.eng_no    =  wdetail.engno
             sic_bran.uwm301.Tons      =  INTEGER(wdetail.weight)
             sic_bran.uwm301.engine    =  INTEGER(wdetail.cc)
             sic_bran.uwm301.yrmanu    =  INTEGER(wdetail.caryear)
             /*sic_bran.uwm301.garage    =  IF SUBSTRING(wdetail.cedpol,6,1) = "U" THEN "" ELSE wdetail.garage*/ /*A60-0327*/
             sic_bran.uwm301.garage    =  IF nv_covcod <> "1" THEN "" ELSE trim(wdetail.garage)  /*A60-0327*/
             sic_bran.uwm301.body      =  wdetail.body
             sic_bran.uwm301.seats     =  INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  =  wdetail.benname
             sic_bran.uwm301.vehreg    =  wdetail.vehreg 
             sic_bran.uwm301.vehgrp    = wdetail.cargrp
             sic_bran.uwm301.yrmanu    =  INTE(wdetail.caryear)
             sic_bran.uwm301.vehuse    =  wdetail.vehuse
             sic_bran.uwm301.moddes    =  wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     =  0
             sic_bran.uwm301.itmdel    =  NO
             sic_bran.uwm301.prmtxt    =  IF wdetail.renpol = "" AND rapolicy = 1 THEN wdetail.Text1 ELSE "". /*Add A53-0111*/.
             /*wdetail.tariff            = sic_bran.uwm301.tariff.*//*A53-0111*/

        /*----- Comment A53-0111 ----
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
         ---- End Comment A53-0111 ---*/
         ASSIGN 
             sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
             sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
             sic_bran.uwm301.bchcnt  = nv_batcnt.      /* bchcnt     */

         IF wdetail.drivnam1 <> "" THEN wdetail.drivnam = "Y".
         RUN proc_mailtxt. /* driver name */

         s_recid4         = RECID(sic_bran.uwm301).
         /*---- Check RedBook ---*/
         IF wdetail.redbook <> "" THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                        stat.maktab_fil.sclass = SUBSTRING(wdetail.subclass,2,3) AND
                        stat.maktab_fil.modcod = wdetail.redbook NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL stat.maktab_fil THEN DO:
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body.
             END.
         END.
         ELSE DO:
             FIND FIRST stat.makdes31 WHERE
                        stat.makdes31.makdes = "X" AND
                        stat.makdes31.moddes = wdetail.subclass NO-LOCK NO-ERROR.
             IF AVAIL stat.makdes31 THEN DO:
                 FIND FIRST stat.maktab_fil WHERE
                            stat.maktab_fil.makdes = wdetail.brand AND
                            INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0 AND
                            stat.maktab_fil.makyea   = INTE(wdetail.caryear)  AND
                            stat.maktab_fil.engine   = INTE(wdetail.CC) AND
                            stat.maktab_fil.sclass   = wdetail.subclass AND
                            (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100 ) LE INTE(wdetail.si) AND
                            stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100 ) GE INTE(wdetail.si) ) AND
                            stat.maktab_fil.seats    =   INTE(wdetail.seat) NO-LOCK NO-ERROR.
                 IF AVAIL stat.maktab_fil THEN DO:
                     ASSIGN
                         wdetail.cargrp  = stat.maktab_fil.prmpac
                         wdetail.redbook = stat.maktab_fil.modcod.
                 END.
             END.
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 C-Win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Assign Parameter" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
RUN Proc_AssignClear.
ASSIGN  dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/
    nv_tariff    = sic_bran.uwm301.tariff
    nv_class     = wdetail.subclass
    nv_comdat    = sic_bran.uwm100.comdat
    nv_engine    = DECI(wdetail.cc)
    nv_tons      = DECI(wdetail.weight)
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse
    nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc) 
    nv_seats     = INTE(wdetail.seat)
    nv_tons      = DECI(wdetail.weight)
    /*nv_dss_per   = IF rapolicy = 1 THEN 0 ELSE nv_dss_per*/     
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
    /*A60-0327*/
    nv_usecod3   = ""
    nv_usevar3   = ""
    nv_usevar4   = ""
    nv_usevar5   = ""
    nv_basecod3  = ""
    nv_baseprm3  = 0
    nv_basevar3  = ""
    nv_basevar4  = ""
    nv_basevar5  = ""
    nv_sicod3    = ""
    nv_sivar3    = ""
    nv_sivar4    = ""
    nv_sivar5    = ""
    /* end A60-0327*/
    nv_ncbyrs    = 0    
    nv_ncbper    = 0
    nv_ncb       = IF rapolicy = 1 THEN 0 ELSE nv_ncb
    nv_totsi     = 0 .
/*งานต่ออายุทุกเบอร์กรมธรรม์ให้ค่า Inspection เป็นค่าว่าง*/
nv_logbok = "".
IF wdetail.prempa = "G" AND wdetail.renpol = "" THEN nv_logbok = "Y". ELSE nv_logbok = " ". /*Add A53-0362*/
IF wdetail.poltyp = "V70" THEN DO:
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
END.
IF nv_comper = 0 AND nv_comacc = 0 THEN nv_compprm = 0.

IF wdetail.pass <> "N" THEN
        ASSIGN wdetail.comment = "COMPLETE"
               WDETAIL.WARNING = ""
               wdetail.pass    = "Y".

IF wdetail.Prem_t <> "" THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
  /* ป้ายแดง */
  ASSIGN
  wdetail.netprem  = wdetail.Prem_t .

END.

RUN proc_calpremt .
RUN proc_adduwd132prem.
RUN proc_uwm100.         /*A60-0237*/

FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = INTE(wdetail.si).
 
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN  
        sic_bran.uwm301.mv41seat = wdetail.seat41
        sic_bran.uwm301.logbok   = nv_logbok /*A53-0111*/
/* Add by A63-0174 */
        sic_bran.uwm301.tons  = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN sic_bran.uwm301.tons * 1000 ELSE sic_bran.uwm301.tons .
IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.subclass,2,1) = "3"   OR  
   SUBSTR(wdetail.subclass,2,1) = "4"   OR  SUBSTR(wdetail.subclass,2,1) = "5"  OR  
   SUBSTR(wdetail.subclass,2,3) = "803" OR SUBSTR(wdetail.subclass,2,3) = "804" OR  
   SUBSTR(wdetail.subclass,2,3) = "805" ) THEN DO:
     MESSAGE wdetail.policy + " " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
    ASSIGN
        wdetail.comment = wdetail.comment + "| " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง "
        wdetail.pass    = "N"  .   
END. 
/* end A63-0174 */
RUN Proc_ClearData.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3-bk C-Win 
PROCEDURE proc_chktest3-bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by: A64-0138
fi_shown = "Please Wait Assign Parameter" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
RUN Proc_AssignClear.
ASSIGN 
    nv_tariff    = sic_bran.uwm301.tariff
    nv_class     = wdetail.subclass
    nv_comdat    = sic_bran.uwm100.comdat
    nv_engine    = DECI(wdetail.cc)
    nv_tons      = DECI(wdetail.weight)
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse
    nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc) 
    nv_seats     = INTE(wdetail.seat)
    nv_tons      = DECI(wdetail.weight)
    /*nv_dss_per   = IF rapolicy = 1 THEN 0 ELSE nv_dss_per*/     
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
    /*A60-0327*/
    nv_usecod3   = ""
    nv_usevar3   = ""
    nv_usevar4   = ""
    nv_usevar5   = ""
    nv_basecod3  = ""
    nv_baseprm3  = 0
    nv_basevar3  = ""
    nv_basevar4  = ""
    nv_basevar5  = ""
    nv_sicod3    = ""
    nv_sivar3    = ""
    nv_sivar4    = ""
    nv_sivar5    = ""
    /* end A60-0327*/
    nv_ncbyrs    = 0    
    nv_ncbper    = 0
    nv_ncb       = IF rapolicy = 1 THEN 0 ELSE nv_ncb
    nv_totsi     = 0 .
/*งานต่ออายุทุกเบอร์กรมธรรม์ให้ค่า Inspection เป็นค่าว่าง*/
nv_logbok = "".
IF wdetail.prempa = "G" AND wdetail.renpol = "" THEN nv_logbok = "Y". ELSE nv_logbok = " ". /*Add A53-0362*/
IF wdetail.poltyp = "V70" THEN
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
IF nv_comper = 0 AND nv_comacc = 0 THEN nv_compprm = 0.

/*--- nv_drivcod ----*/
nv_drivvar1 = wdetail.drivnam1.
nv_drivvar2 = wdetail.drivnam2.
IF wdetail.drivnam = "N" THEN DO:
    ASSIGN nv_drivvar  = " "
           nv_drivcod  = "A000"
           nv_drivvar1 = "     Unname Driver"
           nv_drivvar2 = "0"
           SUBSTR(nv_drivvar,1,30)   = nv_drivvar1
           SUBSTR(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
    IF nv_drivno > 2 THEN DO:
        MESSAGE " Driver'S NO. must not over 2. "  VIEW-AS ALERT-BOX.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
        /*NEXT. *//*a490166*/
    END.
    ASSIGN nv_drivvar   = " "
           nv_drivvar1  = "     Driver name person = "
           nv_drivvar2  = STRING(nv_drivno)
           SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
           SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.
    RUN proc_usdcod.
END.
/*-- Add A55-0235 ---*/
/*IF nv_bipp00 = 0 THEN nv_bipp00 = uwm130.uom1_v. */
/*IF nv_bipa00 = 0 THEN nv_bipa00 = uwm130.uom2_v. */
/*IF nv_bipd00 = 0 THEN nv_bipd00 = uwm130.uom5_v. */
IF nv_bipp00 = 0 THEN nv_bipp00 = if wdetail.uom1_V <> 0 then wdetail.uom1_V else  uwm130.uom1_v. /*A60-0383 */ 
IF nv_bipa00 = 0 THEN nv_bipa00 = if wdetail.uom2_V <> 0 then wdetail.uom2_V else  uwm130.uom2_v. /*A60-0383 */ 
IF nv_bipd00 = 0 THEN nv_bipd00 = if wdetail.uom5_V <> 0 then wdetail.uom5_V else  uwm130.uom5_v. /*A60-0383 */ 
/*-- End Add A55-0235 ---*/

IF wdetail.baseprem <> 0 THEN nv_baseprm = wdetail.baseprem.
ELSE RUN Proc_Chkbase.
IF NO_basemsg <> " " THEN wdetail.WARNING = NO_basemsg.
IF nv_baseprm = 0 THEN DO:
    ASSIGN wdetail.pass    = "N"
           wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
END.
ASSIGN nv_prem1    = nv_baseprm
       nv_basecod  = "BASE"
       nv_basevar1 = "     Base Premium = "
       nv_basevar2 = STRING(nv_baseprm)
       SUBSTRING(nv_basevar,1,30)   = nv_basevar1
       SUBSTRING(nv_basevar,31,30)  = nv_basevar2.

/*--- nv_add perils ---*/
ASSIGN nv_41 =  WDETAIL.no_41  
       nv_42 =  WDETAIL.no_42  
       nv_43 =  WDETAIL.no_43
       nv_seat41 = INTEGER(wdetail.seat41).
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                      nv_class,
                      nv_key_b,
                      nv_comdat).
ASSIGN  nv_41cod1   = "411"
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
nv_42var    = " ".      /* -------fi_42---------*/
ASSIGN nv_42cod   = "42"
       nv_42var1  = "     Medical Expense = "
       nv_42var2  = STRING(nv_42)
       SUBSTRING(nv_42var,1,30)   = nv_42var1
       SUBSTRING(nv_42var,31,30)  = nv_42var2.
nv_43var    = " ".      /*---------fi_43--------------*/
ASSIGN  nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                      nv_class,
                      nv_key_b,
                      nv_comdat).
/*---- nv_usecod ---*/
ASSIGN nv_usecod  = "USE" + TRIM(wdetail.vehuse)
       nv_usevar1 = "     Vehicle Use = "
       nv_usevar2 =  wdetail.vehuse
       SUBSTRING(nv_usevar,1,30)  = nv_usevar1
       SUBSTRING(nv_usevar,31,30) = nv_usevar2.
/*--- nv_engcod ---*/
/*ASSIGN nv_sclass = SUBSTRING(wdetail.subclass,2,3).*//*A53-0111*/
 
RUN wgs\wgsoeng.
/*----- nv_yrcod ------*/
ASSIGN  nv_caryr   = (YEAR(nv_comdat)) - INTEGER(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  STRING(wdetail.caryear)
        nv_yrcod   = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr)
                                       ELSE "YR99"
        SUBSTRING(nv_yrvar,1,30)    = nv_yrvar1
        SUBSTRING(nv_yrvar,31,30)   = nv_yrvar2.
/*----- nv_sicod ------*/
ASSIGN  nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  STRING(wdetail.si)
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = nv_sivar2
        nv_totsi     =  INTE(wdetail.si).
/*------ nv_grpcod -----*/
ASSIGN  nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        SUBSTRING(nv_grpvar,1,30)  = nv_grpvar1
        SUBSTRING(nv_grpvar,31,30) = nv_grpvar2.
/*------ nv_bipcod ------*/
ASSIGN  nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     = STRING(nv_bipp00)
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
/*------ nv_biacod -------*/
ASSIGN  nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     = STRING(nv_bipa00)
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
/*------- nv_pdacod --------*/
ASSIGN  nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     = STRING(nv_bipd00)
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*A60-0327*/
IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO:
    ASSIGN  nv_usecod3  = IF      (wdetail.covcod = "2.1") THEN "U" + TRIM(nv_vehuse) + "21" 
                          ELSE IF (wdetail.covcod = "2.2") THEN "U" + TRIM(nv_vehuse) + "22" 
                          ELSE IF (wdetail.covcod = "3.1") THEN "U" + TRIM(nv_vehuse) + "31"
                          ELSE "U" + TRIM(nv_vehuse) + "32" 
            nv_usevar4 = "     Vehicle Use = "
            nv_usevar5 =  wdetail.vehuse
            Substring(nv_usevar3,1,30)   = nv_usevar4
            Substring(nv_usevar3,31,30)  = nv_usevar5.
    /*-------------------base 3----------------------*/
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
        IF AVAIL xmm106 THEN DO:
            nv_baseprm3 = xmm106.min_ap.
        END.
        ELSE DO:
             nv_baseprm3 = 0.
             NO_basemsg = "Base Premium3 is Not in Range " .
        END.
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    ASSIGN 
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5. 
    /*---------------- SI 2+3+ ----------------------------*/
     ASSIGN
        nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                       ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
        nv_sivar4    = "     Own Damage = "                                        
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE  string(deci(wdetail.si)) 
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
END.
/* end A60-0327*/    
/*------- deduct --------*/
/*dod0 = INTEGER(wdetail.deductda).*//*A53-0111*/
DEF VAR dod0 AS INTEGER.
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER.

dod0 = INTEGER(nv_deductda).
IF dod0 > 3000 THEN DO:
   dod1 = 3000.
   dod2 = dod0 - dod1.
END.
ASSIGN nv_odcod = "DC01"
       nv_prem  = dod1.
RUN Wgs\Wgsmx024( nv_tariff,                    /*a490166 note modi*/
                  nv_odcod,
                  nv_class,
                  nv_key_b,
                  nv_comdat,
                  INPUT-OUTPUT nv_prem,
                  OUTPUT nv_chk ,
                  OUTPUT nv_baseap).
 
IF NOT nv_chk THEN DO:
    MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  VIEW-AS ALERT-BOX.
    ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
    /*NEXT.*/
END.
ASSIGN  nv_ded1prm        = nv_prem
        nv_dedod1_prm     = nv_prem
        nv_dedod1_cod     = "DOD"
        nv_dedod1var1     = "     Deduct OD = "
        nv_dedod1var2     = STRING(dod1)
        SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
        SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
ASSIGN  nv_dedod2var = " "
        nv_cons      = "AD"
        nv_ded       = dod2.
RUN  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                         nv_tariff,
                         nv_class,
                         nv_key_b,
                         nv_comdat,
                         nv_cons,
                         OUTPUT nv_prem).
ASSIGN  nv_aded1prm     = nv_prem
        nv_dedod2_cod   = "DOD2"
        nv_dedod2var1   = "     Add Ded.OD = "
        nv_dedod2var2   =  STRING(dod2)
        SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
        SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
        nv_dedod2_prm   = nv_prem.
/*------ pd -------*/
ASSIGN  nv_dedpdvar  = " "
        dpd0     = INTE(nv_deductpd) 
        nv_cons  = "PD"
        nv_ded   = dpd0.
RUN  Wgs\Wgsmx025(INPUT  nv_ded, /*a490166 note modi*/
                         nv_tariff,
                         nv_class,
                         nv_key_b,
                         nv_comdat,
                         nv_cons,
                         OUTPUT nv_prem).
nv_ded2prm  = nv_prem.
ASSIGN  nv_dedpd_cod   = "DPD"
        nv_dedpdvar1   = "     Deduct PD = "
        nv_dedpdvar2   =  STRING(nv_ded)
        SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
        SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
        nv_dedpd_prm  = nv_prem.

/*------- NCB ---------*/
DEF VAR nv_ncbyrs AS INTE.
/*nv_ncbper = INTE(wdetail.ncb).*/
nv_ncbper = nv_ncb.
nv_ncbvar = " " .
IF nv_ncbper <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff = nv_tariff   AND
               sicsyac.xmm104.class  = nv_class    AND
               sicsyac.xmm104.covcod = nv_covcod   AND
               sicsyac.xmm104.ncbper = INTE(nv_ncbper) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm104 THEN DO:
        /*Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.*/
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        /*NEXT.*//*a490166 Load all no Comment*/
    END.
    IF AVAIL sicsyac.xmm104 THEN
        ASSIGN  nv_ncbper  = xmm104.ncbper
                nv_ncbyrs  = xmm104.ncbyrs.
END.
ELSE DO:
    ASSIGN  nv_ncbyrs  = 0
            nv_ncbper  = 0
            nv_ncb     = 0.
END.
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           /*-- Comment A55-0235 --*/
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
                           /*--- End Add A55-0235 ---*/

nv_ncbvar   = " ".
IF nv_ncb <> 0 THEN
    ASSIGN  nv_ncbvar1   = "     NCB % = "
            nv_ncbvar2   =  STRING(nv_ncbper)
            SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
            SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
nv_ncb = 0.
nv_ncbper = 0.
nv_ncbyrs = 0.
/*------- fleet ---------*/
/*nv_flet_per = INTE(wdetail.fleet).*//*A53-0111*/
nv_flet_per = INTE(nv_fleet).
IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
    /*Message  " Fleet Percent must be 0 or 10. " View-as alert-box.*/
    ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    /*NEXT.  *//*a490166*/
END.
IF nv_flet_per = 0 THEN DO:
    ASSIGN nv_flet    = 0
           nv_fletvar = " ".
END.  
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           /*-- Comment A55-0235 --*/
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
                           /*--- End Add A55-0235 ---*/
ASSIGN  nv_fletvar     = " "
        nv_fletvar1    = "     Fleet % = "
        nv_fletvar2    =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.        

IF nv_flet  = 0 THEN nv_fletvar = " ".
/*-------- load claim ---------*/
/*nv_cl_per   = DECI(wdetail.loadclm).*//*A53-0111*/
nv_cl_per   = DECI(nv_loadclm).
nv_clmvar   = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN nv_clmvar1   = " Load Claim % = "
           nv_clmvar2   =  STRING(nv_cl_per)
           SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
           SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           /*nv_bipp00,
                           nv_bipa00,
                           nv_bipd00).*/
                           /*-- Comment A55-0235 --*/
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
                           /*--- End Add A55-0235 ---*/
nv_clmvar = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN  nv_clmvar1   = " Load Claim % = "
            nv_clmvar2   =  STRING(nv_cl_per)
            SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
            SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
/*--- Dsscp ---*/
RUN Proc_Dsspc.  


IF wdetail.pass <> "N" THEN
        ASSIGN wdetail.comment = "COMPLETE"
               WDETAIL.WARNING = ""
               wdetail.pass    = "Y".

RUN proc_uwm100. /*A60-0237*/

FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = INTE(wdetail.si).
 
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = wdetail.seat41
        sic_bran.uwm301.logbok   = nv_logbok /*A53-0111*/
/* Add by A63-0174 */
        sic_bran.uwm301.tons  = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN sic_bran.uwm301.tons * 1000 ELSE sic_bran.uwm301.tons .
IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.subclass,2,1) = "3"   OR  
   SUBSTR(wdetail.subclass,2,1) = "4"   OR  SUBSTR(wdetail.subclass,2,1) = "5"  OR  
   SUBSTR(wdetail.subclass,2,3) = "803" OR SUBSTR(wdetail.subclass,2,3) = "804" OR  
   SUBSTR(wdetail.subclass,2,3) = "805" ) THEN DO:
     MESSAGE wdetail.policy + " " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
    ASSIGN
        wdetail.comment = wdetail.comment + "| " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง "
        wdetail.pass    = "N"  .   
END. 
/* end A63-0174 */
/*A60-0327*/
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN      
    RUN WGS\WGSTP132(INPUT S_RECID3,   
                     INPUT S_RECID4). 
ELSE /*-end A60-0327*/
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).

RUN Proc_ClearData.
...END A64-0138..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 C-Win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Update Table UWM120" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
DEF VAR   n_sigr_r        LIKE sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r         LIKE sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r        LIKE sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm      LIKE sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t         LIKE sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t        LIKE sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t        LIKE sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy       LIKE sic_bran.uwm100.policy.
DEF VAR   nv_rencnt       LIKE sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt       LIKE sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per     LIKE sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per    LIKE sicsyac.xmm020.rvstam.
DEF VAR   nv_com2p        AS DECI INIT 0.00 .
DEF VAR   nv_com1p        AS DECI INIT 0.00 .
DEF VAR   nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR   NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR   nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR   nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR   nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR   nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR   nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR   nv_fi_com2_t    AS DECI INIT 0.00.

FIND sic_bran.uwm100  WHERE RECID(sic_bran.uwm100)  = s_recid1 NO-ERROR NO-WAIT.
  IF  NOT AVAIL sic_bran.uwm100  THEN DO:
      RETURN.
  END.
  ELSE  DO:
      ASSIGN 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND
                     sic_bran.uwm120.bchyr   = nv_batchyr             AND 
                     sic_bran.uwm120.bchno   = nv_batchno             AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND 
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND 
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND 
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND 
                              sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                              sic_bran.uwm130.bchno   = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r  = n_sigr_r + uwm130.uom6_v.
                         FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
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
  FIND LAST  sic_bran.uwm120  USE-INDEX uwm12001  WHERE          
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
            ASSIGN     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  ELSE DO:
          FIND sicsyac.xmm031  USE-INDEX xmm03101  WHERE  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR NO-WAIT.
          IF NOT AVAIL sicsyac.xmm031 THEN 
            ASSIGN     nv_com1p = 0
                       nv_com2p = 0.
          ELSE  
            ASSIGN     nv_com1p = sicsyac.xmm031.comm1
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
                 nv_com2p = sicsyac.xmm018.commsp.
      ELSE DO:
           FIND  sicsyac.xmm031  USE-INDEX xmm03101  WHERE  
                 sicsyac.xmm031.poltyp    = "V72" NO-LOCK NO-ERROR NO-WAIT.
                   nv_com2p = sicsyac.xmm031.comm1.  
      END.
  END. /* Wdetail.Compul = "Y"*/

  /*--------- tax -----------*/
  FIND sicsyac.xmm020 USE-INDEX xmm02001        WHERE
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   AND
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   NO-LOCK NO-ERROR.
  IF AVAIL sicsyac.xmm020 THEN DO:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       IF    sic_bran.uwm100.gstrat  <>  0  THEN  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       ELSE  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  END.

  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = YES THEN DO:                        /* STAMP */
     nv_fi_rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     THEN 1 ELSE 0).
  END.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
  IF  sic_bran.uwm120.taxae   = YES   THEN DO:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  END.

  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = YES THEN DO:                   /* MOTOR COMMISION */
     IF sic_bran.uwm120.com1p <> 0  THEN nv_com1p  = sic_bran.uwm120.com1p.
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  END.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = YES  THEN DO:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  THEN nv_com2p  = sic_bran.uwm120.com2p.
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
         /*nv_fi_com2ae        =  YES.*/
  END.
  IF sic_bran.uwm100.pstp <> 0 THEN DO:
     IF sic_bran.uwm100.no_sch  = 1 THEN NV_fi_dup_trip = "D".
     ELSE IF sic_bran.uwm100.no_sch  = 2 THEN  NV_fi_dup_trip = "T".
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
  IF wdetail.poltyp = "V72" THEN 
       ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  FIND sic_bran.uwm120 WHERE  RECID(sic_bran.uwm120) =  s_recid2.
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
        IF wdetail.poltyp = "V72" THEN 
           ASSIGN  
               sic_bran.uwm120.com2_r    = 0 
               sic_bran.uwm120.com1_r    = nv_fi_com2_t
               sic_bran.uwm120.com1p     = nv_com2p
               sic_bran.uwm120.com2p     = 0
               sic_bran.uwm120.rstp_r    = nv_fi_rstp_t 
               sic_bran.uwm120.rtax      = nv_fi_rtax_t.

        /*MESSAGE nt_compprm SKIP n_prem_t SKIP nv_com2p SKIP nv_com1p SKIP nv_fi_com2_t VIEW-AS ALERT-BOX.  */
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ClearData C-Win 
PROCEDURE Proc_ClearData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- nv_drivcod ----*/
ASSIGN nv_drivvar  = " "
       nv_drivcod  = " "
       nv_drivvar1 = " "
       nv_drivvar2 = " "
       SUBSTRING(nv_drivvar,1,30)   = " "
       SUBSTRING(nv_drivvar,31,30)  = " ".
/*---- nv_BasePrem ---*/
ASSIGN nv_prem1    = 0
       nv_basecod  = " "
       nv_basevar1 = " " 
       nv_basevar2 = " "
       SUBSTRING(nv_basevar,1,30)   = " "
       SUBSTRING(nv_basevar,31,30)  = " ".

/*---- nv_usecod ---*/
ASSIGN nv_usecod   = " "
       nv_usevar1  = " "
       nv_usevar2  = " "
       Substring(nv_usevar,1,30)    = " "
       Substring(nv_usevar,31,30)   = " ".
/*--- nv_engcod ---*/
ASSIGN nv_sclass   = " ".

/*----- nv_yrcod ------*/
ASSIGN nv_caryr    = 0
       nv_yrvar1   = " "
       nv_yrvar2   = " "
       nv_yrcod    = " "
       SUBSTRING(nv_yrvar,1,30)     = " "
       SUBSTRING(nv_yrvar,31,30)    = " ".
/*----- nv_sicod ------*/
ASSIGN nv_sicod    = " "
       nv_sivar1   = " "
       nv_sivar2   = " "
       nv_totsi    = 0
       SUBSTRING(nv_sivar,1,30)     = " "
       SUBSTRING(nv_sivar,31,30)    = " ".
/*------ nv_grpcod -----*/
ASSIGN nv_grpcod   = " "
       nv_grpvar1  = " "
       nv_grpvar2  = " "
       SUBSTRING(nv_grpvar,1,30)    = " "
       SUBSTRING(nv_grpvar,31,30)   = " ".
/*------ nv_bipcod ------*/
ASSIGN nv_bipcod   = " "
       nv_bipvar1  = " "
       nv_bipvar2  = " "
       SUBSTRING(nv_bipvar,1,30)    = " "
       SUBSTRING(nv_bipvar,31,30)   = " ".
/*------ nv_biacod -------*/
ASSIGN nv_biacod   = " "
       nv_biavar1  = " "
       nv_biavar2  = " "
       SUBSTRING(nv_biavar,1,30)    = " "
       SUBSTRING(nv_biavar,31,30)   = " ".
/*------- nv_pdacod --------*/
ASSIGN nv_pdacod   = " "
       nv_pdavar1  = " "
       nv_pdavar2  = " "
       SUBSTRING(nv_pdavar,1,30)    = " "
       SUBSTRING(nv_pdavar,31,30)   = " ".
/*--- nv_add perils ---*/
ASSIGN nv_41cod1   = " "
       nv_411var1  = " "
       nv_411var2  = " "
       SUBSTRING(nv_411var,1,30)    = " "
       SUBSTRING(nv_411var,31,30)   = " "
       nv_41cod2   = " "
       nv_412var1  = " "
       nv_412var2  = " "
       SUBSTRING(nv_412var,1,30)    = " "
       SUBSTRING(nv_412var,31,30)   = " "
       nv_411prm   = 0
       nv_412prm   = 0
       nv_42var    = " "       /* -------fi_42---------*/
       nv_42cod    = " "
       nv_42var1   = " "
       nv_42var2   = " "
       SUBSTRING(nv_42var,1,30)     = " "
       SUBSTRING(nv_42var,31,30)    = " "
       nv_43var    = " "      /*---------fi_43--------------*/
       nv_43prm    = 0
       nv_43cod    = " "
       nv_43var1   = " "
       nv_43var2   =  " "
       SUBSTRING(nv_43var,1,30)     = " "
       SUBSTRING(nv_43var,31,30)    = " ".
/*-- NCB ---*/
ASSIGN nv_ncbper = 0
       nv_ncbyrs = 0
       nv_ncb    = 0
       nv_ncb1   = 0
       /*nv_deductda = ""
       nv_deductpd = ""
       dod0 = 0
       dod1 = 0
       dod2 = 0
       dpd0 = 0*/.
ASSIGN nv_uom1_v = 0
       nv_uom2_v = 0
       nv_uom5_v = 0
       nv_uom7_v = 0 .
/*
/*--- Dsscp ---*/
ASSIGN 
       nv_dss_per = 0
       nv_dsspcvar1   = "  "
       nv_dsspcvar2   =  " "
       SUBSTRING(nv_dsspcvar,1,30)    = ""
       SUBSTRING(nv_dsspcvar,31,30)   = "".
/*--- DSTF ---*/
ASSIGN nv_stf_per = 0
       nv_stfvar1   = " "
       nv_stfvar2   = " "
       SUBSTRING(nv_stfvar,1,30)    = " "
       SUBSTRING(nv_stfvar,31,30)   = " ".
*/

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
/*A66-0160*/
DEF VAR np_colorcode AS CHAR INIT "".
np_colorcode = "".
IF wdetail.nCOLOR <> "" THEN DO:
    FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
        sym100.tabcod = "U118"  AND 
        sym100.itmcod = trim(wdetail.nCOLOR)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
    ELSE DO:
        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
            sym100.tabcod = "U118"  AND 
            sym100.itmdes = trim(wdetail.nCOLOR) 
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
        ELSE DO:
            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                sym100.tabcod = "U118"  AND 
                index(sym100.itmdes,trim(wdetail.nCOLOR)) <> 0  
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
            ELSE DO:
                FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
                    sym100.tabcod = "U119"  AND 
                    sym100.itmcod = trim(wdetail.nCOLOR)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                ELSE DO:
                    FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                        sym100.tabcod = "U119"  AND 
                        sym100.itmdes = trim(wdetail.nCOLOR)  
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    ELSE DO:
                        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                            sym100.tabcod = "U119"  AND 
                            index(sym100.itmdes,trim(wdetail.nCOLOR)) <> 0  
                            NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    END.
                END.
            END.
        END.
    END.
END.
wdetail.nCOLOR = np_colorcode.
/*A66-0160*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Comment C-Win 
PROCEDURE Proc_Comment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF wdetail.compul = "y" THEN DO:
    /*RUN Proc_72.*/
   /* wdetail.poltyp = "V72".
    wdetail.policy = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).*/
    ASSIGN
        nv_comper     = DECI(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = DECI(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper 
        sic_bran.uwm130.uom9_v   = nv_comacc  
        nv_vehuse = "0" . 

    RUN wgs\wgscomp. 

    IF  nv_comper  =  0  THEN DO:  
        nv_comacc =  0 . 
    END.
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
                MESSAGE nv_compvar1 nv_compvar2 nv_comper nv_comacc VIEW-AS ALERT-BOX.
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
END. /*compul y*/*/
/*ELSE DO:*/
/*--- Add A53-0111 ---*/
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
DEFINE BUFFER buwm100 FOR sic_bran.uwm100.
CREATE  sic_bran.uwm100. /*Create ฝั่ง gateway*/
ASSIGN
       sic_bran.uwm100.policy  =  wdetail.policy
       /*sic_bran.uwm100.cr_2 = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy))*/
       sic_bran.uwm100.rencnt  =  n_rencnt              
       sic_bran.uwm100.renno   =  ""
       sic_bran.uwm100.endcnt  =  n_endcnt
       sic_bran.uwm100.bchyr   = nv_batchyr 
       sic_bran.uwm100.bchno   = nv_batchno 
       sic_bran.uwm100.bchcnt  = nv_batcnt.
  /*--
IF wdetail.compul = "Y" THEN DO:
    MESSAGE "cr_2" VIEW-AS ALERT-BOX.
    ASSIGN sic_bran.uwm100.cr_2 = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
    MESSAGE sic_bran.uwm100.cr_2 VIEW-AS ALERT-BOX.
END.
--*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_CreateIns C-Win 
PROCEDURE Proc_CreateIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name     AS CHAR.
DEF VAR nv_transfer AS LOGICAL.
DEF VAR n_insref    AS CHARACTER FORMAT "X(10)".
DEF VAR putchr      AS CHAR      FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR      FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".

nv_insref  = "" . /* A64-0205 */

nv_name = wdetail.tiname + wdetail.insnam .

nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4).
nv_transfer = YES.

/*MESSAGE "proc_createins " SKIP
        "inscode "  nv_insref  wdetail.inscod skip
        "insname "  wdetail.insnam            skip
        "first   "  wdetail.firstname         skip
        "last    "  wdetail.lastname          skip
        "branch  "  wdetail.branch                VIEW-AS ALERT-BOX.*/

FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
     sicsyac.xmm600.NAME      = trim(wdetail.insnam)  /*OR
    sicsyac.xmm600.firstname  = TRIM(wdetail.firstname) AND     /*A64-0205*/
    sicsyac.xmm600.lastname   = TRIM(wdetail.lastname))*/ AND    /*A64-0205*/
    sicsyac.xmm600.homebr     = TRIM(wdetail.branch)  AND
    sicsyac.xmm600.clicod     = "IN"                  NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
  IF LOCKED sicsyac.xmm600 THEN DO:
    nv_transfer = NO.
    /*n_insref = sicsyac.xmm600.acno. */ /*A64-0205*/
    RETURN.
  END.
  ELSE DO:
    /*HIDE MESSAGE NO-PAUSE.
    MESSAGE "CREATE NEW RECORD Name & Address Master (XMM600)" nv_insref.*/

    n_check   = "".
    nv_insref = "".

    /*IF R-INDEX(nv_name,"จก.")             <> 0  OR              
       R-INDEX(nv_name,"จำกัด")           <> 0  OR  
       R-INDEX(nv_name,"(มหาชน)")         <> 0  OR  
       R-INDEX(nv_name,"INC.")            <> 0  OR 
       R-INDEX(nv_name,"CO.")             <> 0  OR 
       R-INDEX(nv_name,"LTD.")            <> 0  OR 
       R-INDEX(nv_name,"LIMITED")         <> 0  OR 
       INDEX(nv_name,"บริษัท")            <> 0  OR 
       INDEX(nv_name,"บ.")                <> 0  OR 
       INDEX(nv_name,"บจก.")              <> 0  OR 
       INDEX(nv_name,"หจก.")              <> 0  OR 
       INDEX(nv_name,"หสน.")              <> 0  OR 
       INDEX(nv_name,"บรรษัท")            <> 0  OR 
       INDEX(nv_name,"มูลนิธิ")           <> 0  OR 
       INDEX(nv_name,"ห้าง")              <> 0  OR 
       INDEX(nv_name,"ห้างหุ้นส่วน")      <> 0  OR 
       INDEX(nv_name,"ห้างหุ้นส่วนจำกัด") <> 0  OR
       INDEX(nv_name,"ห้างหุ้นส่วนจำก")   <> 0  OR  
       INDEX(nv_name,"และ/หรือ")          <> 0  THEN nv_typ = "Cs".*//*Comment A53-0362*/

    IF R-INDEX(nv_name,"จก.")             <> 0  OR              
       R-INDEX(nv_name,"จำกัด")           <> 0  OR  
       R-INDEX(nv_name,"(มหาชน)")         <> 0  OR  
       R-INDEX(nv_name,"INC.")            <> 0  OR 
       R-INDEX(nv_name,"CO.")             <> 0  OR 
       R-INDEX(nv_name,"LTD.")            <> 0  OR 
       R-INDEX(nv_name,"LIMITED")         <> 0  OR 
       INDEX(nv_name,"บริษัท")            <> 0  OR 
       INDEX(nv_name,"บ.")                <> 0  OR 
       INDEX(nv_name,"บจก.")              <> 0  OR 
       INDEX(nv_name,"หจก.")              <> 0  OR 
       INDEX(nv_name,"หสน.")              <> 0  OR 
       INDEX(nv_name,"บรรษัท")            <> 0  OR 
       INDEX(nv_name,"มูลนิธิ")           <> 0  OR 
       INDEX(nv_name,"ห้าง")              <> 0  OR 
       INDEX(nv_name,"ห้างหุ้นส่วน")      <> 0  OR 
       INDEX(nv_name,"ห้างหุ้นส่วนจำกัด") <> 0  OR
       INDEX(nv_name,"ห้างหุ้นส่วนจำก")   <> 0  THEN nv_typ = "Cs".
    ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/

    RUN Proc_Insno. 
              
    IF n_check <> "" THEN DO:
        ASSIGN
            putchr  = ""
            putchr1 = ""
            putchr1 = "Error Running Insured Code."
            putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                      " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                      "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                      " "             + TRIM(putchr1).
        /*--Suthida T. A55-0064--*/
        MESSAGE putchr1 SKIP putchr
        VIEW-AS ALERT-BOX.
        /*-- Suthida T. A55-0064 --*/
        nv_message  = putchr1.
        nv_transfer = NO.
        nv_insref   = "".
        RETURN.
    END.

    loop_runningins: /*Check Insured*/
    REPEAT:
      FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
           sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL sicsyac.xmm600 THEN DO:
          RUN Proc_Insno. 
          IF  n_check <> ""  THEN DO:   
              ASSIGN
                  putchr  = ""
                  putchr1 = ""
                  putchr1 = "Error Running Insured Code."
                  putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                            " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                            "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                            " "             + TRIM(putchr1).
              /*--Suthida T. A55-0064--*/
              MESSAGE putchr1 SKIP putchr
              VIEW-AS ALERT-BOX.
              /*-- Suthida T. A55-0064 --*/
              nv_message  = putchr1.
              nv_transfer = NO.
              nv_insref   = "".
              RETURN.
          END.
      END.  
      ELSE LEAVE loop_runningins.
    END.
    
    CREATE sicsyac.xmm600.
  END.
  n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        nv_insref = sicsyac.xmm600.acno.
        n_insref  = nv_insref.
        nv_transfer = NO. /*-- Add chutikarn A50-0072 --*/
        /*RETURN.*/
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = trim(wdetail.tiname) 
            sicsyac.xmm600.fname    = ""             
            sicsyac.xmm600.name     = trim(wdetail.insnam)
            sicsyac.xmm600.abname   = trim(wdetail.insnam)
            sicsyac.xmm600.icno     = TRIM(wdetail.icno)        
            sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       
            sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       
            sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       
            sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = "" 
            sicsyac.xmm600.dval20   = "" .
    END.
END.

IF nv_transfer = YES THEN DO:
  ASSIGN
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
    sicsyac.xmm600.ntitle   = wdetail.tiname      /*sic_bran.uwm100.ntitle */   /*Title for Name Mr/Mrs/etc*/
    sicsyac.xmm600.fname    = ""                        /*First Name*/
    /*sicsyac.xmm600.name     = sic_bran.uwm100.name1*/ /*Name Line 1*/          /*A60-0545*/
    /*sicsyac.xmm600.abname   = sic_bran.uwm100.name1*/ /*Abbreviated Name*/     /*A60-0545*/
    sicsyac.xmm600.name     = trim(wdetail.insnam)      /*Name Line 1*/          /*A60-0545*/     
    sicsyac.xmm600.abname   = trim(wdetail.insnam)      /*Abbreviated Name*/     /*A60-0545*/  
    sicsyac.xmm600.icno     = wdetail.icno              /*sic_bran.uwm100.anam2  */   /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
    sicsyac.xmm600.addr1    = wdetail.iadd1             /*sic_bran.uwm100.addr1*//*Address line 1*/
    sicsyac.xmm600.addr2    = wdetail.iadd2             /*sic_bran.uwm100.addr2*//*Address line 2*/
    sicsyac.xmm600.addr3    = wdetail.iadd3             /*sic_bran.uwm100.addr3*//*Address line 3*/
    sicsyac.xmm600.addr4    = wdetail.iadd4             /*sic_bran.uwm100.addr4*//*Address line 4*/
    /*sicsyac.xmm600.postcd   = ""                        /*Postal Code*/*/
    sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
    sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
    sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
    sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
    sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
    sicsyac.xmm600.homebr   = wdetail.branch    /*sic_bran.uwm100.branch */   /*Home branch*/
    sicsyac.xmm600.opened   = TODAY             /*sic_bran.uwm100.trndat */   /*Date A/C opened*/
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
    sicsyac.xmm600.usrid    = nv_usrid                  /*Userid*/
    sicsyac.xmm600.regagt   = ""                        /*Registered agent code*/
    sicsyac.xmm600.agtreg   = ""                        /*Agents Registration/Licence No*/
    sicsyac.xmm600.debtyn   = YES                       /*Permit debtor trans Y/N*/
    sicsyac.xmm600.crcon    = NO                        /*Credit Control Report*/
    sicsyac.xmm600.muldeb   = NO                        /*Multiple Debtors Acc.*/
    sicsyac.xmm600.styp20   = ""                        /*Statistic Type Codes (4 x 20)*/
    sicsyac.xmm600.sval20   = ""                        /*Statistic Value Codes (4 x 20)*/
    sicsyac.xmm600.dtyp20   = ""                        /*Type of Date Codes (2 X 20)*/
    sicsyac.xmm600.dval20   = ""                        /*Date Values (8 X 20)*/
    sicsyac.xmm600.iblack   = ""                        /*Insured Black List Code*/
    sicsyac.xmm600.oldic    = ""                        /*Old IC No.*/
    sicsyac.xmm600.cardno   = ""                        /*Credit Card Account No.*/
    sicsyac.xmm600.cshcrd   = ""                        /*Cash(C)/Credit(R) Agent*/
    sicsyac.xmm600.naddr1   = ""                        /*New address line 1*/
    sicsyac.xmm600.gstreg   = ""                        /*GST Registration No.*/
    sicsyac.xmm600.naddr2   = ""                        /*New address line 2*/
    sicsyac.xmm600.fax      = ""                        /*Fax No.*/
    sicsyac.xmm600.naddr3   = ""                        /*New address line 3*/
    sicsyac.xmm600.telex    = ""                        /*Telex No.*/
    sicsyac.xmm600.naddr4   = ""                        /*New address line 4*/
    sicsyac.xmm600.name2    = ""                        /*Name Line 2*/
    sicsyac.xmm600.npostcd  = ""                        /*New postal code*/
    sicsyac.xmm600.name3    = ""                        /*Name Line 3*/
    sicsyac.xmm600.nphone   = ""                        /*New phone no.*/    
    sicsyac.xmm600.nachg    = YES                       /*Change N&A on Renewal/Endt*/
    sicsyac.xmm600.regdate  = ?                         /*Agents registration Date*/
    sicsyac.xmm600.alevel   = 0                         /*Agency Level*/
    sicsyac.xmm600.taxno    = ""                        /*Agent tax no.*/
    sicsyac.xmm600.anlyc1   = ""                        /*Analysis Code 1*/
    sicsyac.xmm600.taxdate  = ?                         /*Agent tax date*/
    sicsyac.xmm600.anlyc5   =  "" .                     /*Analysis Code 5*/
END.

/*nv_insref = sicsyac.xmm600.acno.*/ /*A64-0205*/
nv_transfer = YES.

FIND sicsyac.xtm600 WHERE
     sicsyac.xtm600.acno  = nv_insref
NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
  IF LOCKED sicsyac.xtm600 THEN DO:
    nv_transfer = NO.
    RETURN.
  END.
  ELSE DO:
    /*HIDE MESSAGE NO-PAUSE.
    MESSAGE "CREATE NEW RECORD Name & Address THAI (XTM600)" nv_insref.*/
    CREATE sicsyac.xtm600.
  END.
END.

IF nv_transfer = YES THEN DO:
  ASSIGN
    sicsyac.xtm600.acno    = nv_insref                  /*Account no.*/
    /*sicsyac.xtm600.name    = sic_bran.uwm100.name1*/  /*Name of Insured Line 1*/  /*A60-0545*/
    /*sicsyac.xtm600.abname  = sic_bran.uwm100.name1*/  /*Abbreviated Name*/        /*A60-0545*/
    sicsyac.xtm600.name    = trim(wdetail.insnam)       /*Name of Insured Line 1*/  /*A60-0545*/
    sicsyac.xtm600.abname  = trim(wdetail.insnam)       /*Abbreviated Name*/        /*A60-0545*/
    sicsyac.xtm600.addr1   = wdetail.iadd1  /*sic_bran.uwm100.addr1*/      /*address line 1*/
    sicsyac.xtm600.addr2   = wdetail.iadd2  /*sic_bran.uwm100.addr2*/      /*address line 2*/
    sicsyac.xtm600.addr3   = wdetail.iadd3  /*sic_bran.uwm100.addr3*/      /*address line 3*/
    sicsyac.xtm600.addr4   = wdetail.iadd4  /*sic_bran.uwm100.addr4*/      /*address line 4*/
    sicsyac.xtm600.name2   = ""                         /*Name of Insured Line 2*/
    sicsyac.xtm600.ntitle  = wdetail.tiname  /*sic_bran.uwm100.ntitle  */   /*Title*/
    sicsyac.xtm600.name3   = ""                         /*Name of Insured Line 3*/
    sicsyac.xtm600.fname   = "" .                       /*First Name*/
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_CreateIns2 C-Win 
PROCEDURE Proc_CreateIns2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  nv_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN DO:
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/   .  
    IF wdetail.insnamtyp = "CO" OR sicsyac.xmm600.ntitle = "คุณ" THEN sicsyac.xmm600.sex = "O".
    ELSE IF INDEX(sicsyac.xmm600.ntitle,"นาย") <> 0 THEN sicsyac.xmm600.sex = "M".
    ELSE IF INDEX(sicsyac.xmm600.ntitle,"นาง") <> 0 THEN sicsyac.xmm600.sex = "F".
    ELSE sicsyac.xmm600.sex = "O".

END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_cr_2 C-Win 
PROCEDURE Proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR len AS INTE.
DEF BUFFER buwm100 FOR wdetail.
    len = LENGTH(wdetail.policy).
    /*FOR EACH buwm100 WHERE substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND*//*Comment A54-0076*/
    FOR EACH buwm100 WHERE SUBSTR(buwm100.policy,3,len) = SUBSTR(wdetail.policy,3,len) AND
             buwm100.policy <> wdetail.policy  NO-LOCK.
        ASSIGN 
            wdetail.cr_2 = buwm100.policy.
            /*wdetail.si   = buwm100.si.*/
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_detaitem C-Win 
PROCEDURE Proc_detaitem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*- แก้ไขเลข Sticker ไม่เข้า Table : Detaitem เพิ่มการ Check batch -*/
/*--create detaitem--*/
FIND FIRST brStat.Detaitem /*USE-INDEX detaitem11*/ WHERE
    brStat.Detaitem.serailno   = wdetail.stk AND
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Dsspc C-Win 
PROCEDURE Proc_Dsspc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A64-0138...
IF rapolicy = 1 THEN DO:
    /*---- Add A55-0235 กรณีรถใหม่ และไม่ใช่รถ User Car มีการ Set Discount Special % ไว้ให้ใช้ตามนั้น ----*/
    IF SUBSTRING(wdetail.cedpol,6,1) <> "U" AND nv_dss_per <> 0 THEN DO:
        ASSIGN
            nv_dsspcvar1   = "     Discount Special % = "
            nv_dsspcvar2   =  STRING(nv_dss_per)
            SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
            SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    END.
    /*--- END ADD A55-0235 ---*/
    ELSE DO:
        ASSIGN
           f  = 0
           aa = nv_baseprm
           chk = NO
           NO_basemsg = " "
           f = DECI(wdetail.prem_t)
           i = 1
           nv_baseprm  = aa
           per         = 0
           nv_dss_per  = IF rapolicy = 1 THEN 0 ELSE nv_dss_per
           nv_gapprm   = 0
           nv_gapprm1  = 0.
        
        RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                   nv_class,
                                   nv_covcod,
                                   nv_key_b,
                                   nv_comdat,
                                   nv_totsi,
                                   nv_uom1_v ,       
                                   nv_uom2_v ,       
                                   nv_uom5_v ).
        
        IF nv_gapprm <> DECI(wdetail.prem_t) THEN  nv_dss_per = TRUNCATE(((nv_gapprm - DECI(wdetail.prem_t) ) * 100 ) / nv_gapprm ,2). 
        
        IF (nv_gapprm - DECI(wdetail.prem_t)) <> nv_dsspc THEN nv_dsspc = - TRUNCATE((nv_gapprm - DECI(wdetail.prem_t)),0).  
            nv_totdis  =   nv_totded + nv_flet + nv_ncb + nv_dsspc + nv_stf_amt. 
            nv_gapprm  =   ROUND((nv_prem1 + nv_addprm + nv_totdis + nv_lodclm),0)
                               + nv_compprm + nv_camprem.  
            nv_pdprm   =   ROUND((nv_gapprm * nv_polday) / 365,0).
        IF  nv_dss_per   <> 0  THEN
            ASSIGN
                nv_dsspcvar1   = "     Discount Special % = "
                nv_dsspcvar2   =  STRING(nv_dss_per)
                SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
                SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    END.
END.
ELSE DO:
    /*nv_dss_per = nv_dspc.
    IF  nv_dss_per   <> 0  THEN
        ASSIGN
            nv_dsspcvar1   = "     Discount Special % = "
            nv_dsspcvar2   =  STRING(nv_dss_per)
            SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
            SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.*/
    /*------------------ dsspc ---------------*/
     IF nv_gapprm <> f THEN  DO:
         per = TRUNCATE((nv_gapprm - f ),1).
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2).  
         nv_dsspcvar   = " ".
         ASSIGN                
             nv_dss_per = nv_dspc /*per*/ .     
         IF  nv_dss_per   <> 0  THEN
             ASSIGN
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
         /*--------------------------*/
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,      
                         nv_uom2_v ,       
                         nv_uom5_v ). 
         IF nv_gapprm <> DECI(wdetail.prem_t)  THEN  DO:
             IF (nv_gapprm - DECI(wdetail.prem_t)) < 3 THEN DO:
                 ASSIGN
                     nv_dss_per = nv_dss_per + 0.01.    
                 /*--------------------------*/
                 RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                     nv_class,
                                     nv_covcod,
                                     nv_key_b,
                                     nv_comdat,
                                     nv_totsi,
                                     nv_uom1_v ,       
                                     nv_uom2_v ,       
                                     nv_uom5_v ). 
                 IF nv_gapprm = DECI(wdetail.prem_t) THEN i = 10.
             END.
             nv_baseprm = nv_baseprm + 1.
             i = i + 1.
             END. 
             ELSE  i = 10.
END.
.... end A64-0138 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_GENDATA C-Win 
PROCEDURE PROC_GENDATA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail.
    DELETE wdetail.
    fi_shown = "Please Wait Delete Workfile".
    DISP fi_shown WITH FRAME fr_main.
END.
INPUT FROM VALUE(fi_FileName) NO-ECHO.
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"                                               
      /*1*/   wdetail.Poltyp                       /*Type of Policy    */                                                                
      /*2*/   wdetail.Policy                       /*เลขที่กรมธรรม์    */              
      /*3*/   wdetail.CedPol                       /*เลขที่สัญญา       */               
      /*4*/   wdetail.Renpol                       /*เลขกรมธรรม์ต่ออายุ*/                        
      /*5*/   wdetail.Compul                       /*Compulsory        */                   
      /*6*/   wdetail.Comdat                       /*วันที่เริ่มคุ้มครอง */                   
      /*7*/   wdetail.Expdat                       /*วันที่สิ้นสุดความคุ้มครอง   */                    
      /*8*/   wdetail.Tiname                       /*คำนำหน้าชื่อ    */                   
      /*9*/   wdetail.Insnam                       /*ชื่อผู้เอาประกัน*/                    
      /*10*/  wdetail.name2                        /*และ/หรือ        */ 
      /*11*/  wdetail.iadd1                        /*ที่อยู่ 1       */                
      /*12*/  wdetail.iadd2                        /*ที่อยู่ 2       */                
      /*13*/  wdetail.iadd3                        /*ที่อยู่ 3       */                
      /*14*/  wdetail.iadd4                        /*ที่อยู่ 4       */                   
      /*15*/  wdetail.Prempa                       /*Pack            */                 
      /*16*/  wdetail.subclass                     /*Class           */                     
      /*17*/  wdetail.Brand                        /*Brand           */                     
      /*18*/  wdetail.Model                        /*Model           */                       
      /*19*/  wdetail.CC                           /*CC              */                    
      /*20*/  wdetail.Weight                       /*Weight          */  
      /*21*/  wdetail.cargrp             /*A59-0070*/         /*vehgrp          */  
      /*22*/  wdetail.Seat                         /*Seat            */                     
      /*23*/  wdetail.Body                         /*Body            */                    
      /*24*/  wdetail.Vehreg                       /*ทะเบียนรถ       */                     
      /*25*/  wdetail.carprovi                     /*จังหวัด         */                    
      /*26*/  wdetail.Engno                        /*เลขเครื่องยนต์  */                   
      /*27*/  wdetail.chasno                       /*เลขตัวถัง       */                 
      /*28*/  wdetail.caryear                      /*ปีที่ผลิต       */                   
      /*29*/  wdetail.Vehuse                       /*ประเภทการใช้    */                    
      /*30*/  wdetail.garage                       /*ซ่อมอู่ห้าง/ธรรมดา*/                       
      /*31*/  wdetail.stk                          /*เลขที่สติกเกอร์   */                    
      /*32*/  wdetail.covcod                       /*ประเภทความคุ้มครอง*/                        
      /*33*/  wdetail.si                           /*ทุนประกันภัย      */  
      /*34*/  wdetail.Prem_t               /*wdetail.volPrem*/ /*เบี้ยประกันสุท    */  
      /*35*/  wdetail.Comppre              /*wdetail.Prem_t*/ /*เบี้ย พรบ. รวม    */  
      /*36*/  wdetail.volPrem                      /*เบี้ยรวม + พรบ.   */  
      /*37*/  wdetail.Benname                      /*ผู้รับผลประโยชน์  */                  
      /*38*/  wdetail.drivnam                      /*ระบุผู้ขับขี่     */                  
      /*39*/  wdetail.drivnam1                     /*ชื่อผู้ขับขี่ 1   */                  
      /*40*/  wdetail.drivbir1                     /*วัน/เดือน/ปีเกิด1 */
      /*41*/  wdetail.drivic1                      /*เลขบัตร ปปช. */    /*A60-0545*/
      /*42*/  wdetail.drivlic1                     /*เลขที่ใบขัขขี่ */  /*A60-0545*/
      /*43*/  wdetail.drivage1                     /*อายุ 1            */                  
      /*44*/  wdetail.drivnam2                     /*ชื่อผู้ขับขี่ 2   */                  
      /*45*/  wdetail.drivbir2                     /*วัน/เดือน/ปีเกิด2 */ 
      /*46*/  wdetail.drivic2                      /*เลขบัตร ปปช. */    /*A60-0545*/
      /*47*/  wdetail.drivlic2                     /*เลขที่ใบขัขขี่ */  /*A60-0545*/
      /*48*/  wdetail.drivage2                     /*อายุ 2       */                    
      /*49*/  wdetail.Redbook                      /*Redbook      */                    
      /*50*/  wdetail.opnpol                       /*ผู้แจ้ง      */                    
      /*51*/  wdetail.bandet                       /*สาขาตลาด     */                     
      /*52*/  wdetail.tltdat                       /*วันที่รับแจ้ง*/                     
      /*53*/  wdetail.attrate                      /*ATTERN RATE  */  
      /*54*/  wdetail.branch                       /*Branch       */  
      /*55*/  wdetail.typreq      /*Vat Code     */  
      /*56*/  wdetail.Text1       /*Text1        */  
      /*57*/  wdetail.Text2       /*Text2        */  
      /*58*/  wdetail.icno        /*ICNO         */  
      /*59*/  wdetail.finit       /*Finit Code   */  
      /*60*/  wdetail.Rebate      /*Code Rebate  */  
      /*61*/  wdetail.agent       /*a60-0383*/       /*Agent        */  
      /*62*/  wdetail.producer    /*a60-0383*/       /*Producer     */  
      /*63*/  wdetail.camp        /*a60-0383*/       /*Campaign     */ 
      /*64*/  wdetail.name3       /*A60-0545*/
      /*65*/  wdetail.ispno       /*A61-0512 */                 /* เลขตรวจสภาพ */
      /*66*/  wdetail.paidtyp     /*A61-0512 */                 /* ประเภทการจ่าย */
      /*67*/  wdetail.paiddat     /*A61-0512 */                 /* วันที่จ่าย */
      /*68*/  wdetail.confdat     /*A61-0512 */                 /* วันที่ส่งไฟล์คอนเฟิร์ม*/
              wdetail.occup       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
              wdetail.nCOLOR        /*A66-0160*/
              wdetail.ACCESSORYtxt. /*A66-0160*/
      /* A63-0174 */
      IF index(wdetail.Poltyp,"Type") <> 0  THEN NEXT.
      ELSE IF TRIM(wdetail.poltyp) = ""  THEN NEXT.
      ELSE DO:
      /* end A63-0174 */
        ASSIGN  
            wdetail.entdat   = STRING(TODAY)           
            wdetail.enttim   = STRING(TIME,"HH:MM:SS") 
            wdetail.trandat  = STRING(fi_loaddat)      
            wdetail.trantim  = STRING(TIME,"HH:MM:SS") 
            /*--- Comment A55-0235 ---
            wdetail.producer   = fi_producer
            wdetail.agent      = fi_agent
            --- End Comment A55-0235 ----*/
            wdetail.inscod   = " "
            wdetail.branch   = TRIM(wdetail.branch). /* ---suthida t. A55-0064 TRIM เพื่อไม่เก็บค่าว่างเข้าระบบ--*/
        
        /*---- Add Check Agent/Producer Code A55-0235 ----*/
        IF rapolicy = 1 THEN DO:
            /*comment by Kridtiya i. A63-00472
            FIND FIRST stat.Insure WHERE stat.Insure.CompNo = "NF" AND
                                         stat.Insure.Insno  = wdetail.Rebate NO-LOCK NO-ERROR.
            IF AVAIL stat.Insure THEN DO:
                ASSIGN
                    wdetail.Producer = stat.Insure.Fname
                    wdetail.Agent    = stat.Insure.Lname.
            END.
            ELSE DO:
                ASSIGN
                    wdetail.Producer = fi_Producer
                    wdetail.agent    = fi_agent.
            END.    comment by Kridtiya i. A63-00472 */
            /*ASSIGN wdetail.agent    = "B3MLTMB200".   /*Add by Kridtiya i. A63-00472  ป้ายแดง*/*/ /*A64-0205*/
            IF wdetail.producer = ""  THEN ASSIGN wdetail.Producer = trim(fi_Producer) .   /*A64-0205*/
            IF wdetail.agent    = ""  THEN ASSIGN wdetail.agent    = trim(fi_agent).       /*A64-0205*/
            /*A64-0138*/
            IF wdetail.producer = "B3MLTTB201"  THEN DO: 
                IF    wdetail.camp  = "" THEN wdetail.campaign_ov  = "REDPLATE". 
                ELSE  wdetail.campaign_ov  = trim(wdetail.camp). 
                ASSIGN wdetail.financecd   = "FTB"  . 
            END.
            /*A64-0138*/
        END.
        ELSE DO: /*Add A54-0112 Renew*/
           /* ASSIGN wdetail.Producer = fi_Producer */ /*a60-0383*/
           /*        wdetail.agent    = fi_agent.   */ /*a60-0383*/  
           /*ASSIGN wdetail.agent    =  "B3MLTMB100" .   /*Add by Kridtiya i. A63-00472  ต่ออายุ*/*/ /*A64-0205*/
           IF wdetail.producer = ""  THEN ASSIGN wdetail.Producer = fi_Producer .   /*A60-0383*/
           IF wdetail.agent    = ""  THEN ASSIGN wdetail.agent    = fi_agent.       /*A60-0383*/
            /*A64-0138*/
           IF wdetail.producer = "B3MLTTB101" OR wdetail.producer = "B3MLTTB102" OR wdetail.producer = "B3MLTTB105"THEN DO:
               IF wdetail.Renpol = "" THEN wdetail.campaign_ov = "TRANSF".
               ELSE wdetail.campaign_ov = "RENEW".
               ASSIGN wdetail.financecd   = "FNB"  . 
           END.
            /*A64-0138*/ 
        END.
        /*--- End Add A55-0235 ----*/
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        IF      wdetail.Producer = "A0M0039"    THEN ASSIGN wdetail.Producer = "B3MLTTB201"  /*"B3MLTMB201"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "B3MLTMB201" THEN ASSIGN wdetail.Producer = "B3MLTTB201"  /*"B3MLTMB201"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "A0M0049"    THEN ASSIGN wdetail.Producer = "B3MLTTB101"  /*"B3MLTMB101"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "B3MLTMB101" THEN ASSIGN wdetail.Producer = "B3MLTTB101"  /*"B3MLTMB101"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "A0M0014"    THEN ASSIGN wdetail.Producer = "B3MLTTB102"  /*"B3MLTMB102"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "B3MLTMB102" THEN ASSIGN wdetail.Producer = "B3MLTTB102"  /*"B3MLTMB102"  A64-0278 */ . 
        ELSE IF wdetail.Producer = "B3MLTMB105" THEN ASSIGN wdetail.Producer = "B3MLTTB105"  /* A64-0278 */ . 
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        IF wdetail.Agent = "B3MLTMB100" THEN ASSIGN wdetail.Agent = "B3MLTTB100" .   /*"A64-0278 */ 
        IF wdetail.Agent = "B3MLTMB200" THEN ASSIGN wdetail.Agent = "B3MLTTB200" .  /*"A64-0278 */ 
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        
        /*---- Check Package ----*/
        /*IF wdetail.prempa = " " THEN DO:*//*Comment A54-0076*/
        
        IF rapolicy = 1 AND wdetail.prempa = "" THEN DO:  /*A54-0076*/
            IF fi_package = " " THEN DO:
                /* comment by A60-0545....
                IF SUBSTRING(wdetail.cedpol,6,1) = "U" THEN wdetail.prempa = "G".
                ELSE IF wdetail.brand = "TOYOTA" THEN wdetail.prempa = "X".
                ELSE IF wdetail.brand = "ISUZU" THEN wdetail.prempa = "V".
                ELSE wdetail.prempa = "Z".
                ..end A60-0545....*/
                /* create by A60-0545*/
                 IF SUBSTRING(wdetail.CedPol,6,1) = "U" THEN DO:
                     ASSIGN wdetail.Prempa = "G"
                            wdetail.garage = "".
                 END.
                 ELSE IF wdetail.Brand = "FORD" THEN wdetail.Prempa = "F".
                 ELSE wdetail.Prempa = "Z".
                 /* end A60-0545*/
            END.
            ELSE DO: 
                wdetail.prempa = fi_package.
            END.
        END.
        
        IF DATE(wdetail.comdat) >= 04/01/2020 THEN ASSIGN wdetail.Prempa = "T" . /*A63-0174*/
        
        /*--- Comment A54-0076 เปลี่ยนไป Check ในโปรแกรมแปลงไฟล์ ---
        /*--- Add A53-0362 ---*/
        /*IF rapolicy = 2 THEN DO:*//*Comment A54-0076*/
        IF rapolicy = 2 AND wdetail.renpol = "" THEN DO: /*A54-0076*/
            IF wdetail.covcod = "3" THEN 
                                        ASSIGN
                                            wdetail.prempa  = "R"
                                            wdetail.benname = "".
                                    ELSE wdetail.prempa = "G". 
            /*nv_i = nv_i + 1.
            wdetail.policy     = wdetail.poltyp + STRING(nv_i,"99") + TRIM(SUBSTRING(wdetail.Text1,7,8)).-- Comment A54-0076 --*/
        END.
        /*--- End Add A53-0362 ---*/
        ---- End Comment A54-0076 --*/
        /*--- Check Seat ---*/
        IF wdetail.seat = "" OR wdetail.seat = "0" THEN DO:
            IF wdetail.subclass = "110" THEN wdetail.seat = "7".
            ELSE IF wdetail.subclass = "220" THEN wdetail.seat = "15".
            ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
            ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
        END.
        
        IF wdetail.bandet = "กทม. รัชดา"           THEN wdetail.opnpol = "3" + wdetail.opnpol.
        ELSE IF wdetail.bandet = "กทม. บางนา"      THEN wdetail.opnpol = "4" + wdetail.opnpol.
        ELSE IF wdetail.bandet = "กทม. งามวงศ์วาน" THEN wdetail.opnpol = "5" + wdetail.opnpol.
        ELSE IF wdetail.bandet = "กทม. ธนบุรี"     THEN wdetail.opnpol = "6" + wdetail.opnpol.
        /*--- End Add A55-0235 ---*/
    END. /* wdetail */

    fi_shown = "Please Wait Gen Data Thanachat" + " " + wdetail.policy.
    DISP fi_shown WITH FRAME fr_main.

END.                                                                            
INPUT CLOSE.  /*close Import*/  
/*-- nv_i = 0. --- Comment A54-0076 --*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Insno C-Win 
PROCEDURE Proc_Insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_lastno   AS INT. 
DEF VAR nv_seqno    AS INT.
DEF VAR n_search    AS LOGICAL.  

n_search = YES.

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
          sicsyac.xzm056.seqtyp  =  nv_typ      AND
          sicsyac.xzm056.branch  =  wdetail.branch  NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
  IF n_search = YES THEN DO:
      CREATE xzm056.
      ASSIGN
           sicsyac.xzm056.seqtyp   =  nv_typ
           sicsyac.xzm056.branch   =  wdetail.branch 
           sicsyac.xzm056.des      =  "Personal/Start"
           sicsyac.xzm056.lastno   =  1.                   
  END.
  ELSE DO:
      ASSIGN
          nv_insref  =    wdetail.branch + STRING(1,"999999").
          nv_lastno  =    1.
      RETURN.
  END.
END. /*not avail xzm056*/       

/*---- Begin 21/11/2006 Chutikarn ----*/
ASSIGN
   nv_lastno = sicsyac.xzm056.lastno
   nv_seqno  = sicsyac.xzm056.seqno. 

IF n_check = "YES" THEN DO:       
    IF nv_typ = "0s" THEN DO: 
       /*nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").*//*comment A54-0076*/
       /*-- Add A54-0076 --*/
       IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:
          /* nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999"). ---- suthida T. A55-0064 ----*/
          /*--- Comment A56-0171 --- 
          /* ------------- suthida T. A55-0064 --------------- */
          IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref  = "0" + wdetail.branch  +  STRING(sicsyac.xzm056.lastno,"99999999"). 
          ELSE  nv_insref  =       wdetail.branch  +  STRING(sicsyac.xzm056.lastno,"999999"). 
          /* ------------- suthida T. A55-0064 --------------- */
          --- END Comment A56-0171 ---*/
           /*---- Add A56-0171 ----*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                    nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO: 
                IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                    nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =      wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
            END.
            /*---- END Add A56-0171 ----*/
       END.
           
       ELSE  nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
       /*-- End Add A54-0076 --*/
       CREATE sicsyac.xzm056.
       ASSIGN
          sicsyac.xzm056.seqtyp    =  nv_typ
          sicsyac.xzm056.branch    =  wdetail.branch 
          sicsyac.xzm056.des       =  "Personal/Start"
          sicsyac.xzm056.lastno    =  nv_lastno + 1
          sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
       /*nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno + 1 ,"99999").*//*Comment A54-0076*/
       /*-- Add A54-0076 --*/
       IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:
          /* nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno + 1 ,"99999"). --- Suthida T. ---*/
           /*--- Comment A56-0171 ---
           /* ------------- suthida T. A55-0064 --------------- */
           IF sicsyac.xzm056.lastno > 99999  THEN
                 nv_insref  = "0" + wdetail.branch  + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
           ELSE  nv_insref  =       wdetail.branch  + "C" + String(sicsyac.xzm056.lastno,"99999").
           /* ------------- suthida T. A55-0064 --------------- */
           --- End Comment A56-0171 ---*/
           /*--- Add A56-0171 ---*/
           IF sicsyac.xzm056.lastno > 99999 THEN DO:
               IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                   nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
           END.
           ELSE DO:
               IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                   nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE nv_insref =      wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
           END.
           /*--- END Add A56-0171 ---*/
       END.
       ELSE nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno + 1 ,"9999999").
       /*-- End Add A54-0076 --*/
       CREATE sicsyac.xzm056.
       ASSIGN
          sicsyac.xzm056.seqtyp    =  nv_typ
          sicsyac.xzm056.branch    =  wdetail.branch 
          sicsyac.xzm056.des       =  "Company/Start"
          sicsyac.xzm056.lastno    =  nv_lastno + 1
          sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    /*--- Comment A54-0076 ---
    IF      nv_typ = "0s" THEN nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
    ELSE IF nv_typ = "Cs" THEN nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
    --- End Comment A54-0076 ---*/
    /*-- Add A54-0076 --*/
    IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:


        /*  -------------------------------- Suthida t. A55-0064 --------------------------------------------
        IF      nv_typ = "0s" THEN nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
        ELSE IF nv_typ = "Cs" THEN nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
        -------------------------------- Suthida t. A55-0064 -------------------------------------------- */

        /*  -------------------------------- Suthida t. A55-0064 -------------------------------------------- */
              IF   nv_typ = "0s" THEN DO:
                   /*--- Comment A56-0171 ----
                   IF    xzm056.lastno > 99999  THEN
                          nv_insref = "0" + wdetail.branch  +  STRING(sicsyac.xzm056.lastno,"99999999").
                   ELSE   nv_insref =       wdetail.branch  +  STRING(sicsyac.xzm056.lastno,"999999").
                   --- End Comment A56-0171 ---*/
                  /*---- Add A56-0171 ----*/
                  IF sicsyac.xzm056.lastno > 99999 THEN DO:
                      IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                          nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                      END.
                      ELSE nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                  END.
                  ELSE DO: 
                      IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                          nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                      END.
                      ELSE nv_insref =      wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
                  END.
                  /*---- END Add A56-0171 ----*/
              END. 
              ELSE IF nv_typ = "Cs" THEN DO:

                  /*--- Comment A56-0171 --- 
                  IF    xzm056.lastno > 99999  THEN
                         nv_insref = "0" + wdetail.branch  + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                  ELSE   nv_insref =       wdetail.branch  + "C" + STRING(sicsyac.xzm056.lastno,"99999").
                  ---- End Comment A56-0171 ---*/
                  /*--- Add A56-0171 ---*/
                   IF sicsyac.xzm056.lastno > 99999 THEN DO:
                       IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                           nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                       END.
                       ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                   END.
                   ELSE DO:
                       IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                           nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                       END.
                       ELSE nv_insref =      wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
                   END.
                   /*--- END Add A56-0171 ---*/
              END.
        /*   -------------------------------- Suthida t. A55-0064 -------------------------------------------- */
    END.
    ELSE DO:
        IF      nv_typ = "0s" THEN nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE IF nv_typ = "Cs" THEN nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
    END.
    /*-- End Add A54-0076 --*/
END.
/*---- End 21/11/2006 Chutikarn ----*/

IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno THEN DO :
  MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
           "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
           "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. 
  n_check = "ERROR".
  RETURN.                
END. /*lastno > seqno*/                       
ELSE DO :   /*lastno <= seqno */
   IF nv_typ = "0s" THEN DO:
       /*----- 21/11/2006 -----
       ASSIGN
           n_acno     =    nv_branch   + String(sicsyac.xzm056.lastno,"999999")
           nv_lastno  =    sicsyac.xzm056.lastno
           nv_seqno   =    sicsyac.xzm056.seqno. 
       ------*/
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  wdetail.branch 
                 sicsyac.xzm056.des       =  "Personal/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno.   
       END.
   END.
   ELSE IF nv_typ = "Cs" THEN DO:
       /*--- 21/11/2006 -----
       ASSIGN
           n_acno     =    nv_branch  + "C" + String(sicsyac.xzm056.lastno,"99999")
           nv_lastno  =    sicsyac.xzm056.lastno
           nv_seqno   =    sicsyac.xzm056.seqno. 
       -----*/
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  wdetail.branch 
                 sicsyac.xzm056.des       =  "Company/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno. 
       END.
   END.  

END.   /*lastno <= seqno */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_mailtxt C-Win 
PROCEDURE Proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Driver Name" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
 IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/

     DEF VAR no_policy AS CHAR FORMAT "x(20)" .
     DEF VAR no_rencnt AS CHAR FORMAT "99".
     DEF VAR no_endcnt AS CHAR FORMAT "999".
     
     DEF VAR no_riskno AS CHAR FORMAT "999".
     DEF VAR no_itemno AS CHAR FORMAT "999".
    
      no_policy = sic_bran.uwm301.policy .
      no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
      no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .
      nv_drivno = 0.
    
      no_riskno = "001".
      no_itemno = "001".

      /* comment by Kridtiya i. A66-0160
      brithday 01/01/2566 ----- 
      nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir1,7,4))  .
      nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir2,7,4))  .

      IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: /*note add & modified*/
         nv_drivbir1      = STRING(INT(SUBSTR(wdetail.drivbir1,7,4)) + 543).
         wdetail.drivbir1   = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1.
      END.

      IF wdetail.drivbir2 <>  " " AND wdetail.drivnam2 <> " " THEN DO: /*note add & modified */
         nv_drivbir2      = STRING(INT(SUBSTR(wdetail.drivbir2,7,4)) + 543).
         wdetail.drivbir2  = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2.
      END.----------*/
      nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.drivbir1,7,4))  - 543 )  . /*A66-0160*/  
      nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.drivbir2,7,4))  - 543 )  . /*A66-0160*/

      FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
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
                  IF wdetail.drivnam1 <> " " THEN DO:
                      CREATE brstat.mailtxt_fil.
                      ASSIGN                                           
                             brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                             brstat.mailtxt_fil.lnumber   = nv_lnumber.
                             /*-- Comment by Narin A54-0396
                             brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                             --*/
                             /*--    Add by Narin A54-0396--*/
                             brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)). 
                             /*--End Add by Narin A54-0396--*/
                             brstat.mailtxt_fil.ltext2    = wdetail.drivbir1 + "  " 
                                                          + STRING(nv_drivage1).
                             nv_drivno                    = 1.
                             ASSIGN /*a490166*/
                             brstat.mailtxt_fil.bchyr = nv_batchyr 
                             brstat.mailtxt_fil.bchno = nv_batchno 
                             brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                             /*SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . */ /*A60-0545*/
                             SUBSTRING(brstat.mailtxt_fil.ltext2,16,40) = "-"                        /*A60-0545*/
                             SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.drivic1)     /*A60-0545*/
                             SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivlic1).   /*A60-0545*/

                  END. /*drivnam1 <> "" */
               
                  IF wdetail.drivnam2 <> "" THEN DO:
                        CREATE brstat.mailtxt_fil. 
                        ASSIGN
                            brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                            brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                            /*-- Comment by Narin A54-0396
                            brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                            --*/
                            /*--    Add by Narin A54-0396--*/
                            brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)). 
                            /*--End Add by Narin A54-0396--*/
                            brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
                                                        + STRING(nv_drivage2). 
                            nv_drivno                   = 2.
                            ASSIGN /*a490166*/
                            brstat.mailtxt_fil.bchyr = nv_batchyr 
                            brstat.mailtxt_fil.bchno = nv_batchno 
                            brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                            /*SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . */ /*A60-0545*/
                            SUBSTRING(brstat.mailtxt_fil.ltext2,16,40) = "-"                        /*A60-0545*/
                            SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.drivic2)     /*A60-0545*/
                            SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivlic2).   /*A60-0545*/
                  END.  /*drivnam2 <> " " */ 
            END. /*End Avail Brstat*/
            ELSE DO:
                IF wdetail.drivnam1 <> " " THEN DO:
                  CREATE  brstat.mailtxt_fil.
                  ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + STRING(sic_bran.uwm100.rencnt) + STRING(sic_bran.uwm100.endcnt) + STRING(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                          brstat.mailtxt_fil.lnumber    = nv_lnumber.
                          /*-- Comment by Narin A54-0396
                          brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                          --*/
                          /*--    Add by Narin A54-0396--*/
                          brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)). 
                          /*--End Add by Narin A54-0396--*/
                          brstat.mailtxt_fil.ltext2     = wdetail.drivbir1 + "  "
                                                        +  TRIM(STRING(nv_drivage1)).
                          ASSIGN 
                          SUBSTRING(brstat.mailtxt_fil.ltext2,16,40) = "-"                        /*A60-0545*/
                          SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.drivic1)     /*A60-0545*/
                          SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivlic1).   /*A60-0545*/
                END. /*drivnam1 <> "" */
                IF wdetail.drivnam2 <> "" THEN DO:
                    CREATE  brstat.mailtxt_fil.
                        ASSIGN
                        brstat.mailtxt_fil.policy   = wdetail.policy + STRING(uwm100.rencnt) + STRING(uwm100.endcnt) + STRING(uwm301.riskno)  + STRING(uwm301.itemno)
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        /*-- Comment by Narin A54-0396
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                        --*/
                        /*--    Add by Narin A54-0396--*/
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)). 
                        /*--End Add by Narin A54-0396--*/
                        brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
                                                    + TRIM(STRING(nv_drivage2)).
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        /*SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/ */ /*A60-0545*/
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,40) = "-"                        /*A60-0545*/
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.drivic2)     /*A60-0545*/
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivlic2).   /*A60-0545*/
                END. /*drivnam2 <> " " */
            END. /*Else DO*/ 
 END. /*note add for mailtxt 07/11/2005*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_maktab C-Win 
PROCEDURE Proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Check Redbook" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
ASSIGN
    nv_simat  = 0
    nv_simat1 = 0
    nv_simat  = DECI(wdetail.si) * 50 / 100 
    nv_simat1 = DECI(wdetail.si) + nv_simat .
FIND FIRST stat.maktab_fil USE-INDEX      maktab04          WHERE
    stat.maktab_fil.makdes   =     nv_makdes                AND                  
    INDEX(stat.maktab_fil.moddes,SUBSTRING(nv_moddes,1,INDEX(nv_moddes," "))) <> 0  AND
    stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
    stat.maktab_fil.engine   =     INTEGER(wdetail.cc)      AND
    stat.maktab_fil.sclass   =     "****"                   AND
    (stat.maktab_fil.si      >=     nv_simat                OR
    stat.maktab_fil.si       <=     nv_simat1 )             AND  
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    NO-LOCK NO-ERROR NO-WAIT.

    IF  AVAIL stat.maktab_fil  THEN DO:
        ASSIGN
            wdetail.redbook     =  stat.maktab_fil.modcod 
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body.
    END.
    /*A60-0383*/
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX      maktab04      WHERE
        stat.maktab_fil.makdes   =     nv_makdes                AND                  
        INDEX(stat.maktab_fil.moddes,(nv_moddes)) <> 0          AND
        stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
        stat.maktab_fil.sclass   =     substr(wdetail.subclass,2,3)   NO-LOCK NO-ERROR NO-WAIT.
       
        IF  AVAIL stat.maktab_fil  THEN DO:
            ASSIGN
                wdetail.redbook     =  stat.maktab_fil.modcod 
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body.
        END.
    /* end A60-0383*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NCB C-Win 
PROCEDURE Proc_NCB :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0138...
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
/*------- NCB ---------*/
DEF VAR nv_ncbyrs AS INTE.
/*nv_ncbper = INTE(wdetail.ncb).*//*A53-0111*/
nv_ncbper = nv_ncb.
nv_ncbvar = " " .
 
IF nv_ncbper <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff = nv_tariff   AND
               sicsyac.xmm104.class  = nv_class    AND
               sicsyac.xmm104.covcod = nv_covcod   AND
               sicsyac.xmm104.ncbper = INTE(nv_ncb) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm104 THEN DO:
        /*Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.*/
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        /*NEXT.*//*a490166 Load all no Comment*/
    END.
    IF AVAIL sicsyac.xmm104 THEN
        ASSIGN  nv_ncbper  = xmm104.ncbper
                nv_ncbyrs  = xmm104.ncbyrs.
END.
ELSE DO:
    ASSIGN  nv_ncbyrs  = 0
            nv_ncbper  = 0
            nv_ncb     = 0.
END.
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
nv_ncbvar   = " ".
IF nv_ncb <> 0 THEN
    ASSIGN  nv_ncbvar1   = "     NCB % = "
            nv_ncbvar2   =  STRING(nv_ncbper)
            SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
            SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.        

/*------- fleet ---------*/
/*nv_flet_per = INTE(wdetail.fleet).*//*A53-0111*/
nv_flet_per = INTE(nv_fleet).
IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
    /*Message  " Fleet Percent must be 0 or 10. " View-as alert-box.*/
    ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    /*NEXT.  *//*a490166*/
END.
IF nv_flet_per = 0 THEN DO:
    ASSIGN nv_flet    = 0
           nv_fletvar = " ".
END.  
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
ASSIGN  nv_fletvar     = " "
        nv_fletvar1    = "     Fleet % = "
        nv_fletvar2    =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.        

IF nv_flet  = 0 THEN nv_fletvar = " ".
/*-------- load claim ---------*/
/*nv_cl_per   = DECI(wdetail.loadclm).*//*A53-0111*/
nv_cl_per   = DECI(nv_loadclm).
nv_clmvar   = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN nv_clmvar1   = " Load Claim % = "
           nv_clmvar2   =  STRING(nv_cl_per)
           SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
           SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.

RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
nv_clmvar = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN  nv_clmvar1   = " Load Claim % = "
            nv_clmvar2   =  STRING(nv_cl_per)
            SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
            SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.          

/*---
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           nv_totsi,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).
nv_ncbvar   = " ".
IF nv_ncb <> 0 THEN
    ASSIGN  nv_ncbvar1   = "     NCB % = "
            nv_ncbvar2   =  STRING(nv_ncbper)
            SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
            SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
ASSIGN  nv_fletvar     = " "
        nv_fletvar1    = "     Fleet % = "
        nv_fletvar2    =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
nv_clmvar = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN  nv_clmvar1   = " Load Claim % = "
            nv_clmvar2   =  STRING(nv_cl_per)
            SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
            SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
----*/     
...end A64-0138...*/       
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

OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   

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
fi_shown = "Please Wait Assign Data To Sic_bran" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
DEFINE VAR chk_sticker AS CHAR FORMAT "X(15)".

IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk <> "" THEN DO:
        /*-- Check เลข Sticker No. --*/
        IF SUBSTRING(wdetail.stk,1,1) = "2" THEN ASSIGN 
            Chr_sticker = "0" + wdetail.stk
            wdetail.stk = "0" + wdetail.stk.
        ELSE ASSIGN 
            CHR_sticker = wdetail.stk
            wdetail.stk = wdetail.stk.
        chk_sticker = Chr_sticker.
        RUN wuz\wuzchmod.

        IF chk_sticker <> CHR_sticker THEN
            ASSIGN
               wdetail.pass    = "N"
               wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
   
        nv_newsck = "".
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
                   stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAILABLE stat.detaitem THEN
            ASSIGN
               wdetail.pass    = "N"
               wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
               wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".

        /*-- Check กรมธรรม์ซ้ำ --*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR 
               sicuw.uwm100.comdat <> ? OR
               sicuw.uwm100.releas = YES THEN DO:
                ASSIGN
                   wdetail.pass    = "N"
                   wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                   wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        ELSE RUN proc_create100.

    END. /* wdetail.stk <> " " */
    ELSE DO:
        /*-- Check กรมธรรม์ซ้ำ --*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> ""  OR
               sicuw.uwm100.comdat <> ?  OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END. /* wdetail.stk = " " */
END. /* wdetail.policy <> " " */
ELSE DO:
    nv_tmppol = SUBSTRING(wdetail.poltyp,2,2) + wdetail.cedpol. 
    wdetail.policy  = nv_tmppol.
    IF wdetail.stk <> "" THEN DO:
        /*-- Check Sticker No. --*/
        IF SUBSTRING(wdetail.stk,1,1) = "2" THEN ASSIGN 
            chr_sticker = "0" + wdetail.stk
            wdetail.stk = "0" + wdetail.stk.
        ELSE ASSIGN
            chr_sticker = wdetail.stk
            wdetail.stk = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.

        IF chk_sticker <> chr_sticker THEN
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        
        nv_newsck = "".
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
                   stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN
            ASSIGN                               
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".

        /*-- Check กรมธรรม์ซ้ำ --*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAILABLE sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR
               sicuw.uwm100.comdat <> ? OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END. /*wdetail.stk <> ""*/
    ELSE DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> ""  OR
               sicuw.uwm100.comdat <> ?  OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END. /*wdetail.stk = ""*/
END. /* wdetail.policy = " " */

s_recid1 = RECID(sic_bran.uwm100).

/*A60-0383*/
IF LENGTH(wdetail.icno) < 13  THEN DO:
    ASSIGN wdetail.pass    = "Y"
           wdetail.warning = "เลขบัตรประชาชนไม่ครบ 13 หลัก".
END.
/* end A60-0383*/

/*FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = SUBSTRING(wdetail.policy,3,2) NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.  Comment A53-0362 */
/*-- Add A53-0362 ---*/
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.
/*-- End Add A53-0362 --*/

IF wdetail.poltyp = "V70" AND wdetail.docno <> "" THEN ASSIGN nv_docno  = wdetail.docno
                                                              nv_accdat = TODAY.
                                                  ELSE DO:
                                                      IF wdetail.docno  = "" THEN nv_docno  = "".
                                                      IF wdetail.accdat = "" THEN nv_accdat = TODAY.
                                                  END.
IF rapolicy = 2 THEN wdetail.accdat = wdetail.comdat. 
                ELSE wdetail.accdat = STRING(TODAY).
/*--- Comment A53-0362 ---
IF wdetail.compul = "Y" THEN DO:
    IF wdetail.poltyp = "V70" THEN DO:
        wdetail.cr_2 = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
    END.
    ELSE IF wdetail.poltyp = "72" THEN DO:
        wdetail.cr_2 = "70" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
    END.
END.
--- End Comment A53-0362 ---*/
/*--- Comment A54-0076 --
/*--- Add A53-0362 ---*/
IF wdetail.compul = "Y" THEN DO:
    IF wdetail.poltyp = "V70" THEN DO:
        wdetail.cr_2 = "72" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
    END.
    ELSE IF wdetail.poltyp = "V72" THEN DO:
        wdetail.cr_2 = "70" + SUBSTRING(wdetail.policy,3,LENGTH(wdetail.policy)).
    END.
END.
/*--- End Add A53-0362 ---*/
--- End Comment A54-0076 ---*/
IF wdetail.inscod = "" THEN DO:
    RUN Proc_CreateIns .
    RUN Proc_CreateIns2 .
END.
ELSE ASSIGN nv_insref = wdetail.inscod.   /*A64-00138*/ 
IF wdetail.renpol = "" THEN n_firstdat = DATE(wdetail.comdat).

DO TRANSACTION :
    ASSIGN
        sic_bran.uwm100.renno   = ""
        sic_bran.uwm100.endno   = ""
        sic_bran.uwm100.poltyp  = wdetail.poltyp
        sic_bran.uwm100.insref  = nv_insref
        sic_bran.uwm100.opnpol  = SUBSTRING(wdetail.opnpol,1,INDEX(wdetail.opnpol,"(") - 1) 
        /*sic_bran.uwm100.anam2   = ""*//*Comment A55-0235*/
        sic_bran.uwm100.anam2   = wdetail.icno
        sic_bran.uwm100.ntitle  = wdetail.tiname
        /*sic_bran.uwm100.name1   = wdetail.insnam */ /*A60-0545*/
        sic_bran.uwm100.name1   = IF trim(wdetail.name3) <> "" THEN trim(wdetail.insnam) + " (" + TRIM(wdetail.name3) + ")"  ELSE TRIM(wdetail.insnam) /*A60-0545*/
        /*sic_bran.uwm100.name2   = wdetail.name2 */ /*A60-0383*/
        sic_bran.uwm100.name2   = IF rapolicy = 1 THEN trim(wdetail.name2) ELSE ""  /*A60-0383*/
        sic_bran.uwm100.name3   = ""
        sic_bran.uwm100.addr1   = wdetail.iadd1               
        sic_bran.uwm100.addr2   = wdetail.iadd2           
        sic_bran.uwm100.addr3   = wdetail.iadd3          
        sic_bran.uwm100.addr4   = wdetail.iadd4
        sic_bran.uwm100.postcd  = "" 
        sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")   /*   nv_undyr  */
        sic_bran.uwm100.branch  = wdetail.branch                /* nv_branch  */                        
        sic_bran.uwm100.dept    = nv_dept
        sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
        sic_bran.uwm100.fstdat  = n_firstdat /*TODAY */
        sic_bran.uwm100.comdat  = DATE(wdetail.comdat)
        sic_bran.uwm100.expdat  = DATE(wdetail.expdat)
        sic_bran.uwm100.accdat  = TODAY /*nv_accdat */                   
        sic_bran.uwm100.tranty  = "N"  /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug  = "T"
        sic_bran.uwm100.acctim  = "00:00"
        sic_bran.uwm100.trty11  = "M"      
        sic_bran.uwm100.docno1  =  " " /*STRING(nv_docno,"9999999")*/     
        sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
        sic_bran.uwm100.entdat  = TODAY
        sic_bran.uwm100.curbil  = "BHT"
        sic_bran.uwm100.curate  = 1
        sic_bran.uwm100.instot  = 1
        sic_bran.uwm100.prog    = "wgwtagen"
        sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
        sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short   = NO
        /*---- Comment A55-0235 ---
        sic_bran.uwm100.acno1   = fi_producer /*  nv_acno1 */
        sic_bran.uwm100.agent   = fi_agent    /*nv_agent   */
        --- End Add A55-0235 ---*/
        sic_bran.uwm100.acno1   = wdetail.producer
        sic_bran.uwm100.agent   = wdetail.agent
        sic_bran.uwm100.insddr  = NO
        sic_bran.uwm100.coins   = NO
        sic_bran.uwm100.billco  = ""
        sic_bran.uwm100.fptr01  = 0        sic_bran.uwm100.bptr01 = 0
        sic_bran.uwm100.fptr02  = 0        sic_bran.uwm100.bptr02 = 0
        sic_bran.uwm100.fptr03  = 0        sic_bran.uwm100.bptr03 = 0
        sic_bran.uwm100.fptr04  = 0        sic_bran.uwm100.bptr04 = 0
        sic_bran.uwm100.fptr05  = 0        sic_bran.uwm100.bptr05 = 0
        sic_bran.uwm100.fptr06  = 0        sic_bran.uwm100.bptr06 = 0  
        sic_bran.uwm100.styp20  = "NORM"
        sic_bran.uwm100.dir_ri  = YES
        sic_bran.uwm100.drn_p   = NO
        sic_bran.uwm100.sch_p   = NO
        sic_bran.uwm100.cr_2    = wdetail.cr_2
        /*sic_bran.uwm100.cr_1   = TRIM(wdetail.camp)  /*A60-0383*/ */ /*A60-0545*/
        sic_bran.uwm100.cr_1   = IF wdetail.poltyp = "V70" THEN TRIM(wdetail.camp) ELSE "" /*A60-0545*/
        sic_bran.uwm100.bchyr   = nv_batchyr         /*Batch Year */  
        sic_bran.uwm100.bchno   = nv_batchno         /*Batch No.  */  
        sic_bran.uwm100.bchcnt  = nv_batcnt          /*Batch Count*/  
        sic_bran.uwm100.prvpol  = wdetail.renpol     /*A52-0172*/
        sic_bran.uwm100.cedpol  = wdetail.cedpol 
        /*sic_bran.uwm100.finint  = wdetail.finit  */ /*A60-0383*/    /*A53-0111 Dealer Code*/
        /*sic_bran.uwm100.bs_cd   = wdetail.typreq */ /*A60-0383*/    /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/
        /*sic_bran.uwm100.finint  = if rapolicy = 1 then trim(wdetail.finit)  else ""  /*A60-0383*/*/ /*A64-0205*/
        sic_bran.uwm100.finint  = if rapolicy = 1 then trim(wdetail.finit)  
                                 else IF wdetail.producer = "B3MLTTB101" THEN trim(wdetail.finit) ELSE ""  /*A64-0278*/
                                  /*else IF wdetail.producer = "B3MLTMB101" THEN trim(wdetail.finit) ELSE ""  A64-0278 *//*A64-0205*/
        sic_bran.uwm100.bs_cd   = if rapolicy = 1 then trim(wdetail.typreq) else ""  /*A60-0383*/
        sic_bran.uwm100.accdat  = DATE(wdetail.accdat) 
        /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/   /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)*/  /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   =  trim(wdetail.producer)         /*A66-0160*/
        sic_bran.uwm100.dealer     = trim(wdetail.financecd).    /*Add by Kridtiya i. A63-0472*/ 

    IF wdetail.renpol <> "" THEN DO:
        IF wdetail.poltyp = "V72" THEN 
            ASSIGN sic_bran.uwm100.prvpol  = ""
                   sic_bran.uwm100.tranty  = "R".
        ELSE
            ASSIGN sic_bran.uwm100.prvpol  = wdetail.renpol
                   sic_bran.uwm100.tranty  = "R". 
    END.

    IF wdetail.pass = "Y" THEN  sic_bran.uwm100.impflg = YES.
                          ELSE  sic_bran.uwm100.impflg = NO.

    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN
       sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.

    IF wdetail.cancel = "CA" THEN sic_bran.uwm100.polsta = "CA".
                             ELSE sic_bran.uwm100.polsta = "IF".

    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
                       ELSE sic_bran.uwm100.trndat = TODAY.

    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    /*---- Comment Porn A54-0076 -----
    nv_polday = IF (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365) OR
                   (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366) OR
                   (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367) THEN 365
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
    ---- End Comment A54-0076 ----*/
    /*---- Add A54-0076 ----*/
    IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
         MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
        (DAY(sic_bran.uwm100.comdat)      =  29                             AND
         MONTH(sic_bran.uwm100.comdat)    =  02                             AND
         DAY(sic_bran.uwm100.expdat)      =  01                             AND
         MONTH(sic_bran.uwm100.expdat)    =  03                             AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
    THEN nv_polday = 365.
    ELSE nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  ??? */
    /*---- End A54-0076 ----*/

    IF sic_bran.uwm100.poltyp = "V70" THEN DO:
        IF wdetail.renpol = "" THEN RUN proc_uwd100. /*Text F7*/
        RUN proc_uwd102. /*Memo Text F8*/
    END.
/*
    RUN Proc_CreateIns .
    RUN Proc_CreateIns2 .

    ASSIGN 
        sic_bran.uwm100.insref = nv_insref.*/

END. /* DO TRANSECTION*/

/*-------------- U W M 1 2 0 ----------------*/
FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE
     sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
     sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
     sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
     sic_bran.uwm120.riskgp = s_riskgp               AND
     sic_bran.uwm120.riskno = s_riskno               AND
     sic_bran.uwm120.bchyr  = nv_batchyr             AND
     sic_bran.uwm120.bchno  = nv_batchno             AND
     sic_bran.uwm120.bchcnt = nv_batcnt              NO-ERROR NO-WAIT.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).

    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.
END.

IF AVAILABLE sic_bran.uwm120 THEN DO: 
      ASSIGN
      sic_bran.uwm120.sicurr  = "BHT"
      sic_bran.uwm120.siexch  = 1  /*not sure*/
      sic_bran.uwm120.fptr01  = 0               
      sic_bran.uwm120.fptr02  = 0               
      sic_bran.uwm120.fptr03  = 0               
      sic_bran.uwm120.fptr04  = 0               
      sic_bran.uwm120.fptr08  = 0               
      sic_bran.uwm120.fptr09  = 0          
      sic_bran.uwm120.com1ae  = YES
      sic_bran.uwm120.stmpae  = YES
      sic_bran.uwm120.feeae   = YES
      sic_bran.uwm120.taxae   = YES
      sic_bran.uwm120.bptr01  = 0 
      sic_bran.uwm120.bptr02  = 0 
      sic_bran.uwm120.bptr03  = 0 
      sic_bran.uwm120.bptr04  = 0 
      sic_bran.uwm120.bptr08  = 0 
      sic_bran.uwm120.bptr09  = 0 
      sic_bran.uwm120.bchyr   = nv_batchyr         /* batch Year */
      sic_bran.uwm120.bchno   = nv_batchno         /* bchno    */
      sic_bran.uwm120.bchcnt  = nv_batcnt .      /* bchcnt     */

      ASSIGN 
          sic_bran.uwm120.class = wdetail.subclass
          s_recid2              = RECID(sic_bran.uwm120).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReCreate C-Win 
PROCEDURE Proc_ReCreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF    VAR nv_title     AS CHAR FORMAT "x(15)" .  /*A61-0514*/
DEFINE VAR nv_prempa    AS CHAR FORMAT "X(1)".
DEFINE VAR nv_branchold AS CHAR INIT "". 
DEF    VAR nv_dealer    AS CHAR FORMAT "x(10)" INIT "".        /*A64-0205*/
DEF    VAR nv_insure    AS CHAR FORMAT "x(15)" INIT "" .       /*A64-0205*/
DEFINE VAR nre_premt    AS DECI FORMAT ">>>,>>>,>>9.99".  /*A64-0138*/
DEF    VAR nv_insnam    AS CHAR FORMAT "x(100)" INIT "" .      /*A64-0278*/
DEFINE VAR nv_drivnam   AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0160*/  
DEFINE VAR nv_drivnam1  AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0160*/  
DEFINE VAR nv_drivbir1  AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0160*/  
DEFINE VAR nv_drivnam2  AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0160*/  
DEFINE VAR nv_drivbir2  AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0160*/ 

/*DEFINE VAR nv_covcod AS CHAR FORMAT "X(1)".*/

fi_shown = "Please Wait Check Data Form Expiry" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.

RUN Proc_assignClear.

IF NOT CONNECTED("sic_exp") THEN RUN proc_sicexp.

IF CONNECTED("sic_exp") THEN DO:
    nv_prempa = wdetail.prempa.
    nv_covcod = wdetail.covcod.
    nv_engno  = wdetail.engno.  /*A54-0317*/
    /* A60-0327*/
    ASSIGN nv_addr1   = ""
           nv_addr2   = ""
           nv_addr3   = ""
           nv_addr4   = ""
           nv_vehgr   = ""
           nv_uom1_V  = 0
           nv_uom2_V  = 0
           nv_uom5_V  = 0
           nv_dealer  = ""
           nv_insure  = ""
           nre_premt  = 0
           nv_drivnam  = ""  /*A66-0160*/ 
           nv_drivnam1 = ""  /*A66-0160*/ 
           nv_drivbir1 = ""  /*A66-0160*/ 
           nv_drivnam2 = ""  /*A66-0160*/ 
           nv_drivbir2 = ""  /*A66-0160*/ 
        .
    /* end A60-0327*/
    /*--- Comment A53-0362 ---
    RUN wgw\wgwtbex1 (INPUT-OUTPUT wdetail.renpol   ,  
                      INPUT-OUTPUT wdetail.prempa   ,   
                      INPUT-OUTPUT wdetail.subclass , 
                      INPUT-OUTPUT wdetail.model    ,    
                      INPUT-OUTPUT wdetail.redbook  ,  
                      INPUT-OUTPUT wdetail.cargrp   ,   
                      INPUT-OUTPUT wdetail.chasno   ,   
                      INPUT-OUTPUT wdetail.engno    ,      
                      INPUT-OUTPUT wdetail.vehuse   ,   
                      INPUT-OUTPUT wdetail.caryear  ,  
                      INPUT-OUTPUT wdetail.covcod   ,  
                      INPUT-OUTPUT wdetail.body     ,     
                      INPUT-OUTPUT wdetail.seat     ,     
                      INPUT-OUTPUT wdetail.cc       ,    
                      INPUT-OUTPUT wdetail.no_41    ,       
                      INPUT-OUTPUT wdetail.no_42    ,       
                      INPUT-OUTPUT wdetail.no_43    ,       
                      INPUT-OUTPUT wdetail.baseprem ,  
                      INPUT-OUTPUT nv_dss_per       ,
                      INPUT-OUTPUT nv_NCB           ,
                      INPUT-OUTPUT wdetail.garage   ,
                      INPUT-OUTPUT n_firstdat       ).
     ----- End Comment A53-0362 ---*/

    RUN wgw\wgwtaexp (INPUT-OUTPUT wdetail.renpol, 
                      INPUT-OUTPUT nv_ncnt ,
                      INPUT-OUTPUT wdetail.poltyp,   
                      INPUT-OUTPUT nv_branchold,       /*wdetail.branch ,  */
                      INPUT-OUTPUT wdetail.typreq,    
                      INPUT-OUTPUT wdetail.finit , 
                      INPUT-OUTPUT nv_insure ,           /*A64-0205*/
                      /*INPUT-OUTPUT wdetail.inscod, */  /*A64-0205*/ 
                      /*INPUT-OUTPUT wdetail.tiname, */ /*A61-0512*/ 
                      INPUT-OUTPUT nv_title,           /* A61-0512 */ 
                      /*INPUT-OUTPUT wdetail.insnam, */ /*A64-0278*/
                      INPUT-OUTPUT nv_insnam,           /*A64-0278*/   
                      INPUT-OUTPUT wdetail.name2 , 
                      /*INPUT-OUTPUT wdetail.iadd1 , */  /*A60-0327*/
                      /*INPUT-OUTPUT wdetail.iadd2 , */  /*A60-0327*/
                      /*INPUT-OUTPUT wdetail.iadd3 , */  /*A60-0327*/
                      /*INPUT-OUTPUT wdetail.iadd4 , */  /*A60-0327*/
                      INPUT-OUTPUT nv_addr1  ,           /*A60-0327*/
                      INPUT-OUTPUT nv_addr2  ,           /*A60-0327*/
                      INPUT-OUTPUT nv_addr3  ,           /*A60-0327*/
                      INPUT-OUTPUT nv_addr4  ,           /*A60-0327*/
                      INPUT-OUTPUT wdetail.subclass,     
                      INPUT-OUTPUT wdetail.brand ,        
                      INPUT-OUTPUT wdetail.model ,      
                      INPUT-OUTPUT wdetail.cc    ,          
                      INPUT-OUTPUT wdetail.weight /*nv_tons*/,  
                      INPUT-OUTPUT wdetail.seat  ,    
                      INPUT-OUTPUT wdetail.body  ,  
                      INPUT-OUTPUT wdetail.vehreg,  
                      INPUT-OUTPUT wdetail.engno ,      
                      INPUT-OUTPUT wdetail.chasno,          
                      INPUT-OUTPUT wdetail.caryear,             
                      INPUT-OUTPUT wdetail.carprovi,            
                      INPUT-OUTPUT wdetail.vehuse,            
                      INPUT-OUTPUT wdetail.garage,            
                      INPUT-OUTPUT wdetail.covcod,           
                      INPUT-OUTPUT wdetail.benname,          
                      INPUT-OUTPUT wdetail.NO_41,           
                      INPUT-OUTPUT wdetail.NO_42,            
                      INPUT-OUTPUT wdetail.NO_43,
                      INPUT-OUTPUT nv_uom1_V, /*A60-0327*/          
                      INPUT-OUTPUT nv_uom2_V, /*A60-0327*/           
                      INPUT-OUTPUT nv_uom5_V, /*A60-0327*/
                      INPUT-OUTPUT nv_ncb,            
                      INPUT-OUTPUT nv_tariff,            
                      INPUT-OUTPUT nv_baseprm,            
                      /*INPUT-OUTPUT wdetail.cargrp, */ /*A60-0327*/
                      INPUT-OUTPUT nv_vehgr,    /*A60-0327*/
                      INPUT-OUTPUT wdetail.redbook,            
                      INPUT-OUTPUT n_firstdat,             
                      INPUT-OUTPUT nv_dspc,     
                      INPUT-OUTPUT nv_drivnam,   /*wdetail.drivnam,  */
                      INPUT-OUTPUT nv_drivnam1,  /*wdetail.drivnam1, */
                      INPUT-OUTPUT nv_drivbir1,  /*wdetail.drivbir1, */
                      INPUT-OUTPUT nv_drivnam2,  /*wdetail.drivnam2, */
                      INPUT-OUTPUT nv_drivbir2,  /*wdetail.drivbir2, */
                      INPUT-OUTPUT wdetail.si,
                      INPUT-OUTPUT nv_loadclm,
                      INPUT-OUTPUT nv_fleet,
                      INPUT-OUTPUT nv_deductpd,
                      INPUT-OUTPUT nv_deductda,
                      INPUT-OUTPUT nv_deductdo,
                      INPUT-OUTPUT nv_stf_per,
                      INPUT-OUTPUT nv_dealer ,  /*A64-0205*/
                      INPUT-OUTPUT nv_chkexp ,   /*A64-0205*/
                      /*INPUT-OUTPUT nv_basere*/ 
                      INPUT-OUTPUT nre_premt ).

    wdetail.netprem = STRING(nre_premt).

    if nv_drivnam  <> "" then wdetail.drivnam  = trim(nv_drivnam).  /*A66-0190*/
    ELSE wdetail.drivnam  = "N".
    if nv_drivnam1 <> "" then wdetail.drivnam1 = trim(nv_drivnam1). /*A66-0190*/
    if nv_drivbir1 <> "" then wdetail.drivbir1 = trim(nv_drivbir1). /*A66-0190*/
    if nv_drivnam2 <> "" then wdetail.drivnam2 = trim(nv_drivnam2). /*A66-0190*/
    if nv_drivbir2 <> "" then wdetail.drivbir2 = trim(nv_drivbir2). /*A66-0190*/
    /*-- A53-0362 ---
    IF wdetail.prempa <> nv_prempa THEN wdetail.prempa = nv_prempa.
                                   ELSE wdetail.prempa = wdetail.prempa. --*/
    /*add by : A64-0205 */
    /*IF nv_branchold = wdetail.branch   THEN ASSIGN wdetail.inscod = nv_insure . 
    ELSE ASSIGN wdetail.inscod = "" .*/
    /*ASSIGN wdetail.inscod = nv_insure . */ /*A66-0190 gen now */
    /*IF wdetail.producer = "B3MLTMB101" THEN ASSIGN wdetail.finit = nv_dealer .  */ /*A64-0278*/
    IF wdetail.producer = "B3MLTTB101" THEN ASSIGN wdetail.finit = nv_dealer .      /*A64-0278*/
    ELSE ASSIGN wdetail.finit = ""  .  
    /* end : A64-0205 */
    /* Add by : A64-0278 */
    IF index(nv_insnam,"(") <> 0 THEN ASSIGN nv_insnam = trim(SUBSTR(nv_insnam,1,R-INDEX(nv_insnam,"(") - 1)) .
    IF TRIM(wdetail.insnam) <> TRIM(nv_insnam) THEN DO:
         ASSIGN
            wdetail.comment = wdetail.comment + "| " + nv_insnam + " ชื่อในใบเตือนไม่ตรงกับไฟล์ "
            wdetail.pass    = "Y"  .
    END.
    /* end A64-0278 */
    /* end : A64-0205 */
    /*MESSAGE " proc_recreate " SKIP
            "exp : " nv_branchold   nv_insure  
            "New : " wdetail.branch wdetail.inscod  VIEW-AS ALERT-BOX.*/

    IF nv_vehgr <> ""  THEN ASSIGN wdetail.cargrp = nv_vehgr  . /*A60-0327*/
    IF wdetail.covcod <> nv_covcod THEN DO: /*ถ้า Pack ไม่เหมือนใน Exp.Premium*/
        wdetail.covcod = nv_covcod.
        RUN proc_Chkbase.
        wdetail.baseprem = nv_baseprm.
        /*-- Check Pack เมื่อประเภทความคุ้มครองเปลี่ยน ป.1/ป.2 Pack G ป.3 Pack R --*/
        IF wdetail.covcod = "3" THEN 
            ASSIGN
               wdetail.prempa = "R"
               wdetail.subclass = wdetail.prempa + SUBSTRING(wdetail.subclass,2,3)
               wdetail.benname = "".
        ELSE 
            ASSIGN
                wdetail.prempa = "G"
                wdetail.subclass = wdetail.prempa + SUBSTRING(wdetail.subclass,2,3).
    END.
    ELSE DO: /*ถ้า Pack เหมือนใน Exp.Premium ให้ดึงจาก Exp. Premium*/
        ASSIGN
            wdetail.covcod   = wdetail.covcod
            wdetail.baseprem = nv_baseprm
            wdetail.subclass = wdetail.subclass.  
    END.


    IF wdetail.engno = "" THEN wdetail.engno = nv_engno. /*A54-0317*/

    /*--- Add A55-0235 ---*/
    IF wdetail.icno = ""  THEN DO:  /*A60-0383*/
        IF wdetail.inscod <> "" THEN DO:
            FIND LAST sicsyac.xmm600 USE-INDEX Xmm60001 WHERE
                      sicsyac.xmm600.acno = wdetail.inscod NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm600 THEN DO:
                IF sicsyac.xmm600.icno <> "" THEN DO:
                    wdetail.icno = sicsyac.xmm600.icno.
                END.
                ELSE wdetail.icno = wdetail.icno.
            END.
        END.
    END.
    /*--- End Add A55-0235 ---*/

    /*---- Comment A54-0076 ---
    IF wdetail.seat = "0" THEN DO: 
        wdetail.seat = "7".
        IF SUBSTRING(wdetail.subclass,2,3) = "110" THEN wdetail.seat = "7".
        IF SUBSTRING(wdetail.subclass,2,3) = "210" THEN wdetail.seat = "12".
        IF SUBSTRING(wdetail.subclass,2,3) = "220" THEN wdetail.seat = "15".
        IF SUBSTRING(wdetail.subclass,2,3) = "320" THEN wdetail.seat = "3".
    END.
    ELSE wdetail.seat = wdetail.seat.
    ---- End Comment A54-0076 ---*/ 

/* A63-0174*/
 IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
      FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
        trim(brstat.Insure.compno)  = TRIM(fi_package)  AND 
        trim(brstat.insure.vatcode) = TRIM(SUBSTR(wdetail.subclass,1,1))    NO-ERROR.
     IF AVAIL brstat.insure THEN 
         ASSIGN wdetail.prempa    = TRIM(brstat.insure.Text3)
                wdetail.subclass  = TRIM(brstat.insure.Text3) + TRIM(SUBSTR(wdetail.subclass,2,3)) .

  END.
/* end A63-0174 */
   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Renew C-Win 
PROCEDURE Proc_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfuwm100 FOR sicuw.uwm100 . /*A64-0205*/
ASSIGN nv_chkexp = ""   /*A64-0205*/
       nv_ncnt   = 0  . /*A64-0205*/

FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
          sicuw.uwm100.policy = wdetail.renpol NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicuw.uwm100 THEN DO:
    IF sicuw.uwm100.renpol <> "" THEN DO:
        /* add by : A64-0205 */
        FIND LAST bfuwm100 WHERE bfuwm100.policy = sicuw.uwm100.renpol  NO-LOCK NO-ERROR .
        IF AVAIL bfuwm100 THEN DO:
            IF bfuwm100.polsta = "IF" THEN 
             ASSIGN wdetail.renpol  = "Already Renew"
                    wdetail.comment = wdetail.comment + "| กรมธรรม์มีการต่ออายุแล้ว " + bfuwm100.policy
                    wdetail.OK_GEN  = "N"
                    wdetail.pass    = "N".
             ELSE DO:
                ASSIGN   
                    n_rencnt = sicuw.uwm100.rencnt + 1
                    n_endcnt = 0
                    wdetail.pass = "Y".
                    RUN Proc_ReCreate.
             END.
        END.
        /* end a64-0205 */
        /* comment by A64-0205 ..
        ASSIGN
            wdetail.renpol  = "Already Renew"
            wdetail.comment = wdetail.comment + "| กรมธรรม์มีการต่ออายุแล้ว"
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N".
        ...end  A64-0205 ..*/
    END.
    ELSE DO:
        IF wdetail.renpol <> "" THEN DO:
            ASSIGN
                n_rencnt = sicuw.uwm100.rencnt + 1
                n_endcnt = 0
                wdetail.pass = "Y".
            RUN Proc_ReCreate.
           
        END.
        ELSE DO:
            ASSIGN 
                n_rencnt = 0
                n_endcnt = 0.
            ASSIGN
                wdetail.comment = wdetail.comment + "| ไม่พบกรมธรรม์ที่ Expiry กรุณาตรวจสอบ" + wdetail.renpol
                wdetail.OK_GEN  = "N"
                wdetail.pass    = "N"
                wdetail.renpol  = "Not Policy Renew".
        END.
    END.
END.
/* A60-0383*/
ELSE DO:
    /* A64-0205 */
    IF wdetail.renpol <> ""  AND LENGTH(wdetail.renpol) < 12  THEN DO: /* กรมเดิมของ tm */
        RUN Proc_ReCreate.
        IF nv_chkexp = ""  THEN DO:
            ASSIGN
                n_rencnt = nv_ncnt + 1 
                n_endcnt = 0
                wdetail.pass = "Y".
        END.
        ELSE DO:
            ASSIGN 
            n_rencnt = 0
            n_endcnt = 0
            wdetail.comment = wdetail.comment + "| ไม่พบกรมธรรม์ที่ Expiry กรุณาตรวจสอบ" + wdetail.renpol
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N"
            wdetail.renpol  = "Not Policy Renew".
        END.
    END.
    /* A64-0205 */
    ELSE DO:
        ASSIGN 
            n_rencnt = 0
            n_endcnt = 0.
        ASSIGN
            wdetail.comment = wdetail.comment + "| ไม่พบกรมธรรม์ที่ Expiry กรุณาตรวจสอบ" + wdetail.renpol
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N"
            wdetail.renpol  = "Not Policy Renew".
    END.
END.
/* end A60-0383*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Renew01 C-Win 
PROCEDURE Proc_Renew01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0205...
IF wdetail.inscod = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Insure Code เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
... end A64-0205..*/
IF wdetail.insnam = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันภัยเป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.iadd1 = "" AND wdetail.iadd2 = "" AND wdetail.iadd3 = "" AND wdetail.iadd4 = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| ที่อยู่ผู้เอาประกันภัยเป็นค่าว่าง"
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.subclass = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Class เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.brand = "" OR wdetail.model = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Makes/Moddes เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.cc = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| CC เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.Seat = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Seat เป็นค่าว่าง"
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.body = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Body เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
/*--- Comment A54-0317 ---
IF wdetail.engno = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Engine No. เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
--- End Comment A54-0317 ---*/
IF wdetail.chasno = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Chassis No. เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.vehuse = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Veh.usage เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.covcod = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Cover type เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.redbook = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Model No. เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
/*A60-0383*/                                              
IF LENGTH(wdetail.icno) < 13  THEN DO:                       
    ASSIGN                                                   
           wdetail.pass    = "Y"                             
           wdetail.warning = "เลขบัตรประชาชนไม่ครบ 13 หลัก". 
END.                                                         
/* end A60-0383*/                                            
/* comment by A60-0383.....
IF wdetail.cargrp = "" THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Year Manuf. เป็นค่าว่าง "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
END.
.... end A60-0383....*/
/*----- Check Tariff And Class -----*/
IF wdetail.subclass <> "" THEN DO:
    FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
               sicsyac.xmd031.poltyp = wdetail.poltyp AND
               sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN DO:
        ASSIGN
            wdetail.comment = wdetail.comment + "| Not On Business Class " + wdetail.subclass + " on xmd031" 
            wdetail.pass    = "N"   
            WDETAIL.OK_GEN  = "N".
    END.

    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
         sicsyac.xmm016.class = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm016 THEN DO:
        ASSIGN
            wdetail.comment = wdetail.comment + "| Not on Business class " + wdetail.subclass + " on xmm016"
            wdetail.pass    = "N"    
            WDETAIL.OK_GEN  = "N".
    END.
    ELSE DO:
        ASSIGN
            wdetail.tariff   = sicsyac.xmm016.tardef
            wdetail.subclass = sicsyac.xmm016.class
            nv_sclass        = SUBSTRING(wdetail.subclass,2,3).
    END.
END.

/*----- Check Vehicle -----*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod = "u014" AND
     sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
        wdetail.pass    = "N" 
        WDETAIL.OK_GEN  = "N".
END.
/*----- Check CoverType -----*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod = "u013"  AND
     sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
         wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
         wdetail.pass    = "N"    
         WDETAIL.OK_GEN  = "N".
END.

/*----- Accessories -----*/
IF wdetail.access = "y" THEN DO:
    IF nv_class = "320" OR nv_sclass = "340" OR
       nv_class = "520" OR nv_sclass = "540" THEN wdetail.access = "Y".
    ELSE DO:
        ASSIGN
             wdetail.comment = wdetail.comment + "| Class " + nv_sclass + " นี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
             wdetail.pass    = "N"    
             WDETAIL.OK_GEN  = "N".
    END.
END.

/*---- NCB ----*/
IF (DECI(nv_ncb) = 0 )  OR (DECI(nv_ncb) = 20 ) OR
   (DECI(nv_ncb) = 30 ) OR (DECI(nv_ncb) = 40 ) OR
   (DECI(nv_ncb) = 50 )    THEN DO:
END.
ELSE 
 ASSIGN
     wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
     wdetail.pass    = "N"   
     WDETAIL.OK_GEN  = "N".

NV_NCBPER = INTE(nv_NCB).
IF nv_ncbper  <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
     sicsyac.xmm104.tariff = wdetail.tariff    AND
     sicsyac.xmm104.class  = wdetail.subclass  AND
     sicsyac.xmm104.covcod = wdetail.covcod    AND
     sicsyac.xmm104.ncbper = INTE(nv_ncb) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL  sicsyac.xmm104  THEN 
     ASSIGN
         wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
         wdetail.pass    = "N"     
         WDETAIL.OK_GEN  = "N".
    ELSE ASSIGN nv_ncbper = xmm104.ncbper   /*A63-0174*/
                nv_ncbyrs = xmm104.ncbyrs.  /*A63-0174*/
END. /*ncb <> 0*/

/*----- Driver Name -----*/
IF LENGTH(wdetail.subclass) = 3 THEN nv_sclass = wdetail.subclass.
ELSE nv_sclass = SUBSTRING(wdetail.subclass,2,3).
IF wdetail.drivnam = "Y" AND SUBSTRING(nv_sclass,2,1) = "2" THEN DO:
    ASSIGN
         wdetail.comment = wdetail.comment + "| CODE " + nv_sclass + " Driver 's Name must be no. "
         wdetail.pass    = "N"    
         WDETAIL.OK_GEN  = "N".
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Renew02 C-Win 
PROCEDURE Proc_Renew02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
        ASSIGN
            sic_bran.uwm130.policy = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   
            sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   
            sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno = s_itemno
            sic_bran.uwm130.bchyr  = nv_batchyr        /* batch Year */
            sic_bran.uwm130.bchno  = nv_batchno        /* bchno      */
            sic_bran.uwm130.bchcnt = nv_batcnt.        /* bchcnt     */

        IF (wdetail.covcod = "1") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR
            (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") OR (wdetail.covcod = "5")  THEN  /* A60-0327*/
            ASSIGN
                sic_bran.uwm130.uom6_v   = INTE(wdetail.si)
                sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.covcod = "2"  THEN 
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = INTE(wdetail.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.covcod = "3"  THEN 
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = 0
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

        FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
                   stat.clastab_fil.class   = wdetail.subclass AND
                   stat.clastab_fil.covcod  = wdetail.covcod   NO-LOCK  NO-ERROR NO-WAIT.
        IF AVAIL stat.clastab_fil THEN DO: 
            ASSIGN 
                /*sic_bran.uwm130.uom1_v     = stat.clastab_fil.uom1_si  */   /*A60-0327*/      
                /*sic_bran.uwm130.uom2_v     = stat.clastab_fil.uom2_si  */   /*A60-0327*/      
                /*sic_bran.uwm130.uom5_v     = stat.clastab_fil.uom5_si  */   /*A60-0327*/      
                sic_bran.uwm130.uom1_v     = if nv_uom1_v <> 0 then nv_uom1_v else stat.clastab_fil.uom1_si   /*A60-0327*/
                sic_bran.uwm130.uom2_v     = if nv_uom2_v <> 0 then nv_uom2_v else stat.clastab_fil.uom2_si   /*A60-0327*/
                sic_bran.uwm130.uom5_v     = if nv_uom5_v <> 0 then nv_uom5_v else stat.clastab_fil.uom5_si   /*A60-0327*/
                sic_bran.uwm130.uom8_v     = stat.clastab_fil.uom8_si                
                sic_bran.uwm130.uom9_v     = stat.clastab_fil.uom9_si          
                sic_bran.uwm130.uom3_v     = 0 
                sic_bran.uwm130.uom4_v     = 0     
                sic_bran.uwm130.uom1_c     = "D1"
                sic_bran.uwm130.uom2_c     = "D2"
                sic_bran.uwm130.uom5_c     = "D5"
                sic_bran.uwm130.uom6_c     = "D6"
                sic_bran.uwm130.uom7_c     = "D7".

            ASSIGN 
                /*WDETAIL.no_41    =  INTE(stat.clastab_fil.si_41unp)
                WDETAIL.no_42    =  INTE(stat.clastab_fil.si_42)
                WDETAIL.no_43    =  INTE(stat.clastab_fil.si_43)*//*Comment A54-0076 ดึงจาก Expiry โดยตรง*/ 
                WDETAIL.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
                wdetail.comper   =  stat.clastab_fil.uom8_si              
                wdetail.comacc   =  stat.clastab_fil.uom9_si
                nv_uom1_v        =  sic_bran.uwm130.uom1_v   
                nv_uom2_v        =  sic_bran.uwm130.uom2_v
                nv_uom5_v        =  sic_bran.uwm130.uom5_v  .
        END.

        ASSIGN
            nv_riskno = 1 
            nv_itemno = 1.

        IF wdetail.covcod = "1" THEN DO:
            RUN wgs/wgschsum(INPUT wdetail.policy,
                                   nv_riskno,
                                   nv_itemno).
        END.

    END. /*DO TRANSACTION*/

    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod = wdetail.covcod.
    nv_makdes = wdetail.brand.
    nv_moddes = wdetail.model.
    nv_newsck = "".

    IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.

    FIND sic_bran.uwm301 USE-INDEX uwm30101 WHERE
         sic_bran.uwm301.policy  =  sic_bran.uwm100.policy AND
         sic_bran.uwm301.rencnt  =  sic_bran.uwm100.rencnt AND
         sic_bran.uwm301.endcnt  =  sic_bran.uwm100.endcnt AND
         sic_bran.uwm301.riskgp  =  s_riskgp               AND
         sic_bran.uwm301.riskno  =  s_riskno               AND
         sic_bran.uwm301.itemno  =  s_itemno               AND
         sic_bran.uwm301.bchyr   =  nv_batchyr             AND
         sic_bran.uwm301.bchno   =  nv_batchno             AND
         sic_bran.uwm301.bchcnt  =  nv_batcnt              NO-ERROR.
    IF NOT AVAIL sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END.
    END.

    ASSIGN
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.bchyr    = nv_batchyr
        sic_bran.uwm301.bchno    = nv_batchno
        sic_bran.uwm301.bchcnt   = nv_batcnt
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = wdetail.covcod /*nv_covcod*/
        sic_bran.uwm301.modcod   = wdetail.redbook
        sic_bran.uwm301.cha_no   = wdetail.chasno
        sic_bran.uwm301.trareg   = nv_uwm301trareg
        sic_bran.uwm301.eng_no   = wdetail.engno
        sic_bran.uwm301.tons     = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine   = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        /*sic_bran.uwm301.garage   = IF SUBSTRING(wdetail.cedpol,6,1) = "U" THEN "" ELSE wdetail.garage*/  /*ฤ60-0327*/
        sic_bran.uwm301.garage   =  IF nv_covcod <> "1" THEN "" ELSE trim(wdetail.garage)  /*A60-0327*/
        sic_bran.uwm301.body     = wdetail.body
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg
        sic_bran.uwm301.vehgrp   = wdetail.cargrp
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model
        sic_bran.uwm301.sckno    = 0
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.prmtxt   = ""
        sic_bran.uwm301.car_color = wdetail.ncolor   
        sic_bran.uwm301.prmtxt    =  trim(wdetail.ACCESSORYtxt) .  /*A66-0160*/   

    IF wdetail.drivnam1 <> "" THEN wdetail.drivnam = "Y".
    RUN Proc_mailtxt.

    s_recid4 = RECID(sic_bran.uwm301).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Renew03 C-Win 
PROCEDURE Proc_Renew03 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_shown = "Please Wait Assign Parameter" + " " + wdetail.policy.
DISP fi_shown WITH FRAME fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN 
    nv_tariff    = sic_bran.uwm301.tariff
    nv_class     = wdetail.subclass
    nv_comdat    = sic_bran.uwm100.comdat
    nv_engine    = DECI(wdetail.cc)
    nv_tons      = DECI(wdetail.weight)
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse
    nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc) 
    nv_seats     = INTE(wdetail.seat)
    nv_tons      = DECI(wdetail.weight).
    /*nv_dss_per   = IF rapolicy = 1 THEN 0 ELSE nv_dss_per*/     
   /* nv_dsspcvar1 = ""
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
    nv_ncb       = IF rapolicy = 1 THEN 0 ELSE nv_ncb
    nv_totsi     = 0 .
/*งานต่ออายุทุกเบอร์กรมธรรม์ให้ค่า Inspection เป็นค่าว่าง*/
nv_logbok = "".      
/*IF wdetail.prempa = "G" THEN nv_logbok = "Y". ELSE nv_logbok = " ".*//*Comment A53-0362*/
IF wdetail.prempa = "G" AND wdetail.renpol = "" THEN nv_logbok = "Y". ELSE nv_logbok = " ". /*Add A53-0362*/
*/
IF wdetail.poltyp = "V70" THEN
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

IF nv_comper = 0 AND nv_comacc = 0 THEN nv_compprm = 0.

/*--- nv_drivcod ----*/
nv_drivvar1 = wdetail.drivnam1.
nv_drivvar2 = wdetail.drivnam2.
IF wdetail.drivnam = "N" OR wdetail.drivnam = "" THEN DO:
    ASSIGN nv_drivvar  = " "
           nv_drivcod  = "A000"
           nv_drivvar1 = "     Unname Driver"
           nv_drivvar2 = "0"
           SUBSTR(nv_drivvar,1,30)   = nv_drivvar1
           SUBSTR(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
    IF nv_drivno > 2 THEN DO:
        MESSAGE " Driver'S NO. must not over 2. "  VIEW-AS ALERT-BOX.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
        /*NEXT. *//*a490166*/
    END.
    ASSIGN nv_drivvar   = " "
           nv_drivvar1  = "     Driver name person = "
           nv_drivvar2  = STRING(nv_drivno)
           SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
           SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.
    RUN proc_usdcod.
END.
 
/*--- nv_baseprm ---*/
/*RUN wgs\wgsfbas.*/
/*nv_baseprm = 0.*/

/*IF wdetail.baseprem <> 0 THEN*/ nv_baseprm = wdetail.baseprem.
                        /* ELSE RUN Proc_Chkbase.*/

IF NO_basemsg <> " " THEN wdetail.WARNING = NO_basemsg.
IF nv_baseprm = 0 THEN DO:
    ASSIGN wdetail.pass    = "N"
           wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
END.
ASSIGN nv_basevar  = ""
       nv_prem1    = nv_baseprm
       nv_basecod  = "BASE"
       nv_basevar1 = "     Base Premium = "
       nv_basevar2 = STRING(nv_baseprm)
       SUBSTRING(nv_basevar,1,30)   = nv_basevar1
       SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
/*--- nv_add perils ---*/
ASSIGN nv_41 =  WDETAIL.no_41  
       nv_42 =  WDETAIL.no_42  
       nv_43 =  WDETAIL.no_43
       nv_seat41 = INTEGER(wdetail.seat41).
/*comment by : A64-0138..
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                      nv_class,
                      nv_key_b,
                      nv_comdat).*/

ASSIGN  nv_411var   = ""    nv_412var = ""
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
nv_42var    = " ".      /* -------fi_42---------*/
ASSIGN nv_42cod   = "42"
       nv_42var1  = "     Medical Expense = "
       nv_42var2  = STRING(nv_42)
       SUBSTRING(nv_42var,1,30)   = nv_42var1
       SUBSTRING(nv_42var,31,30)  = nv_42var2.
nv_43var    = " ".      /*---------fi_43--------------*/
ASSIGN  nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
/*comment by : A64-0138..
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                      nv_class,
                      nv_key_b,
                      nv_comdat).*/
/*---- nv_usecod ---*/
ASSIGN nv_usevar  = ""
       nv_usecod  = "USE" + TRIM(wdetail.vehuse)
       nv_usevar1 = "     Vehicle Use = "
       nv_usevar2 =  wdetail.vehuse
       SUBSTRING(nv_usevar,1,30)   = nv_usevar1
       SUBSTRING(nv_usevar,31,30) = nv_usevar2.
/*--- nv_engcod ---*/
/*ASSIGN nv_sclass = SUBSTRING(wdetail.subclass,2,3).*//*A53-0111*/
RUN wgs\wgsoeng.
/*----- nv_yrcod ------*/
ASSIGN  nv_yrvar = ""
    nv_caryr   = (YEAR(nv_comdat)) - INTEGER(wdetail.caryear) + 1
    nv_yrvar1  = "     Vehicle Year = "
    nv_yrvar2  =  STRING(wdetail.caryear)
    nv_yrcod   = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
    SUBSTRING(nv_yrvar,1,30)    = nv_yrvar1
    SUBSTRING(nv_yrvar,31,30)   = nv_yrvar2.
/*----- nv_sicod ------*/
ASSIGN  nv_sivar = ""
    nv_sicod     = "SI"
    nv_sivar1    = "     Own Damage = "
    nv_sivar2    =  STRING(wdetail.si)
    SUBSTRING(nv_sivar,1,30)  = nv_sivar1
    SUBSTRING(nv_sivar,31,30) = nv_sivar2
    nv_totsi     =  INTE(wdetail.si).
/*------ nv_grpcod -----*/
ASSIGN  nv_grpvar  = ""
    nv_grpcod      = "GRP" + wdetail.cargrp
    nv_grpvar1     = "     Vehicle Group = "
    nv_grpvar2     = wdetail.cargrp
    SUBSTRING(nv_grpvar,1,30)  = nv_grpvar1
    SUBSTRING(nv_grpvar,31,30) = nv_grpvar2.
/*------ nv_bipcod ------*/
ASSIGN  nv_bipvar  = ""
    nv_bipcod      = "BI1"
    nv_bipvar1     = "     BI per Person = "
    nv_bipvar2     = STRING(uwm130.uom1_v)
    SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
    SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
/*------ nv_biacod -------*/
ASSIGN  nv_biavar  = "" 
    nv_biacod      = "BI2"
    nv_biavar1     = "     BI per Accident = "
    nv_biavar2     = STRING(uwm130.uom2_v)
    SUBSTRING(nv_biavar,1,30)  = nv_biavar1
    SUBSTRING(nv_biavar,31,30) = nv_biavar2.
/*------- nv_pdacod --------*/
ASSIGN  nv_pdavar  = ""  
    nv_pdacod      = "PD"
    nv_pdavar1     = "     PD per Accident = "
    nv_pdavar2     = STRING(uwm130.uom5_v)
    SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
    SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
/*------- deduct --------*/
/*dod0 = INTEGER(wdetail.deductda).*//*A53-0111*/
DEF VAR dod0 AS INTEGER init 0.
DEF VAR dod1 AS INTEGER init 0.
DEF VAR dod2 AS INTEGER init 0.
DEF VAR dpd0 AS INTEGER init 0.
/* comment by : A60-0383
dod0 = INTEGER(nv_deductda).
IF dod0 > 3000 THEN DO:
   dod1 = 3000.
   dod2 = dod0 - dod1.
END.*/

ASSIGN dod1 = INT(nv_deductdo)   /*A60-0383*/
       dod2 = INT(nv_deductda)   /*A60-0383*/
       dpd0 = INT(nv_deductpd).   /*A60-0383*/

ASSIGN nv_dedod1var = ""
    nv_odcod = "DC01"
    nv_prem  = dod1.

RUN Wgs\Wgsmx024( nv_tariff,                    /*a490166 note modi*/
                  nv_odcod,
                  nv_class,
                  nv_key_b,
                  nv_comdat,
                  INPUT-OUTPUT nv_prem,
                  OUTPUT nv_chk ,
                  OUTPUT nv_baseap).
 
IF NOT nv_chk THEN DO:
    MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  VIEW-AS ALERT-BOX.
    ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
    /*NEXT.*/
END.
IF dod1 <> 0  THEN
    ASSIGN  nv_dedod1var  = ""
        nv_ded1prm        = nv_prem
        nv_dedod1_prm     = nv_prem
        nv_dedod1_cod     = "DOD"
        nv_dedod1var1     = "     Deduct OD = "
        nv_dedod1var2     = STRING(dod1)
        SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
        SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.

ASSIGN  nv_dedod2var = " "
        nv_cons      = "AD"
        nv_ded       = dod2.
/*comment by : A64-0138...
RUN  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                         nv_tariff,
                         nv_class,
                         nv_key_b,
                         nv_comdat,
                         nv_cons,
                         OUTPUT nv_prem).*/
IF dod2 <> 0  THEN
ASSIGN  nv_dedod2var    = ""
        nv_aded1prm     = nv_prem
        nv_dedod2_cod   = "DOD2"
        nv_dedod2var1   = "     Add Ded.OD = "
        nv_dedod2var2   =  STRING(dod2)
        SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
        SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2.
        /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
/*------ pd -------*/
ASSIGN  nv_dedpdvar  = " "
        dpd0     = INTE(nv_deductpd) 
        nv_cons  = "PD"
        nv_ded   = dpd0.
/*comment by : A64-0138...
RUN  Wgs\Wgsmx025(INPUT  nv_ded, /*a490166 note modi*/
                         nv_tariff,
                         nv_class,
                         nv_key_b,
                         nv_comdat,
                         nv_cons,
                         OUTPUT nv_prem).
nv_ded2prm  = nv_prem.*/
IF dpd0 <> 0 THEN
ASSIGN  nv_dedpd_cod   = "DPD"
        nv_dedpdvar1   = "     Deduct PD = "
        nv_dedpdvar2   =  STRING(nv_ded)
        SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
        SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
        /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/

/*------- NCB ---------*/
/*nv_ncbper = INTE(wdetail.ncb).*/
IF nv_ncb <> 0 THEN DO:
    nv_ncbper = nv_ncb.
    nv_ncbvar = " " .
    /*comment by : A64-0138...
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).*/
    nv_ncbvar   = " ".
    IF nv_ncb <> 0 THEN
        ASSIGN  nv_ncbvar1   = "     NCB % = "
                nv_ncbvar2   =  STRING(nv_ncbper)
                SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
                SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
END.
/*nv_ncb = 0.
nv_ncbper = 0.
nv_ncbyrs = 0.*/
/*------- fleet ---------*/
/*nv_flet_per = INTE(wdetail.fleet).*//*A53-0111*/
nv_flet_per = INTE(nv_fleet).
IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
    /*Message  " Fleet Percent must be 0 or 10. " View-as alert-box.*/
    ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    /*NEXT.  *//*a490166*/
END.
IF nv_flet_per = 0 THEN DO:
    ASSIGN nv_flet    = 0
           nv_fletvar = " ".
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
                           uwm130.uom5_v).*/
ELSE 
ASSIGN  nv_fletvar     = " "
        nv_fletvar1    = "     Fleet % = "
        nv_fletvar2    =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.        

IF nv_flet  = 0 THEN nv_fletvar = " ".
/*-------- load claim ---------*/
/*nv_cl_per   = DECI(wdetail.loadclm).*//*A53-0111*/
nv_cl_per   = DECI(nv_loadclm).
nv_clmvar   = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN nv_clmvar1   = " Load Claim % = "
           nv_clmvar2   =  STRING(nv_cl_per)
           SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
           SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
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
nv_clmvar = " ".
IF nv_cl_per <> 0 THEN
    ASSIGN  nv_clmvar1   = " Load Claim % = "
            nv_clmvar2   =  STRING(nv_cl_per)
            SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
            SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.  
...end A64-0138...*/
/*--- Dsscp ---*/
/*RUN Proc_Dsspc.     */  
nv_dsspcvar   = " ".
nv_dss_per = 0.
ASSIGN                
    nv_dss_per = nv_dspc /*per*/ .     
IF  nv_dss_per   <> 0  THEN
    ASSIGN
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
/*--------------------------*/
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

nv_dsspcvar   = " ".
IF  nv_dss_per   <> 0  THEN
        ASSIGN
            nv_dsspcvar1   = "     Discount Special % = "
            nv_dsspcvar2   =  STRING(nv_dss_per)
            SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
            SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.

/*----- DisCount Staff ----*/
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
             nv_class,
             nv_covcod,
             nv_key_b,
             nv_comdat,
             nv_totsi,
             nv_uom1_v ,       
             nv_uom2_v ,       
             nv_uom5_v ). 
...end : A64-0138...*/
nv_stfvar   = " ".
IF  nv_stf_per  <> 0  THEN
        ASSIGN
            nv_stfvar1   = "     Discount Staff % = "
            nv_stfvar2   =  STRING(nv_stf_per)
            SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1
            SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.

IF wdetail.pass <> "N" THEN
        ASSIGN wdetail.comment = "COMPLETE"
               WDETAIL.WARNING = ""
               wdetail.pass    = "Y".
/* add by : A64-0138 */
IF wdetail.Prem_t <> "" THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN DO:
            ASSIGN 
                wdetail.netprem  = STRING(TRUNCATE(((deci(wdetail.Prem_t) * 100 ) / 107.43 ),0 ),">>>,>>>,>>9.99") .
               
     END.
     ELSE  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
            ASSIGN wdetail.netprem  = STRING(TRUNCATE(((deci(wdetail.Prem_t) * 100 ) / 107.43 ),0 ),">>>,>>>,>>9.99").
END.

RUN proc_calpremt .      
RUN proc_adduwd132prem . 
/* end : A64-0138 */

RUN proc_uwm100. /*A60-0327*/
/* comment by A60-0327 .................
FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
         sic_bran.uwm100.prem_t = nv_gapprm
         sic_bran.uwm100.sigr_p = INTE(wdetail.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.
     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.       
END.
......end A60-0327......*/
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = INTE(wdetail.si).
 
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = wdetail.seat41
        sic_bran.uwm301.logbok   = nv_logbok. /*A53-0111*/
/* Add by A63-0174 */
        sic_bran.uwm301.tons  = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN sic_bran.uwm301.tons * 1000 
                                ELSE sic_bran.uwm301.tons .
IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.subclass,2,1) = "3"   OR  
   SUBSTR(wdetail.subclass,2,1) = "4"   OR  SUBSTR(wdetail.subclass,2,1) = "5"  OR  
   SUBSTR(wdetail.subclass,2,3) = "803" OR SUBSTR(wdetail.subclass,2,3) = "804" OR  
   SUBSTR(wdetail.subclass,2,3) = "805" ) THEN DO:
     MESSAGE wdetail.policy + " " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
    ASSIGN
        wdetail.comment = wdetail.comment + "| " + wdetail.subclass + " ระบุน้ำหนักรถไม่ถูกต้อง "
        wdetail.pass    = "N"  .   
END. 
/* end A63-0174 */
/* comment by : A64-0138...
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/
RUN Proc_ClearData.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_RePolicy C-Win 
PROCEDURE Proc_RePolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR chk_sticker AS CHAR FORMAT "X(15)".
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk <> "" THEN DO:
        IF SUBSTRING(wdetail.stk,1,1) = "2" THEN 
            ASSIGN
                CHR_sticker = "0" + wdetail.stk
                wdetail.stk = "0" + wdetail.stk.
        ELSE
            ASSIGN
                CHR_sticker = wdetail.stk
                wdetail.stk = wdetail.stk.
        chk_sticker = CHR_sticker.
        RUN wuz\wuzchmod.
        
        IF chk_sticker <> CHR_sticker THEN
            ASSIGN
                wdetail.pass = "N"
                wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".

        nv_newsck = "".
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
                   stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAILABLE stat.detaitem THEN
            ASSIGN
               wdetail.pass    = "N"
               wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
               wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".

        /*---- Check Policy ซ้ำ -----*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR 
               sicuw.uwm100.comdat <> ? OR
               sicuw.uwm100.releas = YES THEN DO:
                ASSIGN
                   wdetail.pass    = "N"
                   wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                   wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        ELSE RUN proc_create100.
    END. /* wdetail.stk <> "" */
    ELSE DO:
        /*-- Check กรมธรรม์ซ้ำ --*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> ""  OR
               sicuw.uwm100.comdat <> ?  OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END. /* wdetail.stk = "" */
END. /* wdetail.policy <> " " */ 
ELSE DO:
    nv_tmppol = SUBSTRING(wdetail.poltyp,2,2) + wdetail.cedpol.
    wdetail.policy = nv_tmppol.
    IF wdetail.stk <> "" THEN DO:
        /*-- Check Sticker No. --*/
        IF SUBSTRING(wdetail.stk,1,1) = "2" THEN ASSIGN 
                                                    chr_sticker = "0" + wdetail.stk
                                                    wdetail.stk = "0" + wdetail.stk.
                                            ELSE ASSIGN
                                                    chr_sticker = wdetail.stk
                                                    wdetail.stk = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.

        IF chk_sticker <> chr_sticker THEN
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        
        nv_newsck = "".
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
                   stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN
            ASSIGN                               
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".

        /*-- Check กรมธรรม์ซ้ำ --*/
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAILABLE sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR
               sicuw.uwm100.comdat <> ? OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END.
    ELSE DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> ""  OR
               sicuw.uwm100.comdat <> ?  OR
               sicuw.uwm100.releas = YES THEN
                ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ELSE RUN proc_create100.
    END.
END.

s_recid1 = RECID(sic_bran.uwm100).

FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.

IF wdetail.poltyp = "V70" AND wdetail.docno <> "" THEN ASSIGN nv_docno  = wdetail.docno
                                                              nv_accdat = TODAY.
                                                  ELSE DO:
                                                      IF wdetail.docno  = "" THEN nv_docno  = "".
                                                      IF wdetail.accdat = "" THEN nv_accdat = TODAY.
                                                  END.
wdetail.accdat = wdetail.comdat.
IF wdetail.inscod = "" THEN DO:
    RUN Proc_CreateIns .
    RUN Proc_CreateIns2 .
END.
ELSE ASSIGN nv_insref = wdetail.inscod.   /*A64-00138*/ 

/*MESSAGE "proc_repolicy " SKIP
        "inscode "  nv_insref  wdetail.inscod VIEW-AS ALERT-BOX.*/

IF nv_insref <> "" THEN ASSIGN wdetail.inscod = nv_insref.

DO TRANSACTION :
    ASSIGN
        sic_bran.uwm100.renno   = ""
        sic_bran.uwm100.endno   = ""
        sic_bran.uwm100.poltyp  = wdetail.poltyp
        sic_bran.uwm100.insref  = wdetail.inscod /*uwm100.insref*/
        sic_bran.uwm100.opnpol  = SUBSTRING(wdetail.opnpol,1,INDEX(wdetail.opnpol,"(") - 1)
        /*sic_bran.uwm100.anam2   = ""*//*Comment A55-0235*/
        sic_bran.uwm100.anam2   = wdetail.icno
        sic_bran.uwm100.ntitle  = wdetail.tiname /*uwm100.ntitle*/
        sic_bran.uwm100.name1   = wdetail.insnam /*uwm100.name1 */
        /*sic_bran.uwm100.name2   = wdetail.name2  /*uwm100.name2*/ */ /*A60-0383*/
        sic_bran.uwm100.name3   = ""             /*uwm100.name3*/
        sic_bran.uwm100.addr1   = wdetail.iadd1  /*uwm100.addr1*/             
        sic_bran.uwm100.addr2   = wdetail.iadd2  /*uwm100.addr2*/       
        sic_bran.uwm100.addr3   = wdetail.iadd3  /*uwm100.addr3*/      
        sic_bran.uwm100.addr4   = wdetail.iadd4  /*uwm100.addr4 */
        sic_bran.uwm100.postcd  = ""             /*uwm100.postcd*/
        sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")   /*   nv_undyr  */
        sic_bran.uwm100.branch  = wdetail.branch               /* nv_branch  */                        
        sic_bran.uwm100.dept    = nv_dept
        sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
        sic_bran.uwm100.fstdat  = DATE(wdetail.comdat) /*TODAY */
        sic_bran.uwm100.comdat  = DATE(wdetail.comdat)
        sic_bran.uwm100.expdat  = DATE(wdetail.expdat)
        sic_bran.uwm100.accdat  = TODAY /*nv_accdat */                   
        sic_bran.uwm100.tranty  = "N"  /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug  = "T"
        sic_bran.uwm100.acctim  = "00:00"
        sic_bran.uwm100.trty11  = "M"      
        sic_bran.uwm100.docno1  =  " " /*STRING(nv_docno,"9999999")*/     
        sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
        sic_bran.uwm100.entdat  = TODAY
        sic_bran.uwm100.curbil  = "BHT"
        sic_bran.uwm100.curate  = 1
        sic_bran.uwm100.instot  = 1
        sic_bran.uwm100.prog    = "wgwtagen"
        sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
        sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short   = NO
        /*sic_bran.uwm100.acno1   = fi_producer /*nv_acno1 */ */ /*A64-0205*/
        /*sic_bran.uwm100.agent   = fi_agent    /*nv_agent */ */ /*A64-0205*/
        sic_bran.uwm100.acno1   = wdetail.producer  /*A64-0205*/
        sic_bran.uwm100.agent   = wdetail.agent     /*A64-0205*/
        sic_bran.uwm100.insddr  = NO
        sic_bran.uwm100.coins   = NO
        sic_bran.uwm100.billco  = ""
        sic_bran.uwm100.fptr01  = 0   sic_bran.uwm100.bptr01 = 0
        sic_bran.uwm100.fptr02  = 0   sic_bran.uwm100.bptr02 = 0
        sic_bran.uwm100.fptr03  = 0   sic_bran.uwm100.bptr03 = 0
        sic_bran.uwm100.fptr04  = 0   sic_bran.uwm100.bptr04 = 0
        sic_bran.uwm100.fptr05  = 0   sic_bran.uwm100.bptr05 = 0
        sic_bran.uwm100.fptr06  = 0   sic_bran.uwm100.bptr06 = 0  
        sic_bran.uwm100.styp20  = "NORM"
        sic_bran.uwm100.dir_ri  = YES
        sic_bran.uwm100.drn_p   = NO
        sic_bran.uwm100.sch_p   = NO
        sic_bran.uwm100.cr_2    = wdetail.cr_2
        sic_bran.uwm100.bchyr   = nv_batchyr         /*Batch Year */  
        sic_bran.uwm100.bchno   = nv_batchno         /*Batch No.  */  
        sic_bran.uwm100.bchcnt  = nv_batcnt          /*Batch Count*/  
        sic_bran.uwm100.prvpol  = wdetail.renpol     /*A52-0172*/
        sic_bran.uwm100.cedpol  = wdetail.cedpol 
       /* sic_bran.uwm100.finint  = wdetail.finit      /*A53-0111 Dealer Code*/                    */ /*A60-0383*/
       /* sic_bran.uwm100.bs_cd   = wdetail.typreq     /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/  */ /*A60-0383*/
        sic_bran.uwm100.finint  = trim(wdetail.finit)      /*A64-0205 Dealer Code*/  
        sic_bran.uwm100.accdat  = DATE(wdetail.comdat)
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.br_insured = trim(wdetail.br_insured)   /*Add by Kridtiya i. A63-0472*/
       /* sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov) */ /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = wdetail.producer
        sic_bran.uwm100.dealer     = trim(wdetail.financecd).    /*Add by Kridtiya i. A63-0472*/ 
         
    IF wdetail.renpol <> "" THEN DO:
        IF wdetail.poltyp = "V72" THEN 
            ASSIGN sic_bran.uwm100.prvpol  = ""
                   sic_bran.uwm100.tranty  = "R".
        ELSE
            ASSIGN sic_bran.uwm100.prvpol  = wdetail.renpol
                   sic_bran.uwm100.tranty  = "R". 
    END.

    IF wdetail.pass = "Y" THEN  sic_bran.uwm100.impflg = YES.
                          ELSE  sic_bran.uwm100.impflg = NO.

    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN
       sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.

    IF wdetail.cancel = "CA" THEN sic_bran.uwm100.polsta = "CA".
                             ELSE sic_bran.uwm100.polsta = "IF".

    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
                       ELSE sic_bran.uwm100.trndat = TODAY.

    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    /*---- Comment Porn A54-0076 -----*/
    nv_polday = IF (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365) OR
                   (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366) OR
                   (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367) THEN 365
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
    /*---- End Comment A54-0076 ----*/
    /*---- Add A54-0076 ----
    IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
         MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
        (DAY(sic_bran.uwm100.comdat)      =  29                             AND
         MONTH(sic_bran.uwm100.comdat)    =  02                             AND
         DAY(sic_bran.uwm100.expdat)      =  01                             AND
         MONTH(sic_bran.uwm100.expdat)    =  03                             AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
    THEN nv_polday = 365.
    ELSE nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  ??? */
    ---- End A54-0076 ----*/

    IF sic_bran.uwm100.poltyp = "V70" THEN DO:
        IF wdetail.renpol = "" THEN RUN proc_uwd100. /*Text F7*/
        RUN proc_uwd102. /*Memo Text F8*/
    END.

END. /* DO TRANSECTION*/

/*-------------- U W M 1 2 0 ----------------*/
FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE
     sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
     sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
     sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
     sic_bran.uwm120.riskgp = s_riskgp               AND
     sic_bran.uwm120.riskno = s_riskno               AND
     sic_bran.uwm120.bchyr  = nv_batchyr             AND
     sic_bran.uwm120.bchno  = nv_batchno             AND
     sic_bran.uwm120.bchcnt = nv_batcnt              NO-ERROR NO-WAIT.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).

    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.
END.

IF AVAILABLE sic_bran.uwm120 THEN DO: 
      ASSIGN
      sic_bran.uwm120.sicurr  = "BHT"
      sic_bran.uwm120.siexch  = 1  /*not sure*/
      sic_bran.uwm120.fptr01  = 0               
      sic_bran.uwm120.fptr02  = 0               
      sic_bran.uwm120.fptr03  = 0               
      sic_bran.uwm120.fptr04  = 0               
      sic_bran.uwm120.fptr08  = 0               
      sic_bran.uwm120.fptr09  = 0          
      sic_bran.uwm120.com1ae  = YES
      sic_bran.uwm120.stmpae  = YES
      sic_bran.uwm120.feeae   = YES
      sic_bran.uwm120.taxae   = YES
      sic_bran.uwm120.bptr01  = 0 
      sic_bran.uwm120.bptr02  = 0 
      sic_bran.uwm120.bptr03  = 0 
      sic_bran.uwm120.bptr04  = 0 
      sic_bran.uwm120.bptr08  = 0 
      sic_bran.uwm120.bptr09  = 0 
      sic_bran.uwm120.bchyr   = nv_batchyr         /* batch Year */
      sic_bran.uwm120.bchno   = nv_batchno         /* bchno    */
      sic_bran.uwm120.bchcnt  = nv_batcnt .      /* bchcnt     */

      ASSIGN 
          sic_bran.uwm120.class = wdetail.subclass
          s_recid2              = RECID(sic_bran.uwm120).
END.

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
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :
    NOT_pass = NOT_pass + 1.
END.

IF NOT_pass > 0 THEN DO:
/*a490166 05/10/2006 block*/
/* a = fi_FileName.              */
/* c = R-INDEX (a,".").          */
/* b = SUBSTR(a,1,c) + "err" .   */
/*                               */
OUTPUT STREAM ns1 TO value(fi_output2).
/*PUT STREAM ns2 "ID;PND" SKIP.*/
        PUT STREAM ns1
            "entry date"            ","  
            "entry time"            ","  
            "trans date"            ","  
            "trans time"            ","  
            "policy type"           ","  
            "policy"                ","  
            "rennew policy"         ","  
            "comdat"                ","  
            "expdat"                ","  
            "compulsory"            ","  
            "title name"            ","  
            "insure name"           ","  
            "insure add1"           ","  
            "insure add2"           ","  
            "insure add3"           ","  
            "insure add4"           ","  
            "premium pack"          ","  
            "subclass"              ","  
            "brand"                 ","  
            "model"                 ","  
            "cc"                    ","  
            "weight"                ","  
            "seat"                  ","  
            "body"                  ","  
            "vehicle register"      ","  
            "engine no"             ","  
            "chassis no"            ","  
            "car year"              ","  
            "car province"          ","  
            "vehicle use"           ","  
            "garage"                ","  
            "sticker"               ","  
            "accessories"           ","  
            "cover type"            ","  
            "sum insure"            ","  
            "voluntory premium"     ","  
            "Compulsory premmium"   ","  
            /*"fleet"                 ","  
            "ncb"                   ","  
            "load claim"            ","  
            "deduct da"             ","  
            "deduct pd"             ","  *//*A53-0111*/
            "benefit name"          ","  
            "user"                  ","  
            "IMPORT"               ","   
            "export"               ","   
            "driver name"          ","   
            "driver name1"         ","   
            "driver name2"         ","   
            "driver birth1"        ","   
            "driver birth2"        ","   
            "driver age1"          ","   
            "driver age2"          ","   
            "cancel"               ","
            "Redbook"              ","
            "Comment"              "," 
            "Warning"
        SKIP.

    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :
        PUT STREAM ns1
     
        wdetail.entdat     ","
        wdetail.enttim     ","
        wdetail.trandat    ","
        wdetail.trantim    ","
        wdetail.poltyp     ","
        wdetail.policy     ","
        wdetail.renpol     ","
        wdetail.comdat     ","
        wdetail.expdat     "," 
        wdetail.compul     ","
        wdetail.tiname     ","
        wdetail.insnam     ","
        wdetail.iadd1      "," 
        wdetail.iadd2      ","
        wdetail.iadd3      ","
        wdetail.iadd4      ","
        wdetail.prempa     ","  
        wdetail.subclass   "," 
        wdetail.brand      ","  
        wdetail.model      ","  
        wdetail.cc         ","  
        wdetail.weight     ","  
        wdetail.seat       ","  
        wdetail.body       ","  
        wdetail.vehreg     ","        
        wdetail.engno      ","  
        wdetail.chasno     "," 
        wdetail.caryear    ","               
        wdetail.carprovi   ","               
        wdetail.vehuse     ","               
        wdetail.garage     ","               
        wdetail.stk        ","               
        wdetail.access     "," 
        wdetail.covcod     "," 
        wdetail.si         "," 
        wdetail.volprem    "," 
        wdetail.Compprem   "," 
        /*wdetail.fleet      "," 
        wdetail.ncb        "," 
        wdetail.loadclm    "," 
        wdetail.deductda   "," 
        wdetail.deductpd   "," *//*A53-0111*/
        wdetail.benname    "," 
        wdetail.n_user     "," 
        wdetail.n_IMPORT  "," 
        wdetail.n_export  "," 
        wdetail.drivnam   "," 
        wdetail.drivnam1  "," 
        wdetail.drivnam2  "," 
        wdetail.drivbir1  "," 
        wdetail.drivbir2  "," 
        wdetail.drivage1  "," 
        wdetail.drivage2  "," 
        wdetail.cancel    ","
        wdetail.redbook   ","
        wdetail.base      ","
        wdetail.accdat    ","
        wdetail.docno     ","
        wdetail.comment   ","
        wdetail.WARNING

    SKIP.  
                                                                                               
                                                                                               
END.                                                                                           
/*PUT STREAM ns2 "E". */                                                                           
OUTPUT STREAM ns1 CLOSE.                                                           
END. /*not pass = 0*/

END PROCEDURE.

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

FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
/*a490166 block 05/10/2006*/
/* a = fi_FileName.                           */
/* c = R-INDEX (a,".").                       */
/* d = R-INDEX (a,"\").                       */
/* f = SUBSTR(a,(d + 1),(c - d)).             */
/* b = SUBSTR(a,1,d) + "safe_" + f + "CSV"  . */

OUTPUT STREAM ns2 TO value(fi_output1).
/*PUT STREAM ns2 "ID;PND" SKIP.*/
          PUT STREAM NS2
            "entry date"            ","  
            "entry time"            ","  
            "trans date"            ","  
            "trans time"            ","  
            "policy type"           ","  
            "policy"                ","  
            "rennew policy"         ","  
            "comdat"                ","  
            "expdat"                ","  
            "compulsory"            ","  
            "title name"            ","  
            "insure name"           ","  
            "insure add1"           ","  
            "insure add2"           ","  
            "insure add3"           ","  
            "insure add4"           ","  
            "premium pack"          ","  
            "subclass"              ","  
            "brand"                 ","  
            "model"                 ","  
            "cc"                    ","  
            "weight"                ","  
            "seat"                  ","  
            "body"                  ","  
            "vehicle register"      ","  
            "engine no"             ","  
            "chassis no"            ","  
            "car year"              ","  
            "car province"          ","  
            "vehicle use"           ","  
            "garage"                ","  
            "sticker"               ","  
            "accessories"           ","  
            "cover type"            ","  
            "sum insure"            ","  
            "voluntory premium"     ","  
            "Compulsory premmium"   ","  
            "fleet"                 ","  
            "ncb"                   ","  
            "load claim"            ","  
            "deduct da"             ","  
            "deduct pd"             ","  
            "benefit name"          ","  
            "user"                  ","  
            "IMPORT"               ","   
            "export"               ","   
            "driver name"          ","   
            "driver name1"         ","   
            "driver name2"         ","   
            "driver birth1"        ","   
            "driver birth2"        ","   
            "driver age1"          ","   
            "driver age2"          ","   
            "cancel"               ","
            "Redbook"              ","
            "Comment"              "," 
            "Warning"
        SKIP.

    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
     
        wdetail.entdat     ","
        wdetail.enttim     ","
        wdetail.trandat    ","
        wdetail.trantim    ","
        wdetail.poltyp     ","
        wdetail.policy     ","
        wdetail.renpol     ","
        wdetail.comdat     ","
        wdetail.expdat     "," 
        wdetail.compul     ","
        wdetail.tiname     ","
        wdetail.insnam     ","
        wdetail.iadd1      "," 
        wdetail.iadd2      ","
        wdetail.iadd3      ","
        wdetail.iadd4      ","
        wdetail.prempa     ","  
        wdetail.subclass   "," 
        wdetail.brand      ","  
        wdetail.model      ","  
        wdetail.cc         ","  
        wdetail.weight     ","  
        wdetail.seat       ","  
        wdetail.body       ","  
        wdetail.vehreg     ","        
        wdetail.engno      ","  
        wdetail.chasno     "," 
        wdetail.caryear    ","               
        wdetail.carprovi   ","               
        wdetail.vehuse     ","               
        wdetail.garage     ","               
        wdetail.stk        ","               
        wdetail.access     "," 
        wdetail.covcod     "," 
        wdetail.si         "," 
        wdetail.volprem    "," 
        wdetail.Compprem   "," 
        /*wdetail.fleet      "," 
        wdetail.ncb        "," 
        wdetail.loadclm    "," 
        wdetail.deductda   "," 
        wdetail.deductpd   "," *//*A53-0111*/
        wdetail.benname    "," 
        wdetail.n_user     "," 
        wdetail.n_IMPORT  "," 
        wdetail.n_export  "," 
        wdetail.drivnam   "," 
        wdetail.drivnam1  "," 
        wdetail.drivnam2  "," 
        wdetail.drivbir1  "," 
        wdetail.drivbir2  "," 
        wdetail.drivage1  "," 
        wdetail.drivage2  "," 
        wdetail.cancel    ","
        wdetail.redbook   ","
        wdetail.base      ","
        wdetail.accdat    ","
        wdetail.docno     ","
        wdetail.comment   ","
        wdetail.WARNING
    SKIP.  
  END.                                                                                           
/*PUT STREAM ns2 "E". */                                                                           
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
"IMPORT TEXT FILE MOTOR ART (MOTOR LINE 70/72) " SKIP
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
"Batch No. : " fi_bchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_sicexp C-Win 
PROCEDURE Proc_sicexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR gv_id AS CHAR FORMAT "x(10)" .
DEFINE VAR nv_pwd AS CHAR FORMAT "x(15)".
/*create by kridtiya i. A53-0220*/
FORM
    gv_id  LABEL " User Id " COLON 20 SKIP
    nv_pwd LABEL " Password" COLON 20 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY WIDTH 50
    TITLE   " Connect DB Expiry System"  . 

/*HIDE ALL NO-PAUSE.*//*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
/*gv_prgid = "GWNEXP02".*/

REPEAT:
  PAUSE 0.
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
        CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*Real*/  
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*Real*/*//*Comment A62-0105*/
      /* CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*db test.*/  */
      /*--- A54-0317 ---*/
      IF NOT CONNECTED("sic_exp") THEN DO:
         MESSAGE "Not Connect DB Expiry ld sic_exp".
         NEXT-PROMPT gv_id WITH FRAME nf00.
         NEXT.
      END.
      /*--- A54-0317 ---*/
  END.

  CLEAR FRAME nf00.
  HIDE FRAME nf00.
  RETURN.

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
    nv_idnolist    = trim(wdetail.icno) .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = ""
    nv_txt2  = ""
    nv_txt3  = wdetail.text1
    nv_txt4  = wdetail.text2    
    nv_txt5  = ""                              
    nv_txt6  = ""
    nv_txt7  = "". 
DO WHILE nv_line1 <= 7:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
 NO-ERROR NO-WAIT.
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
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.

/*--- Add A55-0235 ---*/
IF wdetail.bandet = "กทม. รัชดา"           THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. บางนา"      THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. งามวงศ์วาน" THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. ธนบุรี"     THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE nv_opnpol = wdetail.opnpol.
/*--- End Add A55-0235 ---*/

ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = "" 
    nv_txt6  = ""
    nv_txt7  = ""
    nv_txt8  = ""
    nv_txt9  = ""
    nv_txt10  = ""
    nv_txt11  = ""

    nv_txt1  = ""
    nv_txt2  = "วันที่รับแจ้ง : " + wdetail.tltdat
    nv_txt3  = IF rapolicy = 1 THEN "ผู้แจ้ง" + " " + nv_opnpol + " " + "ตลาดสาขา" + " " + wdetail.bandet  
                               ELSE "ผู้แจ้ง" + " " + nv_opnpol 
    nv_txt4  = "เลขที่รับแจ้ง : " + substr(wdetail.Text1,1,16)  
    nv_txt5  = "เลขแคมเปญ : "  + TRIM(wdetail.camp)
    nv_txt6  = "เลขที่ตรวจสภาพ : " + TRIM(wdetail.ispno) 
    nv_txt7  = "ประเภทการจ่าย : "  + trim(wdetail.paidtyp)
    nv_txt8  = "วันที่ชำระเงิน : " + trim(wdetail.paiddat) 
    nv_txt9  = "วันที่ส่งไฟล์ชำระเงิน : " + TRIM(wdetail.confdat)  
    nv_txt10  = "หมายเหตุ : " + trim(wdetail.Text2) 
    nv_txt11  = "" .
    IF   wdetail.renpol <> "" THEN nv_txt5  = "เลขแคมเปญ : ".

/*---- Add A55-0235 ----*/
IF rapolicy = 1 THEN DO:
    IF SUBSTRING(wdetail.cedpol,6,1) = "U" 
    THEN DO:
        nv_txt5  = "คุ้มครองเฉพาะเคลมสดจนกว่าจะตรวจสภาพเรียบร้อย" + " " + wdetail.Text2.
    END.
    ELSE DO:
        /*nv_txt5  = "ทุนประกันภัยนี้ได้คุ้มครองอุปกรณ์เสริมไม่เกิน 30,000.- บาท".*/
        nv_txt5  = "ทุนประกันภัยนี้ได้คุ้มครองอุปกรณ์เสริมไม่เกิน 20,000.- บาท".
    END.
    IF nv_Camcode <> "" THEN DO: 
        nv_txt3 = nv_txt3 + " " + "Campaign No. : " + nv_Camcode.
    END.
END.
/*ELSE nv_txt5 = wdetail.Text2. /*A55-0235*/*/ /*A61-0512*/
/*ELSE nv_txt5 = "".*//*Comment A55-0235*/
/*---- END Add A55-0235 ---*/

/*DO WHILE nv_line1 <= 8:*/ /*A61-0512*/
DO WHILE nv_line1 <= 10: /*A61-0512*/
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
    IF nv_line1 = 9  THEN wuppertxt.txt = nv_txt9.    
    IF nv_line1 = 10  THEN wuppertxt.txt = nv_txt10.    
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.bptr    = nv_bptr
            sic_bran.uwd102.fptr    = 0
            sic_bran.uwd102.policy  = wdetail.policy
            sic_bran.uwd102.rencnt  = n_rencnt
            sic_bran.uwd102.endcnt  = n_endcnt
            sic_bran.uwd102.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
            wf_uwd102.fptr = RECID(uwd102).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102_bp C-Win 
PROCEDURE proc_uwd102_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.

/*--- Add A55-0235 ---*/
IF wdetail.bandet = "กทม. รัชดา"           THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. บางนา"      THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. งามวงศ์วาน" THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE IF wdetail.bandet = "กทม. ธนบุรี"     THEN nv_opnpol = SUBSTRING(wdetail.opnpol,2,LENGTH(wdetail.opnpol) - 1).
ELSE nv_opnpol = wdetail.opnpol.
/*--- End Add A55-0235 ---*/

ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = "" 
    nv_txt6  = ""
    nv_txt7  = ""
    nv_txt8  = ""
    nv_txt9  = ""
    /*---
    nv_txt2  = IF rapolicy = 1 THEN wdetail.opnpol + " " + wdetail.bandet + " " + wdetail.tltdat 
                               ELSE wdetail.opnpol + " " + wdetail.tltdat 
    nv_txt3  = IF wdetail.stk = " "  THEN "ไม่เอา พรบ." ELSE wdetail.stk  
    nv_txt4  = wdetail.attrate       
    nv_txt5  = IF SUBSTRING(wdetail.cedpol,6,1) = "U" AND wdetail.renpol = ""
               THEN "คุ้มครองเฉพาะเคลมสดจนกว่าจะตรวจสภาพเรียบร้อย" ELSE "" 
    ----*/
    /*--- Add A55-0235 เพิ่มผู้แจ้ง,ตลาดสาขา ----*/
    nv_txt2  = IF rapolicy = 1 THEN "ผู้แจ้ง" + " " + nv_opnpol + " " + "ตลาดสาขา" + " " + wdetail.bandet + " " + wdetail.tltdat 
                               ELSE "ผู้แจ้ง" + " " + nv_opnpol + " " + wdetail.tltdat 
    /*---End Add A55-0235 ---*/

    nv_txt3  = IF wdetail.stk = " "  THEN "ไม่เอา พรบ." ELSE wdetail.stk  
    nv_txt4  = wdetail.attrate  
    
    nv_txt6  = wdetail.Text1
    nv_txt7  = IF wdetail.icno <> "" THEN "ID : " + wdetail.icno ELSE ""
    nv_txt8  = IF rapolicy = 2 THEN wdetail.bandet ELSE "".

/*---- Add A55-0235 ----*/
IF rapolicy = 1 THEN DO:
    IF SUBSTRING(wdetail.cedpol,6,1) = "U" 
    THEN DO:
        nv_txt5  = "คุ้มครองเฉพาะเคลมสดจนกว่าจะตรวจสภาพเรียบร้อย" + " " + wdetail.Text2.
    END.
    ELSE DO:
        nv_txt5  = "ทุนประกันภัยนี้ได้คุ้มครองอุปกรณ์เสริมไม่เกิน 30,000.- บาท".
    END.
    IF nv_Camcode <> "" THEN DO: 
        nv_txt3 = nv_txt3 + " " + "Campaign No. : " + nv_Camcode.
    END.
END.
ELSE nv_txt5 = wdetail.Text2. /*A55-0235*/
/*ELSE nv_txt5 = "".*//*Comment A55-0235*/
/*---- END Add A55-0235 ---*/

DO WHILE nv_line1 <= 8:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.bptr    = nv_bptr
            sic_bran.uwd102.fptr    = 0
            sic_bran.uwd102.policy  = wdetail.policy
            sic_bran.uwd102.rencnt  = n_rencnt
            sic_bran.uwd102.endcnt  = n_endcnt
            sic_bran.uwd102.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
            wf_uwd102.fptr = RECID(uwd102).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd103 C-Win 
PROCEDURE proc_uwd103 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd103 FOR sic_bran.uwd103.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = "" 
    nv_txt6  = ""
    nv_txt1  = ""
    nv_txt2  = ""
    nv_txt3  = IF wdetail.renpol = "" THEN wdetail.Text2 ELSE "" 
    nv_txt4  = ""         
    nv_txt5  = ""                                       
    nv_txt6  = "" 
    nv_txt7  = "" . 

DO WHILE nv_line1 <= 7:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
 NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd103.
        ASSIGN
            sic_bran.uwd103.bptr    = nv_bptr
            sic_bran.uwd103.fptr    = 0
            sic_bran.uwd103.policy  = wdetail.policy
            sic_bran.uwd103.rencnt  = n_rencnt
            sic_bran.uwd103.endcnt  = n_endcnt
            sic_bran.uwd103.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd103 WHERE RECID(wf_uwd103) = nv_bptr.
            wf_uwd103.fptr = RECID(uwd103).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr04 = RECID(uwd103).
        nv_bptr = RECID(uwd103).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 C-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0138...
IF wdetail.Prem_t <> "" THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN
        /* create by A60-0545*/
        IF rapolicy = 1 THEN DO: /* ป้ายแดง */
            ASSIGN
            nv_gapprm  = deci(wdetail.Prem_t)
            nv_pdprm  = nv_gapprm .
        END.
        ELSE DO: /*ต่ออายุ */
        /* end A60-0545*/
            ASSIGN 
                nv_gapprm  = TRUNCATE(((deci(wdetail.Prem_t) * 100 ) / 107.43 ),0 ) 
                nv_pdprm  = nv_gapprm .
        END.
     ELSE  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
            ASSIGN nv_pdprm  = TRUNCATE(((deci(wdetail.Prem_t) * 100 ) / 107.43 ),0 ).
END.
...end A64-0138..*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN  
         sic_bran.uwm100.prem_t = nv_pdprm          /* A57-0426 *//*เบี้ย ไม่เต็มปี หรือ เกินปี */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
                        /* nv_camptyp =  "NORM"*/
      s_riskgp   =   0                           s_riskno       =  1
      s_itemno   =   1                           nv_undyr     =    STRING(YEAR(TODAY),"9999")   
      n_rencnt   =   0                           n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

