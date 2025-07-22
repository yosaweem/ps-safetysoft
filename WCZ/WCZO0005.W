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

/* Modify By Wantanee.S Date 26.09.2005 Add Line 04 (Poltyp = M04) A48-0469*/
/* Modify. By Chutikarn 6/6/2007  Change Server Lotus Notes <A50-0153>     */
/* Modify By   : Chutikarn.S 05/11/2007   [A50-0178]                    
               - ปรับ format branch เพื่อรองรับการขยายสาขา                 */  
/* Modify By : Watsana K.  Date.15/03/2010  [A530114]     
               เพิ่ม NO-ERROR ตรง XMM066                                   */
/* Modify By : Watsana K.  Date. 05/08/2010  [A530138]     
               Lock Reserve Limit ตาม Parameter xzm027.usrid               */
/* Modify By : Chaiyong W. A55-0293 13/09/2012                             */
/*             Add location of loss2                                       */
/* Modify By : Narin       A56-0028 18/01/2013                                  */
/*            เพิ่ม filed Comdate , Expiry date , Location , Allcate , % Share */
/* Modify By :  Narin L  A57-0012 22/04/2014                     */    
/*              Correct Path C:\ to C:\TEMP                      */
/* Modify By :  Chaiyong W.  A58-0117 16/05/2015                 */    
/*            Correct del xmm600.name3                           */
/*---------------------------------------------------------------*/ 
/* modify by : Chonlapeet CH.  [A61-0510]  Date 06/11/2018       */
/*           : ปรับแก้ไขขยาย format ช่อง  Ceding claim no.       */
/*             เป็น 20 ตัวอักษร                                  */
/*Modify By : Jiraphon P. A63-0272  Date: 12/06/2020             */
/*          : เปลี่ยนค่า Accept Date เก็บใน  clm100.repdat       */
/*Modify By : Montrikon S. [A66-0067] 17/05/2023                 */
/*            PA ขยาย Risk no and Item no. จาก 3 หลักเป็น 5 หลัก */
/*---------------------------------------------------------------*/ 
/*------------------------------------------------------------------------
 Modify by : Yosawee M.  ASSIGN : A68-0044  DATE : 11/06/2025
             - ADD FIELD [create date], [review date], [add program id]
 ---------------------------------------------------------------------------*/
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF VAR nv_txt    AS CHAR.
DEF VAR nv_txt1   AS CHAR.
DEF VAR nv_ltext1 AS CHAR.
DEF VAR gv_id     AS CHAR.
/*def var nv_rico_t  as char.*/
/* Local Variable Definitions ---                                       */
DEF NEW SHARED VAR nv_event   LIKE clm100.event.
DEF NEW SHARED VAR nv_recid2  AS   RECID          INIT 0.
DEF NEW SHARED VAR n_policy   LIKE uwm100.policy  NO-UNDO.
DEF NEW SHARED VAR nv_policy  AS   CHAR           FORMAT "X(16)".
DEF NEW SHARED VAR nv_rencnt  LIKE clm100.rencnt.
DEF NEW SHARED VAR nv_endcnt  LIKE clm100.endcnt.
DEF NEW SHARED VAR nv_riskgp  LIKE clm100.riskgp.
DEF NEW SHARED VAR nv_riskno  LIKE clm100.riskno.
DEF NEW SHARED VAR nv_itemno  LIKE clm100.itemno.
/*DEF NEW SHARED VAR nv_insref  LIKE clm100.insref.-- A50-0178 --*/
DEF NEW SHARED VAR nv_insref  LIKE clm100.insref FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_ntitle  LIKE clm100.ntitle.
DEF NEW SHARED VAR nv_name1   LIKE clm100.name1.
DEF NEW SHARED VAR nv_name    LIKE clm100.name1.
DEF NEW SHARED VAR nv_name2   LIKE clm100.name2.
DEF NEW SHARED VAR nv_name3   LIKE clm100.name3.
DEF NEW SHARED VAR nv_fname   LIKE clm100.fname.
DEF NEW SHARED VAR nv_addr1   LIKE clm100.addr1.
DEF NEW SHARED VAR nv_addr2   LIKE clm100.addr2.
DEF NEW SHARED VAR nv_addr3   LIKE clm100.addr3.
DEF NEW SHARED VAR nv_addr4   LIKE clm100.addr4.
DEF NEW SHARED VAR nv_comdat  AS   DATE  FORMAT "99/99/9999".
DEF NEW SHARED VAR nv_expdat  AS   DATE  FORMAT "99/99/9999".
DEF NEW SHARED var nv_class   LIKE clm100.class.
DEF            VAR nv_clsdes  AS   CHAR  FORMAT "X(50)".
DEF            VAR nv_itmtxt  AS   CHAR  FORMAT "X(4)".
DEF            VAR nv_txtdes  AS   CHAR  FORMAT "X(50)".
DEF NEW SHARED VAR nv_si      LIKE clm120.si.
/*---
DEF NEW SHARED VAR nv_notbrh  LIKE clm100.branch  FORMAT "X".
DEF            VAR nv_notbrh1 LIKE clm100.branch  FORMAT "X". -- A50-0178 ---*/
DEF NEW SHARED VAR nv_notbrh  LIKE clm100.branch  FORMAT "X(2)". /*-- A50-0178 --*/
DEF            VAR nv_notbrh1 LIKE clm100.branch  FORMAT "X(2)". /*-- A50-0178 --*/
DEF            VAR nv_ntbdes  AS   CHAR           FORMAT "X(15)".
DEF NEW SHARED VAR nv_losdat  LIKE clm100.losdat.
DEF NEW SHARED VAR nv_lostim  AS   CHAR   FORMAT "X(5)".
DEF NEW SHARED VAR nv_loshr   AS   INTE   FORMAT "99".
DEF NEW SHARED VAR nv_losmin  AS   INTE   FORMAT "99".
DEF NEW SHARED VAR nv_loclos  AS   CHAR   FORMAT "X(50)".
DEF NEW SHARED VAR nv_loss1   AS   CHAR   FORMAT "X(35)".
DEF NEW SHARED VAR nv_loss2   AS   CHAR   FORMAT "X(35)".
DEF NEW SHARED VAR nv_loss3   AS   CHAR   FORMAT "X(35)".
DEF NEW SHARED VAR nv_estim   AS   DEC    FORMAT ">>>,>>>,>>9.99".
DEF NEW SHARED VAR nv_cntact  AS   CHAR   FORMAT "X(58)".
DEF NEW SHARED VAR nv_ctel    AS   CHAR   FORMAT "X(15)".
DEF NEW SHARED VAR nv_default AS   CHAR   FORMAT "X(2)".
DEF NEW SHARED var nv_defdes  AS   CHAR   FORMAT "X(20)".
DEF NEW SHARED VAR nv_appoint AS   CHAR   FORMAT "X(50)".
DEF NEW SHARED VAR nv_notby   AS   CHAR   FORMAT "X(37)".
DEF NEW SHARED VAR nv_telphn  AS   CHAR   FORMAT "X(15)".
DEF NEW SHARED VAR nv_condit  AS   CHAR   FORMAT "X(1)".
DEF NEW SHARED VAR nv_condes  AS   CHAR   FORMAT "X(11)".
DEF NEW SHARED VAR nv_accdte  AS   DATE   FORMAT "99/99/9999".
DEF NEW SHARED VAR nv_acctim  AS   CHAR   FORMAT "X(5)".
DEF NEW SHARED VAR nv_acchr   AS   INTE   FORMAT "99".
DEF NEW SHARED VAR nv_accmin  AS   INTE   FORMAT "99".
/*DEF NEW SHARED VAR nv_accby   AS   CHAR   FORMAT "X(5)".-- A50-0178 --*/
DEF NEW SHARED VAR nv_accby   AS   CHAR   FORMAT "X(10)". /*--A50-0178 --*/
DEF NEW SHARED VAR nv_accnam  AS   CHAR   FORMAT "X(25)".
DEF NEW SHARED VAR nv_notdat  LIKE clm100.notdat.
DEF NEW SHARED VAR nv_nottim  LIKE clm100.nottim.
/*DEF NEW SHARED VAR nv_userid  AS   CHAR   FORMAT "X(6)".-- A50-0178 --*/
/*DEF NEW SHARED VAR nv_survy   AS   CHAR   FORMAT "X(5)".-- A50-0178 --*/
DEF NEW SHARED VAR nv_userid  AS   CHAR   FORMAT "X(7)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_survy   AS   CHAR   FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_surdef  AS   CHAR   FORMAT "X(40)".
DEF NEW SHARED VAR nv_surdt   AS   DATE   FORMAT "99/99/9999".
DEF NEW SHARED VAR nv_surmin  AS   INT    FORMAT "99"  INITIAL "0".
DEF NEW SHARED VAR nv_surhr   AS   INT    FORMAT "99"  INITIAL "0".
DEF NEW SHARED VAR nv_surynam AS   CHAR   FORMAT "X(25)".
DEF NEW SHARED VAR nv_undyr   LIKE clm100.undyr.
/*DEF NEW SHARED VAR nv_acno1   LIKE clm100.acno1.-- A50-0178 --*/
/*DEF NEW SHARED VAR nv_agent   LIKE clm100.agent.-- A50-0178 --*/
DEF NEW SHARED VAR nv_acno1   LIKE clm100.acno1 FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_agent   LIKE clm100.agent FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_cntry   LIKE clm100.cntry.        
DEF NEW SHARED VAR nv_dir_ri  LIKE clm100.dir_ri.
DEF NEW SHARED VAR nv_dept    LIKE clm100.dept.
DEF NEW SHARED VAR nv_postcd  LIKE clm100.postcd.
DEF NEW SHARED VAR nv_co_per  LIKE clm100.co_per.
DEF NEW SHARED VAR nv_coins   LIKE clm100.coins.
DEF NEW SHARED VAR nv_cn_no   LIKE clm100.cn_no.
DEF NEW SHARED VAR nv_billco  LIKE clm100.billco.
DEF NEW SHARED VAR nv_vehves  LIKE clm100.vehves.
DEF NEW SHARED VAR nv_vesno   LIKE clm100.vesno.
DEF new SHARED VAR nv_opnpol  LIKE clm100.opnpol.
DEF NEW SHARED VAR nv_distct  LIKE clm100.distct.
DEF NEW SHARED VAR nv_occlim  LIKE clm100.occlim.
DEF NEW SHARED VAR nv_pcrisk  LIKE clm100.pcrisk.
DEF NEW SHARED VAR nv_icno    LIKE clm100.icno.
DEF NEW SHARED VAR nv_polonf  AS   CHAR   FORMAT "X".
DEF NEW SHARED VAR nv_sicurr  LIKE clm100.sicurr.
DEF NEW SHARED VAR nv_langug  LIKE uwm100.langug.
DEF NEW SHARED VAR nv_polsta  LIKE uwm100.polsta.
DEF NEW SHARED VAR nv_poltyp  LIKE clm100.poltyp.
DEF NEW SHARED VAR nv_cedco   LIKE clm100.cedco.
DEF NEW SHARED VAR nv_cedpol  LIKE clm100.cedpol.
DEF NEW SHARED VAR nv_cedces  LIKE clm100.cedces.
DEF NEW SHARED VAR nv_recip   LIKE clm100.recip.
DEF NEW SHARED VAR nv_styp20  LIKE clm100.styp20.
DEF NEW SHARED VAR nv_sval20  LIKE clm100.sval20.
/*DEF NEW SHARED VAR nv_finint  LIKE clm100.finint.-- A50-0178 --*/
DEF NEW SHARED VAR nv_finint  LIKE clm100.finint FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_prloss  LIKE clm100.prloss.
DEF NEW SHARED VAR nv_oldic   LIKE clm100.oldic.
DEF NEW SHARED VAR nv_nature  LIKE clm120.loss.

/* sombat 07/06/2003 <A46-0220> */
/*DEF NEW SHARED VAR nv_police   AS CHAR FORMAT "X(7)".-- A50-0178 --*/
DEF NEW SHARED VAR nv_police   AS CHAR FORMAT "X(10)". /*-- A50-0178 --*/
DEF NEW SHARED VAR nv_poldes   AS CHAR FORMAT "X(20)".
/* END sombat 07/06/2003 <A46-0220> */

/* sombat 10/01/2003 */
DEF NEW SHARED VAR nv_append   AS CHAR FORMAT "X(15)". /*uwm100.cr_2 APPEND POL*/
DEF NEW SHARED VAR nv_cedclm   LIKE clm100.cedclm  FORMAT "X(20)" .  /* chonlapeet A61-0510 เพิ่ม format "X(20)" */
/* --------------------------------------------------------------- */

DEF  VAR nv_natdes   AS   CHAR FORMAT "X(19)".
DEF  VAR nv_chkkey   AS   LOGI.
DEF  VAR nv_nextno   AS   INTE.
DEF  VAR nv_notify   LIKE clm100.event.
DEF  VAR nv_recid    AS   RECID.
DEF  VAR n_cnt       AS   INT.
DEF  VAR n_s         AS   CHAR FORMAT "X(100)".
DEF  VAR nv_chk2_f1  AS   LOGI.

DEF  VAR nv_type1    AS   CHAR  FORMAT "X(2)"  EXTENT 6 init
 ["IN","TP","BO","NO","UN","UI"].
DEF  VAR nv_des1     AS   CHAR  FORMAT "X(20)" EXTENT 6 init
 ["Insured","Third Party","Both","None","Unknown","Under Investigation"].
DEF  VAR nv_chk      AS   LOGICAL        INITIAL NO.

/*------------ A46-0221 ------------*/
DEF VAR nv_event1   LIKE clm100.event.
DEF VAR nv_opts     AS CHAR FORMAT "X(24)" EXTENT 3 INITIAL
                       [" Exit                    ",
                        " คีย์เบอร์ Notify        ",
                        " Running Auto Notify no. "].

DEF VAR nv_choice   AS  LOGICAL.
DEF VAR nv_continue AS  LOGICAL.
DEF VAR nv_select   AS DEC.

DEF VAR nv_ltext2   AS CHAR FORMAT "X(78)".
DEF VAR nv_ltext3   AS CHAR FORMAT "X(78)".

DEFINE VAR nv_curr  AS RECID.
DEFINE VAR nv_prev  AS RECID.
DEFINE VAR nv_next  AS RECID.

DEFINE VAR nv_first AS RECID.
DEFINE VAR nv_last  AS RECID.

/*------add by jeab 27/08/03--------------*/
DEF NEW SHARED VAR nv_rico_t  AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED WORKFILE  w_rico NO-UNDO
    FIELD  riskno AS INT  FORMAT "99999" /* "99" Montrikon S. [A66-0067] */
    /*--Comment by Narin A56-0028
    FIELD  rico   AS CHAR FORMAT "X(7)" --*/

    FIELD  rico   AS CHAR FORMAT "X(10)"  /*-Add A56-0028-*/
    FIELD  risi   LIKE uwd200.risi
    FIELD  risi_p LIKE uwd200.risi_p

  /*--     Add Narin Assign A56-0028 --*/          
   
    FIELD  wt_perstat  LIKE uwd200.risi_p
    FIELD  wt_perret   LIKE uwd200.risi_p
    FIELD  wt_per0q    LIKE uwd200.risi_p
    FIELD  wt_per0t    LIKE uwd200.risi_p
    FIELD  wt_per0s    LIKE uwd200.risi_p
    FIELD  wt_perf1    LIKE uwd200.risi_p
    FIELD  wt_perf2    LIKE uwd200.risi_p
    FIELD  wt_per0rq   LIKE uwd200.risi_p
    FIELD  wt_per0ps   LIKE uwd200.risi_p
    FIELD  wt_perbtr   LIKE uwd200.risi_p
    FIELD  wt_per0tr   LIKE uwd200.risi_p
    FIELD  wt_pers8    LIKE uwd200.risi_p
    FIELD  wt_perf4    LIKE uwd200.risi_p
    FIELD  wt_perftr   LIKE uwd200.risi_p
    FIELD  wt_perrb    LIKE uwd200.risi_p
    FIELD  wt_perrf    LIKE uwd200.risi_p.

DEF NEW SHARED VAR nv_siper    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perstat  AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perret   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0q    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0t    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0s    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perf1    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perf2    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0rq   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0ps   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perbtr   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_per0tr   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_pers8    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perf4    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perftr   AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perrb    AS DECI  FORMAT ">>9.99"  INIT 0.
DEF NEW SHARED VAR nv_perrf    AS DECI  FORMAT ">>9.99"  INIT 0.
   /*-- End Add Narin Assign A56-0028 --*/ 

DEF VAR nv_rskno LIKE uwm120.riskno.
Def Var nv_ans   As Log Init "NO".

/*********** print ****************************/
DEF STREAM nf1.

DEF VAR n_insname  AS CHAR FORMAT "X(50)".
DEF VAR nv_recid1  AS RECID .
DEF VAR n_text     AS CHAR FORMAT "X(50)"  INITIAL " ".
DEF VAR nv_polno   AS CHAR FORMAT "X(16)".
DEF VAR n_count    AS INT                  INITIAL 1.
DEF VAR n_point    AS INT.
DEF VAR n_point2   AS INT.

DEF VAR n_ltext1   AS CHAR FORMAT "X(78)".
DEF VAR n_ltext2   AS CHAR FORMAT "X(78)".
DEF VAR n_ltext3   AS CHAR FORMAT "X(78)".

DEF VAR n_contact  AS CHAR FORMAT "X(50)".
DEF VAR n_contel   AS CHAR FORMAT "X(50)".
DEF VAR n_survay   AS CHAR FORMAT "X(50)".
DEF VAR n_surdat   AS CHAR FORMAT "X(10)".
DEF VAR n_surtim   AS CHAR FORMAT "X(5)".
DEF VAR nv_out     AS CHAR FORMAT "X(10)".
def var nv_output  as  char  init  "".
def var nv_output2 as  char  init  "".

DEF SHARED VAR n_user    AS CHAR.
DEF SHARED VAR n_passwd  AS CHAR.

/*------------ A47-0147 ------------*/
DEF VAR s_policy    AS CHAR.
DEF VAR n_polchk    AS LOGIC.
DEF VAR nv_producer As Char.
DEF VAR nv_produnam As Char.
DEF VAR nv_dattim   As Char.
/* -------------------------------------------------------------------------- */

/*-----------------------Lotus Notes------------------------------*/
DEF VAR chNotesSession  As Com-Handle.
DEF VAR chNotesDataBase As Com-Handle.
DEF VAR chNotesView     As Com-Handle .
DEF VAR chNavView       As Com-Handle .
DEF VAR chDocument      As Com-Handle .

DEF VAR nv_server   As Char.
DEF VAR nv_tmp      As Char .
DEF VAR nv_lbranch  As Char.
DEF VAR nvw_ltext   As Character    No-Undo. /*เพื่อเก็บค่า Claim Memo text ส่งไป Lotus Notes */

DEF BUFFER buwm100 FOR uwm100. /*-- A50-0178 --*/

DEF VAR nv_res LIKE clm131.res .  /* Add Watsana K. [A530138] */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_cl

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_notbrh fi_ntbdes fi_losdat fi_loshr ~
fi_losmin fi_userid fi_loclos fi_loclos2 fi_loss1 fi_loss2 fi_loss3 ~
fi_cedclm fi_police fi_poldes fi_nature fi_natdes fi_estim fi_cntact ~
fi_ctel fi_default fi_defdes fi_notby fi_telphn fi_accdte fi_acchr ~
fi_accmin fi_accby fi_accnam fi_survy fi_surynam fi_surdt fi_surhr ~
fi_surmin fi_event fi_notdat fi_nottim bu_save bu_exit bu_new bu_print ~
bu_police bu_default bu_accby bu_survy RECT-3 RECT-4 
&Scoped-Define DISPLAYED-OBJECTS fi_policy fi_rencnt fi_endcnt fi_riskno ~
fi_itemno fi_insref fi_ntitle fi_name1 fi_comdat fi_expdat fi_append ~
fi_class fi_clsdes fi_itmtxt fi_txtdes fi_si fi_notbrh fi_ntbdes fi_losdat ~
fi_loshr fi_losmin fi_userid fi_loclos fi_loclos2 fi_loss1 fi_loss2 ~
fi_loss3 fi_cedclm fi_police fi_poldes fi_nature fi_natdes fi_estim ~
fi_cntact fi_ctel fi_default fi_defdes fi_notby fi_telphn fi_accdte ~
fi_acchr fi_accmin fi_accby fi_accnam fi_survy fi_surynam fi_surdt fi_surhr ~
fi_surmin fi_event fi_notdat fi_nottim fi_display fi_poli 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_acc 
     LABEL "ACC" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_accby 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3 BY 1.

DEFINE BUTTON bu_default 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3 BY 1.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_mem 
     LABEL "MEM" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_new 
     LABEL "NEW" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_pgdn 
     LABEL "Pol." 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_police 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3 BY 1.

DEFINE BUTTON bu_policy 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3 BY 1.

DEFINE BUTTON bu_print 
     LABEL "PRINT" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_Query 
     LABEL "PgDn" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_ri 
     LABEL "RI" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_rk 
     LABEL "RK+" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "SAVE" 
     SIZE 9 BY 1.14
     FONT 6.

DEFINE BUTTON bu_survy 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3 BY 1.

DEFINE VARIABLE fi_accby AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_accdte AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acchr AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_accmin AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_accnam AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_append AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 32.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cedclm AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_clsdes AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 89.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cntact AS CHARACTER FORMAT "X(58)":U 
     VIEW-AS FILL-IN 
     SIZE 102.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ctel AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_default AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_defdes AS CHARACTER FORMAT "x(20)":U 
     VIEW-AS FILL-IN 
     SIZE 34.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_display AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_endcnt AS INTEGER FORMAT "999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     FGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_estim AS DECIMAL FORMAT "->>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_event AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insref AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_itemno AS INTEGER FORMAT "99999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     FGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_itmtxt AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loclos AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loclos2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 33.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_losdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loshr AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_losmin AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loss1 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loss2 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loss3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 59.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_natdes AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_nature AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notbrh AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notby AS CHARACTER FORMAT "X(37)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ntbdes AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 29.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ntitle AS CHARACTER FORMAT "X(11)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poldes AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poli AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_police AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_rencnt AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1
     FGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_riskno AS INTEGER FORMAT "99999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     FGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_si AS DECIMAL FORMAT ">,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_surdt AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_surhr AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_surmin AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_survy AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_surynam AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_telphn AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_txtdes AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 89.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(7)":U 
      VIEW-AS TEXT 
     SIZE 11 BY .71
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 127.5 BY 1.57
     BGCOLOR 62 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 127.5 BY 19.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_cl
     fi_policy AT ROW 3.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_rencnt AT ROW 3.14 COL 67 COLON-ALIGNED NO-LABEL
     fi_endcnt AT ROW 3.14 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_riskno AT ROW 3.14 COL 96 COLON-ALIGNED NO-LABEL
     fi_itemno AT ROW 3.14 COL 104.33 COLON-ALIGNED NO-LABEL
     fi_insref AT ROW 4.19 COL 24 COLON-ALIGNED NO-LABEL
     fi_ntitle AT ROW 4.19 COL 39.67 COLON-ALIGNED NO-LABEL
     fi_name1 AT ROW 4.19 COL 56.67 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 5.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 5.24 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_append AT ROW 5.24 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 6.29 COL 24 COLON-ALIGNED NO-LABEL
     fi_clsdes AT ROW 6.29 COL 37.5 COLON-ALIGNED NO-LABEL
     fi_itmtxt AT ROW 7.33 COL 24 COLON-ALIGNED NO-LABEL
     fi_txtdes AT ROW 7.33 COL 37.5 COLON-ALIGNED NO-LABEL
     fi_si AT ROW 8.38 COL 24 COLON-ALIGNED NO-LABEL
     fi_notbrh AT ROW 9.43 COL 24 COLON-ALIGNED NO-LABEL
     fi_ntbdes AT ROW 9.43 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_losdat AT ROW 9.43 COL 72.5 COLON-ALIGNED NO-LABEL
     fi_loshr AT ROW 9.43 COL 117 COLON-ALIGNED NO-LABEL
     fi_losmin AT ROW 9.43 COL 127.5 RIGHT-ALIGNED NO-LABEL
     fi_userid AT ROW 11.62 COL 128.5 RIGHT-ALIGNED NO-LABEL
     fi_loclos AT ROW 10.48 COL 24 COLON-ALIGNED NO-LABEL
     fi_loclos2 AT ROW 10.48 COL 93.17 COLON-ALIGNED NO-LABEL
     fi_loss1 AT ROW 11.52 COL 24 COLON-ALIGNED NO-LABEL
     fi_loss2 AT ROW 12.57 COL 24 COLON-ALIGNED NO-LABEL
     fi_loss3 AT ROW 12.57 COL 82 COLON-ALIGNED NO-LABEL
     fi_cedclm AT ROW 13.62 COL 24 COLON-ALIGNED NO-LABEL
     fi_police AT ROW 13.62 COL 69.5 COLON-ALIGNED NO-LABEL
     fi_poldes AT ROW 13.62 COL 88.5 COLON-ALIGNED NO-LABEL
     fi_nature AT ROW 14.67 COL 24 COLON-ALIGNED NO-LABEL
     fi_natdes AT ROW 14.67 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_estim AT ROW 14.67 COL 88.67 COLON-ALIGNED NO-LABEL
     fi_cntact AT ROW 15.71 COL 24 COLON-ALIGNED NO-LABEL
     fi_ctel AT ROW 16.76 COL 24 COLON-ALIGNED NO-LABEL
     fi_default AT ROW 16.76 COL 83 COLON-ALIGNED NO-LABEL
     fi_defdes AT ROW 16.76 COL 91.67 COLON-ALIGNED NO-LABEL
     fi_notby AT ROW 17.81 COL 24 COLON-ALIGNED NO-LABEL
     fi_telphn AT ROW 17.81 COL 101.33 COLON-ALIGNED NO-LABEL
     fi_accdte AT ROW 18.86 COL 24 COLON-ALIGNED NO-LABEL
     fi_acchr AT ROW 18.86 COL 39.5 COLON-ALIGNED NO-LABEL
     fi_accmin AT ROW 18.86 COL 46 COLON-ALIGNED NO-LABEL
     fi_accby AT ROW 18.86 COL 69 COLON-ALIGNED NO-LABEL
     fi_accnam AT ROW 18.86 COL 88 COLON-ALIGNED NO-LABEL
     fi_survy AT ROW 19.91 COL 24 COLON-ALIGNED NO-LABEL
     fi_surynam AT ROW 19.91 COL 43 COLON-ALIGNED NO-LABEL
     fi_surdt AT ROW 19.91 COL 101.5 COLON-ALIGNED NO-LABEL
     fi_surhr AT ROW 19.91 COL 116.83 COLON-ALIGNED NO-LABEL
     fi_surmin AT ROW 19.91 COL 127.33 RIGHT-ALIGNED NO-LABEL
     fi_event AT ROW 20.95 COL 24 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 20.95 COL 69.17 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 20.95 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_display AT ROW 22.24 COL 1.17 COLON-ALIGNED NO-LABEL
     fi_poli AT ROW 23.48 COL 109.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 23.48 COL 10
     bu_exit AT ROW 23.48 COL 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 24
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_cl
     bu_new AT ROW 23.48 COL 30
     bu_print AT ROW 23.48 COL 40
     bu_rk AT ROW 23.48 COL 50
     bu_ri AT ROW 23.48 COL 60
     bu_mem AT ROW 23.48 COL 70
     bu_acc AT ROW 23.48 COL 80
     bu_pgdn AT ROW 23.48 COL 90
     bu_Query AT ROW 23.48 COL 100.5
     bu_policy AT ROW 3.14 COL 47.5
     bu_police AT ROW 13.62 COL 87.33
     bu_default AT ROW 16.76 COL 90.5
     bu_accby AT ROW 18.86 COL 86.83
     bu_survy AT ROW 19.91 COL 41.67
     "*Default By  :" VIEW-AS TEXT
          SIZE 13.17 BY .76 AT ROW 16.81 COL 71.5
          FGCOLOR 6 FONT 6
     "Append Pol  :" VIEW-AS TEXT
          SIZE 14 BY .76 AT ROW 5.33 COL 71.5
          FONT 6
     ":" VIEW-AS TEXT
          SIZE 1.5 BY .52 AT ROW 18.91 COL 46.5
          FONT 6
     "Baht" VIEW-AS TEXT
          SIZE 5.5 BY .76 AT ROW 8.48 COL 52
          FONT 6
     "Insured Name  :" VIEW-AS TEXT
          SIZE 15.5 BY .76 AT ROW 4.29 COL 9.5
          FONT 6
     "Item Text  :" VIEW-AS TEXT
          SIZE 11.33 BY .76 AT ROW 7.38 COL 13.67
          FONT 6
     "Notify No.  :" VIEW-AS TEXT
          SIZE 12 BY .76 AT ROW 21 COL 12.5
          FONT 6
     "*Surveyor Ref  :" VIEW-AS TEXT
          SIZE 16.33 BY .76 AT ROW 19.91 COL 9
          FGCOLOR 6 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5 BY .76 AT ROW 5.33 COL 44.5
          FONT 6
     "2  :" VIEW-AS TEXT
          SIZE 3.67 BY .76 AT ROW 12.57 COL 21.33
          FGCOLOR 6 FONT 6
     "Estimate Loss  :" VIEW-AS TEXT
          SIZE 15.33 BY .76 AT ROW 14.71 COL 74.67
          FONT 6
     "/" VIEW-AS TEXT
          SIZE 1 BY .76 AT ROW 3.29 COL 105
          BGCOLOR 19 FONT 6
     "  NEW CLAIM NON MOTOR ENTRY - NOTIFY INFORMATION (NOT ON FILE)" VIEW-AS TEXT
          SIZE 125.17 BY 1.05 AT ROW 1.52 COL 4.17
          BGCOLOR 1 FGCOLOR 15 FONT 2
     "Ren / End  :" VIEW-AS TEXT
          SIZE 12.33 BY .76 AT ROW 3.29 COL 56
          BGCOLOR 19 FONT 6
     "*Report Date  :" VIEW-AS TEXT
          SIZE 15 BY .76 AT ROW 18.86 COL 9.83
          FGCOLOR 6 FONT 6
     "Notify Date :" VIEW-AS TEXT
          SIZE 12.33 BY .76 AT ROW 21.05 COL 58
          FONT 6
     "/" VIEW-AS TEXT
          SIZE 1.17 BY .76 AT ROW 3.29 COL 72.5
          BGCOLOR 19 FONT 6
     "Baht" VIEW-AS TEXT
          SIZE 6 BY .76 AT ROW 14.71 COL 115.17
          FONT 6
     ":" VIEW-AS TEXT
          SIZE 1 BY .62 AT ROW 19.95 COL 123.33
          FONT 6
     "Loss Time  :" VIEW-AS TEXT
          SIZE 12 BY .76 AT ROW 9.43 COL 106.33
          FONT 6
     ":" VIEW-AS TEXT
          SIZE 1 BY .62 AT ROW 9.48 COL 123.5
          FONT 6
     "*Date  :" VIEW-AS TEXT
          SIZE 7.83 BY .76 AT ROW 19.91 COL 95
          FGCOLOR 6 FONT 6
     "Class  :" VIEW-AS TEXT
          SIZE 7.5 BY .76 AT ROW 6.33 COL 17.5
          FONT 6
     "Gross SI. :" VIEW-AS TEXT
          SIZE 10.5 BY .76 AT ROW 8.48 COL 14.5
          FONT 6
     "*Tel.  :" VIEW-AS TEXT
          SIZE 7.5 BY .76 AT ROW 16.76 COL 17.67
          FGCOLOR 6 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 24
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_cl
     "Police  :" VIEW-AS TEXT
          SIZE 8.33 BY .76 AT ROW 13.62 COL 62.67
          FONT 6
     "*Location Adviced  :" VIEW-AS TEXT
          SIZE 20.17 BY .76 AT ROW 9.43 COL 5.17
          FGCOLOR 6 FONT 6
     "3  :" VIEW-AS TEXT
          SIZE 3.5 BY .76 AT ROW 12.62 COL 79.5
          FGCOLOR 6 FONT 6
     "Risk / Item  :" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 3.29 COL 84.5
          BGCOLOR 19 FONT 6
     "*Notify By  :" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 17.81 COL 12.83
          FGCOLOR 6 FONT 6
     "*Tel.  :" VIEW-AS TEXT
          SIZE 7 BY .76 AT ROW 17.81 COL 95.33
          FGCOLOR 6 FONT 6
     "*Nature of Loss  :" VIEW-AS TEXT
          SIZE 17.83 BY .76 AT ROW 14.71 COL 7.5
          FGCOLOR 6 FONT 6
     "*Location's Loss  :" VIEW-AS TEXT
          SIZE 19 BY .76 AT ROW 10.48 COL 6.83
          FGCOLOR 6 FONT 6
     "*Accept By  :" VIEW-AS TEXT
          SIZE 13.5 BY .76 AT ROW 18.86 COL 57.5
          FGCOLOR 6 FONT 6
     "User Id  :" VIEW-AS TEXT
          SIZE 9.33 BY .76 AT ROW 11.62 COL 109
          FONT 6
     "*Contact Person  :" VIEW-AS TEXT
          SIZE 18.5 BY .76 AT ROW 15.76 COL 6.83
          FGCOLOR 6 FONT 6
     "Policy No.  :" VIEW-AS TEXT
          SIZE 12.17 BY .76 AT ROW 3.29 COL 12.83
          BGCOLOR 19 FONT 6
     "*Loss Date  :" VIEW-AS TEXT
          SIZE 13 BY .76 AT ROW 9.43 COL 61
          FGCOLOR 6 FONT 6
     "Ceding Claim no.  :" VIEW-AS TEXT
          SIZE 18.5 BY .76 AT ROW 13.62 COL 6.5
          FONT 6
     "Period  :" VIEW-AS TEXT
          SIZE 8.5 BY .76 AT ROW 5.33 COL 16.5
          FONT 6
     "*Cause Of Loss 1  :" VIEW-AS TEXT
          SIZE 19 BY .76 AT ROW 11.52 COL 6
          FGCOLOR 6 FONT 6
     RECT-3 AT ROW 1.24 COL 3.17
     RECT-4 AT ROW 2.91 COL 3.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 24
         BGCOLOR 19 .


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
         TITLE              = ""
         HEIGHT             = 23.91
         WIDTH              = 132.83
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
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
/* SETTINGS FOR FRAME fr_cl
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR BUTTON bu_acc IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_mem IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_pgdn IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_policy IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_Query IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_ri IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bu_rk IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_append IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_class IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_clsdes IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_comdat IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_display IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_endcnt IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_expdat IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insref IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_itemno IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_itmtxt IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_losmin IN FRAME fr_cl
   ALIGN-R                                                              */
/* SETTINGS FOR FILL-IN fi_name1 IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ntitle IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_poli IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policy IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rencnt IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_riskno IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_si IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_surmin IN FRAME fr_cl
   ALIGN-R                                                              */
/* SETTINGS FOR FILL-IN fi_txtdes IN FRAME fr_cl
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_cl
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fr_cl
/* Query rebuild information for FRAME fr_cl
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME fr_cl */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acc C-Win
ON CHOOSE OF bu_acc IN FRAME fr_cl /* ACC */
DO:
      fi_poli = " ".
      fi_poli:FGCOLOR IN FRAME fr_cl = 19.
      fi_poli:BGCOLOR IN FRAME fr_cl = 19.       
      DISPLAY  fi_poli With Frame fr_cl.           

     {&WINDOW-NAME}:Hidden = Yes.
     RUN Wuw\Wuwqac01(Input fi_policy).
     {&WINDOW-NAME}:Hidden = No.
     
     FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR.
     IF AVAIL clm100 THEN DO:
            IF nv_polonf = "Y" THEN DO:
                   IF clm100.fptr01 <> 0 THEN DO:
                          fi_poli = "Policy Mtext".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                   END.
                   ELSE DO:
                          fi_poli = "Policy".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                   END.
            END.
            ELSE DO:
                    IF clm100.fptr01 <> 0 THEN DO:
                          fi_poli = "No Policy Mtext".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                    END.
                    ELSE DO:
                          fi_poli = "No Policy".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                    END.
              END.
              NEXT.
     END.
     ELSE NEXT.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_accby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_accby C-Win
ON CHOOSE OF bu_accby IN FRAME fr_cl
DO:
      Def   Var   n_acno  As Char.
      Def   Var   n_name  As Char.
      Def   Var   nv_type  As Char.

      /*--- Add Chutikarn A50-0178 -----*/
      /*nv_type = "0J".*/
      nv_type = INPUT fi_notbrh + "J".
      /*--- End Chutikarn A50-0178 -----*/
     
      Run Whp\Whpclno1 (Input nv_type, Output n_acno , Output n_name). 
      
      fi_accby    =  n_acno.
      fi_accnam  =  n_name.

  Disp fi_accby  fi_accnam with  frame  fr_cl.
 
  Apply  "Entry" to fi_accby.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_default
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_default C-Win
ON CHOOSE OF bu_default IN FRAME fr_cl
DO:
    Run   whp\whpdefau( Input-output  fi_default, 
                                         Input-Output fi_defdes).  

  Disp fi_default  fi_defdes with  frame  fr_cl.
 
  Apply  "Entry" to fi_default.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_cl /* EXIT */
DO:
 fi_policy = "" .
 Apply "Close" To This-Procedure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mem C-Win
ON CHOOSE OF bu_mem IN FRAME fr_cl /* MEM */
DO:
    IF nv_recid2 = 0 THEN DO:
        MESSAGE "Please Run Notify No. Before Key Text" View-As Alert-Box Warning.
        APPLY "ENTRY" TO fi_policy.
        RETURN NO-APPLY.
     END.
     
     nv_notify = fi_event.
     
     {&WINDOW-NAME}:Hidden = Yes. 
     RUN Wcz/Wczmtxt1(INPUT nv_recid2,nv_notify).
    {&WINDOW-NAME}:Hidden = No. 

     FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR.
     IF AVAIL clm100 THEN DO:
           IF nv_polonf = "Y" THEN DO:
                   IF clm100.fptr01 <> 0 THEN DO:
                          fi_poli = "Policy Mtext".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                    END.
                    ELSE DO:
                          fi_poli = "Policy".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                    END.
          END.
          ELSE DO:
                 IF clm100.fptr01 <> 0 THEN PUT SCREEN COLOR WHITE/MA
                          "No Policy  Mtext" ROW 23 COL 60.
                 ELSE DO:
                          fi_poli = "No Policy".
                          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                          DISPLAY  fi_poli With Frame fr_cl.           
                 END.
           END.
           NEXT.
     END.
     ELSE DO:
       NEXT.
     END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_new
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_new C-Win
ON CHOOSE OF bu_new IN FRAME fr_cl /* NEW */
DO:
     RUN ProClear.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_pgdn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_pgdn C-Win
ON CHOOSE OF bu_pgdn IN FRAME fr_cl /* Pol. */
DO:
     {&WINDOW-NAME}:Hidden = Yes.
     Run Wuw\wuwqmenu.
     {&WINDOW-NAME}:Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_police
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_police C-Win
ON CHOOSE OF bu_police IN FRAME fr_cl
DO:
      Def   Var   n_acno  As Char.
      Def   Var   n_name  As Char.
      Def   Var   nv_type  As Char.
      
      /*--- Add Chutikarn A50-0178 -----*/
      /*nv_type = "0B".*/
      nv_type = INPUT fi_notbrh + "B".
      /*--- End Chutikarn A50-0178 -----*/
      
      Run Whp\Whpclno1 (Input nv_type, Output n_acno , Output n_name).
      
      fi_police    =  n_acno.
      fi_poldes  =  n_name.

  Disp fi_police  fi_poldes with  frame  fr_cl.
 
  Apply  "Entry" to fi_police.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_policy C-Win
ON CHOOSE OF bu_policy IN FRAME fr_cl
DO:
  
  Run   whp\whpquecl( Input-output  fi_policy).  

  Disp fi_policy  with  frame  fr_cl.
  Apply  "Entry" to fi_policy.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_print
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_print C-Win
ON CHOOSE OF bu_print IN FRAME fr_cl /* PRINT */
DO:
     
     IF fi_event = "" THEN DO:
        MESSAGE "Warning Please Run Notify No. before Print Claim Form " 
        View-As Alert-Box Warning.
        APPLY "ENTRY" TO fi_policy.
        RETURN NO-APPLY.
     END.
     ELSE DO:
           Run Pro_Print.
     END.    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Query C-Win
ON CHOOSE OF bu_Query IN FRAME fr_cl /* PgDn */
DO:
    fi_poli = "".
    fi_poli:FGCOLOR IN FRAME fr_cl = 19.
    fi_poli:BGCOLOR IN FRAME fr_cl = 19.       
    DISPLAY  fi_poli With Frame fr_cl.
   
        FIND LAST uwm100 USE-INDEX uwm10001 WHERE uwm100.policy =  fi_policy
        NO-ERROR.
        IF NOT AVAILABLE  uwm100 THEN DO :
            MESSAGE "No record for this policy No. on Policy Header file uwm100" View-as Alert-Box Error.
            LEAVE.
        END.
        ELSE  DO:
            FIND LAST uwm100 where uwm100.policy = fi_policy NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:
                 {&WINDOW-NAME}:Hidden = Yes.
                 Run Wuw\wuwqpol1(Input uwm100.policy,
                                                    Input uwm100.rencnt,
                                                    Input uwm100.endcnt).
                 {&WINDOW-NAME}:Hidden = No.
             END.    
         END.

     FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR.
     IF AVAIL clm100 THEN DO:
        IF nv_polonf = "Y" THEN DO:
           IF clm100.fptr01 <> 0 THEN DO:
                fi_poli = "Policy Mtext".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
           END.
           ELSE DO:
                fi_poli = "Policy".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
           END.
        END.
        ELSE DO:
          IF clm100.fptr01 <> 0 THEN DO:
                fi_poli = "No Policy Mtext".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
          END.
          ELSE DO:
                fi_poli = "No Policy".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
          END.
        END.
        NEXT.
     END.
     ELSE NEXT.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ri
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ri C-Win
ON CHOOSE OF bu_ri IN FRAME fr_cl /* RI */
DO:
     fi_poli = " ".
     fi_poli:FGCOLOR IN FRAME fr_cl = 19.
     fi_poli:BGCOLOR IN FRAME fr_cl = 19.       
     DISPLAY  fi_poli With Frame fr_cl.
     
     {&WINDOW-NAME}:Hidden = Yes.
     Run Wuw\wuwqalc1(Input uwm100.policy,
                                       Input uwm100.rencnt,
                                       Input uwm100.endcnt).
     {&WINDOW-NAME}:Hidden = No.


     FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR.
     IF AVAIL clm100 THEN DO:
        IF nv_polonf = "Y" THEN DO:
           IF clm100.fptr01 <> 0 THEN DO:
                  fi_poli = "Policy Mtext".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
           END.
           ELSE DO:
                  fi_poli = "Policy".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
           END.
        END.
        ELSE DO:
              IF clm100.fptr01 <> 0 THEN DO:                  
                      fi_poli = "No Policy Mtext".
                      fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                      fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                      DISPLAY  fi_poli With Frame fr_cl.          
              END.
              ELSE DO:
                      fi_poli = "No Policy".
                      fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                      fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                      DISPLAY  fi_poli With Frame fr_cl.
              END.
        END.
        NEXT.
     END.
     ELSE NEXT.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_rk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_rk C-Win
ON CHOOSE OF bu_rk IN FRAME fr_cl /* RK+ */
DO:
     FIND FIRST  uwm100 
            WHERE uwm100.policy = fi_policy
                AND   uwm100.rencnt =  fi_rencnt
                AND   uwm100.endcnt = fi_endcnt 
     NO-LOCK NO-ERROR.
     IF AVAIL uwm100 THEN DO:
            {&WINDOW-NAME}:Hidden = Yes.
             Run Wuw\wuwqfi01(Input uwm100.policy,
                                               Input uwm100.rencnt,
                                               Input uwm100.endcnt).
            {&WINDOW-NAME}:Hidden = No.
     END.
     ELSE DO:
           MESSAGE "No record for this policy No. on Policy Header file uwm100" View-as Alert-Box Error.
           LEAVE.
     END.

     FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR.
     IF AVAIL clm100 THEN DO:
        IF nv_polonf = "Y" THEN DO:
           IF clm100.fptr01 <> 0 THEN DO:
                  fi_poli = "Policy Mtext".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
           END.
           ELSE DO:
                  fi_poli = "Policy".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
           END.
        END.
        ELSE DO:
              IF clm100.fptr01 <> 0 THEN DO:
                  fi_poli = "No Policy Mtext".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
              END.
          ELSE DO:
                  fi_poli = "No Policy".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
          END.
        END.
        NEXT.
     END.
     ELSE NEXT.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_cl /* SAVE */
DO:
  IF nv_chk = no THEN DO:

      /*---
      IF SUBSTR(fi_policy,1,1) = "I" THEN DO:
            IF fi_cedclm = "" THEN DO:
                  MESSAGE " Mandatory Field Ceding Claim no." View-As Alert-Box Warning.
                  APPLY "ENTRY" TO fi_cedclm.
                  RETURN NO-APPLY.
            END.
      END.
      -------*/

      IF fi_losdat = ? THEN DO:
            MESSAGE " Mandatory Field Loss Date." View-As Alert-Box Warning.
            APPLY "ENTRY" TO fi_losdat.
            RETURN NO-APPLY.      
      END.

      IF (fi_losdat < fi_comdat OR fi_losdat > fi_expdat) THEN DO:
          MESSAGE "Loss Date Must Be Between comm.date and expiry date "
          View-As Alert-Box Warning.
          APPLY "ENTRY" TO fi_losdat.
          RETURN NO-APPLY.      
      END.

      IF  fi_losdat > TODAY  THEN DO:
           MESSAGE "Loss Date Must Be Less than TODAY "
           View-As Alert-Box Warning.
           APPLY "ENTRY" TO fi_losdat.
           RETURN NO-APPLY.            
      END.

      IF fi_notbrh = "" THEN DO:
            MESSAGE "Mandatory to Notify Branch".
            APPLY "ENTRY" TO fi_notbrh.
            RETURN NO-APPLY.
      END.

      IF fi_loclos = " " THEN DO:
            MESSAGE " Mandatory Field Location's Loss". 
            APPLY "ENTRY" TO fi_loclos.
            RETURN NO-APPLY.      
      END.

      IF fi_loss1 = " " THEN DO:
            MESSAGE " Mandatory Field Cause Of Loss 1". 
            APPLY "ENTRY" TO fi_loss1.
            RETURN NO-APPLY.      
      END.

      IF fi_nature = " " THEN DO:
            MESSAGE " Mandatory Field Nature Of Loss".
            APPLY "ENTRY" TO fi_nature.
            RETURN NO-APPLY.       
      END.

      IF fi_cntact = " " THEN DO:
            MESSAGE " Mandatory Field Contact Person". 
            APPLY "ENTRY" TO fi_cntact.
            RETURN NO-APPLY.      
      END.
      
      IF fi_ctel = " " THEN DO:
            MESSAGE " Mandatory Field Tel". 
            APPLY "ENTRY" TO fi_ctel.
            RETURN NO-APPLY.      
      END.

      IF fi_default = "" THEN DO:
             MESSAGE "This madatory field must be IN,TP,BO,NO,UN,UI"
             View-As Alert-Box Warning.
             APPLY "ENTRY" TO fi_default.
             RETURN NO-APPLY.
      END. 

      IF fi_notby = " " THEN DO:
            MESSAGE " Mandatory Field Notify By". 
            APPLY "ENTRY" TO fi_notby.
            RETURN NO-APPLY.      
      END.

      IF fi_telphn = " " THEN DO:
            MESSAGE " Mandatory Field Tel". 
            APPLY "ENTRY" TO fi_telphn.
            RETURN NO-APPLY.      
      END.

      
      /*---
      IF nv_polonf = "Y" THEN DO:
          fi_poli = "Policy".
          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
          DISPLAY  fi_poli With Frame fr_cl.
      END.
      ELSE DO:
          fi_poli = "No Policy".
          fi_poli:FGCOLOR IN FRAME fr_cl = 15.
          fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
          DISPLAY  fi_poli With Frame fr_cl.
      END.
      ---*/

     
     IF fi_accdte = ?  THEN DO:
          MESSAGE "Mandatory Field is Accept Date".
          APPLY "ENTRY" TO fi_accdte.
          RETURN NO-APPLY.
      END.

      IF fi_accby = " " THEN DO:
          MESSAGE "Mandatory Field Accept by".
          APPLY "ENTRY" TO fi_accby.
          RETURN NO-APPLY.
      END.
      
      IF fi_survy = " " THEN DO:
          MESSAGE "Mandatory Field Surveyor Ref".
          APPLY "ENTRY" TO fi_survy.
          RETURN NO-APPLY.
      END.

      IF fi_surdt = ? THEN DO:
          MESSAGE "Mandatory Field is Date".
          APPLY "ENTRY" TO fi_surdt.
          RETURN NO-APPLY. 
      END.       

      /*---
      IF uwm100.tranty = "C" THEN DO:
           IF (fi_losdat < fi_comdat OR fi_losdat >= fi_expdat) THEN DO:
                MESSAGE "Loss Date is Between Not Cover!" View-As Alert-Box Warning.
                APPLY "ENTRY" TO fi_losdat.
                RETURN NO-APPLY.
           END.
      END.
      -----*/
      Run Pro_Select.     

   END.  /* END IF nv_chk = NO */
   ELSE DO:
          MESSAGE "This Notify No. Is Already Exist. " View-As Alert-Box Warning.
          Apply "Entry" To fi_event.
          Return No-Apply.
   END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_survy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_survy C-Win
ON CHOOSE OF bu_survy IN FRAME fr_cl
DO:
      Def   Var   n_acno  As Char.
      Def   Var   n_name  As Char.
      Def   Var   nv_type1  As Char.
      Def   Var   nv_type2  As Char.
            
      /*--- Add Chutikarn A50-0178 -----*/
      /*--
      nv_type1 = "0J".
      nv_type2 = "0S". --*/
      nv_type1 = INPUT fi_notbrh + "J".
      nv_type2 = INPUT fi_notbrh + "S".
      /*--- End Chutikarn A50-0178 -----*/
     
      Run Whp\Whpclno2 (Input nv_type1, Input nv_type2, Output n_acno , Output n_name).
      
      fi_survy        =  n_acno.
      fi_surynam  =  n_name.

  Disp fi_survy  fi_surynam with  frame  fr_cl.
 
  Apply  "Entry" to fi_survy.
  Return no-apply.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accby C-Win
ON LEAVE OF fi_accby IN FRAME fr_cl
DO:
       fi_accby = CAPS(INPUT fi_accby).

       IF fi_accby = "" THEN 
          MESSAGE "This Mandatory field Accept By" VIEW-AS ALERT-BOX ERROR.


       fi_accnam = "".
       
       FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                             xtm600.acno = fi_accby           NO-LOCK NO-ERROR.
       IF AVAIL xtm600 THEN
             fi_accnam = TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name).
       ELSE DO:
             FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                   xmm600.acno = fi_accby             NO-LOCK NO-ERROR.
             IF AVAIL xmm600 THEN fi_accnam = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
             ELSE DO:
                 MESSAGE "This Code " fi_accby "is not in file xmm600".
                 APPLY "ENTRY" TO fi_accby.
                 RETURN NO-APPLY.
              END.
       END.

       DISPLAY fi_accby fi_accnam WITH FRAME fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdte C-Win
ON LEAVE OF fi_accdte IN FRAME fr_cl
DO:
    
      fi_accdte = INPUT fi_accdte.

      IF fi_accdte = ?  THEN DO:
          MESSAGE "This mandatory field is Expire Date" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fi_accdte.
          RETURN NO-APPLY.
      END.
      
      DISPLAY fi_accdte WITH FRAME fr_cl.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acchr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acchr C-Win
ON LEAVE OF fi_acchr IN FRAME fr_cl
DO:
       fi_acchr = INPUT fi_acchr.

       IF fi_acchr > 24 OR fi_acchr < 0 THEN DO:
           MESSAGE "Must be in the range zero to 24" View-As Alert-Box Error.
           Apply "Entry" To fi_acchr.
           Return No-Apply.
       END.
       DISPLAY fi_acchr WITH FRAME fr_cl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accmin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accmin C-Win
ON LEAVE OF fi_accmin IN FRAME fr_cl
DO:
       fi_accmin = INPUT  fi_accmin.
   
       IF fi_accmin > 59 OR fi_accmin < 0 THEN DO:
           MESSAGE "Must be in the range zero to 59" View-As Alert-Box Error.
           Apply "Entry" To fi_accmin.
           Return No-Apply.
       END.
       DISPLAY fi_accmin WITH FRAME fr_cl.
   
       IF fi_acchr = 0 AND fi_accmin = 0 THEN nv_acctim = "     ".
       ELSE nv_acctim = STRING(fi_acchr,"99") + ":" + STRING(fi_accmin,"99").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accnam C-Win
ON LEAVE OF fi_accnam IN FRAME fr_cl
DO:
  fi_accnam = Input fi_accnam.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_append
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_append C-Win
ON LEAVE OF fi_append IN FRAME fr_cl
DO:
      fi_append = Input fi_append.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cedclm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cedclm C-Win
ON LEAVE OF fi_cedclm IN FRAME fr_cl
DO:
     fi_cedclm = CAPS(INPUT fi_cedclm).

      IF SUBSTR(fi_policy,1,1) = "I" THEN DO:

           IF fi_cedclm = "" THEN 
                  MESSAGE " Mandatory Field Ceding Claim no." View-As Alert-Box Error.

            ELSE DO:
                fi_cedclm = CAPS(Input fi_cedclm).
                FIND FIRST  clm100 USE-INDEX clm10009  WHERE
                                       clm100.cedclm = fi_cedclm
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE clm100 THEN DO:
                    Run  Wcz\WczMsg04(Input fi_cedclm,
                                                          Input clm100.claim,
                                                          Input clm100.notdat).
                END.
            END.    
     END.           /* IF SUBSTR(n_policy,1,1) = "I" */

     DISPLAY fi_cedclm WITH FRAME fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_cl
DO:
  fi_class = Input fi_class.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_clsdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_clsdes C-Win
ON LEAVE OF fi_clsdes IN FRAME fr_cl
DO:
  fi_clsdes = Input fi_clsdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cntact
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cntact C-Win
ON LEAVE OF fi_cntact IN FRAME fr_cl
DO:
  fi_cntact = Input fi_cntact.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_cl
DO:
  fi_comdat = Input fi_comdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ctel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ctel C-Win
ON LEAVE OF fi_ctel IN FRAME fr_cl
DO:
        fi_ctel = Input fi_ctel.
  
        Assign fi_display = "IN,TP,BO,UN,UI" .

        Display fi_ctel  fi_display With Frame fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_default
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_default C-Win
ON LEAVE OF fi_default IN FRAME fr_cl
DO:
      fi_default = Caps(Input fi_default).      
      Display fi_default With Frame fr_cl.
      IF fi_default <> "" THEN DO:
          IF fi_default = "IN" THEN fi_defdes = "Insured".
          ELSE IF fi_default = "TP" THEN fi_defdes = "Third Party".
          ELSE IF fi_default = "BO" THEN fi_defdes = "Both".
          ELSE IF fi_default = "NO" THEN fi_defdes = "None".
          ELSE IF fi_default = "UN" THEN fi_defdes = "Unknown".
          ELSE IF fi_default = "UI" THEN fi_defdes = "Under Investigation".
       END.
       ELSE 
             MESSAGE "This madatory field must be IN,TP,BO,NO,UN,UI" 
             VIEW-AS ALERT-BOX WARNING.
      
      DISPLAY fi_default fi_defdes WITH FRAME fr_cl.
      ASSIGN 
           fi_display = "" .
      DISPLAY  fi_display WITH FRAME fr_cl.
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_default C-Win
ON MOUSE-SELECT-CLICK OF fi_default IN FRAME fr_cl
DO:
          Assign fi_display = "IN,TP,BO,UN,UI" .

        Disp fi_ctel fi_display With Frame fr_cl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_defdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_defdes C-Win
ON LEAVE OF fi_defdes IN FRAME fr_cl
DO:
         fi_defdes = Input fi_defdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_estim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_estim C-Win
ON LEAVE OF fi_estim IN FRAME fr_cl
DO:
/*--------   Add Watsana K. [A530138] -> Check Reserve --------
   fi_estim = Input fi_estim. */

  ASSIGN nv_res   = 0
         nv_res   = fi_estim 
         fi_estim = Input fi_estim.

  IF INPUT fi_estim <> nv_res THEN DO : 
     FIND FIRST xzm027 USE-INDEX xzm02701 WHERE xzm027.usrid = fi_userid NO-LOCK NO-ERROR NO-WAIT.
     IF NOT AVAILABLE  xzm027  THEN DO:
         MESSAGE "You must set your Authority Reserve" fi_userid View-As ALERT-BOX WARNING.
         fi_estim = nv_res.
         DISPLAY fi_estim WITH FRAME fr_cl.
         APPLY "ENTRY" TO fi_cntact.
         RETURN NO-APPLY.  
     END.
     ELSE DO:
         IF INPUT fi_estim > xzm027.res_lt THEN DO:
            MESSAGE "Over Authority Reserve," fi_userid "have Only" xzm027.res_lt View-As ALERT-BOX WARNING.
            fi_estim = nv_res.
            DISPLAY fi_estim WITH FRAME fr_cl.
            APPLY "ENTRY" TO fi_estim.
            RETURN NO-APPLY.                         
         END.
     END.
  END.
/*---------   End Watsana K. [A530138]  ----------*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_event
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_event C-Win
ON LEAVE OF fi_event IN FRAME fr_cl
DO:
          fi_event = Caps(INPUT fi_event).
          Display fi_event With Frame fr_cl.
     
          FIND FIRST    clm100 USE-INDEX clm10003 WHERE 
                                   clm100.event = fi_event  NO-LOCK NO-ERROR NO-WAIT.
          IF NOT AVAIL clm100 THEN DO:
          
              IF LOCKED clm100 THEN DO:
                    ASSIGN
                      fi_event  = ""
                      nv_notify = ""
                      fi_notdat = ?
                      fi_nottim = "".
                      
                       FIND FIRST xmm603 USE-INDEX xmm60301  WHERE
                                             xmm603.branch =  fi_notbrh         AND
                                             xmm603.poltyp =  "N00"               NO-ERROR.
                        IF NOT AVAILABLE xmm603 THEN DO:
                           IF  LOCKED xmm603 THEN 
                                MESSAGE " Record is being used " VIEW-AS ALERT-BOX WARNING.
                           ELSE DO:
                              CREATE xmm603.
                              ASSIGN xmm603.branch = CAPS(fi_notbrh)
                                             xmm603.nextno = 2
                                             nv_nextno     = 1.
                            END.
                        END.
                        ELSE DO:
                            nv_nextno     = xmm603.nextno.
                            xmm603.nextno = xmm603.nextno + 1.
                        END.
                 
                    MESSAGE "Notify no." fi_event "ซ้ำที่ Claim No.:" clm100.claim "โปรดบันทึกเลขNotify ใหม่." 
                    View-As Alert-Box Error.
               
                   Enable fi_event With Frame frame_a.
                   fi_event:FGCOLOR IN FRAME fr_cl = 2.
                   fi_event:BGCOLOR IN FRAME fr_cl = 15.               
                   Apply "Entry" To fi_event.
                   Return No-Apply.
                   DISPLAY fi_event fi_notdat fi_nottim WITH FRAME fr_cl.

              END.
              Disable fi_event With Frame fr_cl.
              /*Disable bu_save With Frame fr_cl.*/
              fi_event:FGCOLOR IN FRAME fr_cl = 7.
              fi_event:BGCOLOR IN FRAME fr_cl = 6.   
              fi_notdat:FGCOLOR IN FRAME fr_cl = 7.
              fi_notdat:BGCOLOR IN FRAME fr_cl = 6.  
              fi_nottim:FGCOLOR IN FRAME fr_cl = 7.
              fi_nottim:BGCOLOR IN FRAME fr_cl = 6.                
              Disp fi_event fi_notdat fi_nottim With Frame fr_cl.    
              nv_chk = Yes.    

              IF fi_event = "" THEN LEAVE.
        
              Run Chk_Dup.
/*              RUN Pro_Save.             /* S A V E   N O T I F Y */     */     
          END.
          ELSE DO:  /*มีเบอร์ Notify ในระบบ*/
                MESSAGE "Notify no." fi_event "ซ้ำที่ Claim No.:" clm100.claim "โปรดบันทึกเลขNotify ใหม่." 
                View-As Alert-Box Error.
                ASSIGN
                  fi_event  = ""
                  nv_notify = ""
                  nv_select = 0
                  fi_notdat = ?
                  fi_nottim = "".
                  
                  Run Pro_Select.
           
                  IF nv_select  = 2  THEN DO:
                      IF nv_notify = "" THEN DO:
                          Enable fi_event With Frame fr_cl.
                          fi_event:FGCOLOR IN FRAME fr_cl = 2.
                          fi_event:BGCOLOR IN FRAME fr_cl = 15.               
                          Apply "Entry" To fi_event.
                          Return No-Apply.
                  END.  
              END.
          END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_cl
DO:
  fi_expdat = Input fi_expdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insref
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insref C-Win
ON LEAVE OF fi_insref IN FRAME fr_cl
DO:
  fi_insref = Input fi_insref.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_itemno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_itemno C-Win
ON LEAVE OF fi_itemno IN FRAME fr_cl
DO:
   fi_itemno = Input fi_itemno.

   /* IF fi_itemno <> 000 THEN DO: Montrikon S. [A66-0067] */
   IF fi_itemno <> 00000 THEN DO:

      IF fi_itemno < 1 THEN DO:
          MESSAGE "Item No. must not less than 1" View-As Alert-Box Error.
          APPLY "ENTRY" TO fi_itemno.
          RETURN NO-APPLY.
      END.
   END.

      fi_append  = "".
      nv_ans = Yes.
      FIND uwm100 USE-INDEX uwm10001 WHERE
                uwm100.policy = fi_policy          AND
                uwm100.rencnt = fi_rencnt          AND
                uwm100.endcnt = fi_endcnt
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE uwm100 THEN DO:
          fi_append  = uwm100.cr_2.

        /*
          เป็น APPEND POLICY เช็ค ว่าได้มีการเปิดClaim ของPolicy ที่เป็นเบอร์
          APPEND POLICY หรือไม่ 
          ถ้า เปิดไปแล้ว ห้ามเปิดซ้ำอีก
        */
                                                         /*JINV001=PRODUCT*/
        IF fi_append <> "" THEN DO:
            /*------- Add Chutikarn A50-0178 ------*/
            /*--------
            IF SUBSTR(fi_append,1,1)   = "D"     AND
               SUBSTR(uwm100.cr_1,1,4) = "JINV"
            THEN DO:

                FIND FIRST clm100 USE-INDEX clm10002 WHERE
                           clm100.policy = fi_append
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE clm100 THEN DO:
                     DISPLAY fi_append   WITH FRAME fr_cl.


                     Run Wcz\WczMsg02(Input fi_policy,
                                      Input clm100.claim,
                                      Input clm100.notdat,
                                      Input clm100.name1,
                                      Input fi_append,
                                      Input-Output nv_ans).

                     IF nv_ans = No Then Do:
                         Run ProClear.
                         Apply "Entry" to fi_policy.
                         Return No-Apply.
                     End.     

                     ASSIGN
                        fi_notdat = TODAY
                        fi_accdte = TODAY
                        fi_acchr  = INT(SUBSTR(STRING(TIME,"HH:MM"),1,2))
                        fi_accmin = INT(SUBSTR(STRING(TIME,"HH:MM"),4,2))
                        fi_append = "".

                     DISPLAY
                        fi_append    fi_notdat    fi_accdte        fi_acchr   fi_accmin 
                     WITH FRAME fr_cl.
                    /* NEXT.*/
                END.
            END.
            --------*/
            FIND FIRST buwm100 USE-INDEX uwm10001 WHERE
                       buwm100.policy = fi_append 
            NO-LOCK NO-ERROR.
            IF AVAIL buwm100 THEN DO:
                IF  (
                      SUBSTR(fi_append,1,1)   = "D" OR
                     (SUBSTR(fi_append,1,1)  >= "0" AND SUBSTR(fi_append,1,1)  <= "9" )
                    ) 
                    AND SUBSTR(uwm100.cr_1,1,4) = "JINV" 
                THEN DO:

                    FIND FIRST clm100 USE-INDEX clm10002 WHERE
                               clm100.policy = fi_append
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE clm100 THEN DO:
                         DISPLAY fi_append   WITH FRAME fr_cl.

                         Run Wcz\WczMsg02(Input fi_policy,
                                          Input clm100.claim,
                                          Input clm100.notdat,
                                          Input clm100.name1,
                                          Input fi_append,
                                          Input-Output nv_ans).

                         IF nv_ans = No Then Do:
                             Run ProClear.
                             Apply "Entry" to fi_policy.
                             Return No-Apply.
                         End.     

                         ASSIGN
                            fi_notdat = TODAY
                            fi_accdte = TODAY
                            fi_acchr  = INT(SUBSTR(STRING(TIME,"HH:MM"),1,2))
                            fi_accmin = INT(SUBSTR(STRING(TIME,"HH:MM"),4,2))
                            fi_append = "".

                         DISPLAY
                            fi_append    fi_notdat    fi_accdte        fi_acchr   fi_accmin 
                         WITH FRAME fr_cl.
                        /* NEXT.*/
                    END.
                END.
            END.
            /*------- End Chutikarn A50-0178 ------*/

          END.        /* IF fi_append <> "" THEN DO: */

   IF nv_ans = YES THEN DO:

        /* Check open duplicate policy */
        FOR EACH clm100 USE-INDEX clm10002 WHERE
                            clm100.policy = uwm100.policy AND
                            clm100.rencnt = uwm100.rencnt
        NO-LOCK:

            Run Wcz\WczMsg01(Input fi_policy,
                             Input clm100.claim,
                             Input clm100.notdat,
                             Input clm100.losdat,
                             INput clm100.name1).
        END.
        ASSIGN
            fi_insref = uwm100.insref
            fi_comdat = uwm100.comdat
            fi_expdat = uwm100.expdat
            nv_poltyp = uwm100.poltyp
            nv_undyr  = uwm100.undyr
            nv_acno1  = uwm100.acno1
            nv_cntry  = uwm100.cntry
            nv_dir_ri = uwm100.dir_ri
            nv_dept   = uwm100.dept
            nv_agent  = uwm100.agent
            nv_postcd = uwm100.postcd
            nv_co_per = uwm100.co_per
            nv_coins  = uwm100.coins
            nv_cn_no  = uwm100.cn_no
            nv_billco = uwm100.billco
            nv_styp20 = uwm100.styp20
            nv_sval20 = uwm100.sval20
            nv_cedco  = uwm100.cedco
            nv_cedpol = uwm100.cedpol
            nv_cedces = uwm100.cedces
            nv_recip  = uwm100.recip
            nv_finint = uwm100.finint
            nv_producer = uwm100.acno1.

      END.

      FIND FIRST xmm079 NO-LOCK NO-ERROR.
      IF AVAIL xmm079 THEN
         nv_prloss = xmm079.prlo_d.

      FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = fi_insref NO-LOCK NO-ERROR.
      IF AVAIL xmm600 THEN DO:
          ASSIGN
             nv_icno  = xmm600.icno
             nv_oldic = xmm600.oldic.

          FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                     xmm600.acno = nv_producer NO-LOCK NO-ERROR.
          IF AVAIL xmm600 THEN DO:                    
              ASSIGN
                   nv_produnam = xmm600.name.
          END.
          ELSE DO:
               FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                          xtm600.acno = nv_producer NO-LOCK NO-ERROR.
               IF AVAIL xtm600 THEN DO:
                   ASSIGN
                      nv_produnam = xtm600.name.
               END.
               ELSE DO:
                      nv_produnam = "".                            
               END.       
          END. 
      END.       
      ELSE DO:
         ASSIGN
            nv_icno  = " "
            nv_oldic = " ".
      END.      

      FIND uwm130 USE-INDEX uwm13001 WHERE
                uwm130.policy = uwm100.policy AND
                uwm130.rencnt = uwm100.rencnt AND
                uwm130.endcnt = uwm100.endcnt AND
                uwm130.riskgp = nv_riskgp     AND
                uwm130.riskno = fi_riskno     AND
                uwm130.itemno = fi_itemno
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE uwm130 THEN DO:
           fi_itmtxt = uwm130.i_text.
      END.

      For Each uwm130 Use-Index uwm13001      Where
               uwm130.policy = uwm100.policy  And
               uwm130.rencnt = uwm100.rencnt  And
               uwm130.endcnt = uwm100.endcnt
      No-Lock:
         fi_si = fi_si + uwm130.uom1_v.
      End.

      FIND uwm120 USE-INDEX uwm12001     WHERE
           uwm120.policy = uwm100.policy AND
           uwm120.rencnt = uwm100.rencnt AND
           uwm120.endcnt = uwm100.endcnt AND
           uwm120.riskgp = nv_riskgp     AND
           uwm120.riskno = fi_riskno     
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE uwm120 THEN DO:
           fi_class  = uwm120.class.
           nv_sicurr = uwm120.sicurr.

         FIND xmm016 WHERE xmm016.class = fi_class NO-LOCK.
         IF AVAIL xmm016 THEN DO:
               fi_clsdes = xmm016.clsdes.
         END.

         IF fi_itmtxt <> " " THEN DO:
              /* FIND xmm066 WHERE xmm066.i_text = fi_itmtxt NO-LOCK. */     /*Block Watsana K. [A530114]*/
              FIND xmm066 WHERE xmm066.i_text = fi_itmtxt NO-LOCK NO-ERROR.  /*Add Watsana K. [A530114]*/
              IF AVAIL xmm066 THEN DO:
                   FIND xmd066 WHERE RECID(xmd066) = xmm066.fptr01 NO-LOCK NO-ERROR.
                   IF AVAIL xmd066 THEN DO:
                         fi_txtdes = xmd066.itext.
                   END.
              END.
         END.
         ELSE
             ASSIGN
                fi_txtdes = " "
                fi_itmtxt = " "
                n_cnt = LENGTH(nv_styp20)
                n_cnt = ROUND((n_Cnt - 3) / 4 ,0 ) + 1
                SUBSTRING(nv_styp20, n_cnt * 4 + 1) = uwm120.styp20
                SUBSTRING(nv_sval20, n_cnt * 4 + 1) = uwm120.sval20.

         FIND FIRST xmm049 USE-INDEX xmm04901 WHERE
                    xmm049.class = fi_class   AND
                    xmm049.suse  = "5" NO-LOCK NO-ERROR.
         n_s = "".

         REPEAT WHILE AVAIL xmm049 :
              n_s = n_s + xmm049.styp + FILL(" ",4 - LENGTH(xmm049.styp)).
              FIND NEXT xmm049 USE-INDEX xmm04901  WHERE
                        xmm049.class = fi_class    AND
                        xmm049.suse  = "5"         NO-LOCK NO-ERROR.
         END.

         ASSIGN
           n_cnt = LENGTH(nv_styp20)
           n_cnt = ROUND((n_cnt - 3) / 4 ,0 ) + 1
           SUBSTRING(nv_styp20 ,n_cnt * 4 + 1 ) =  n_s
           SUBSTRING(nv_sval20 ,n_cnt * 4 + 1 ) = FILL(" " , 240 - n_cnt * 4).

      END.
      ELSE DO:
             fi_class  = "".
             nv_sicurr = "".
      END.

      FIND uwm300 USE-INDEX uwm30001 WHERE
           uwm300.policy = uwm100.policy  AND
           uwm300.rencnt = uwm100.rencnt  AND
           uwm300.endcnt = uwm100.endcnt  AND
           uwm300.riskgp = nv_riskgp      AND
           uwm300.riskno = fi_riskno      NO-LOCK NO-ERROR NO-WAIT.

      IF AVAILABLE uwm300 THEN DO:
           ASSIGN
               nv_vehves = uwm300.vessel
               nv_vesno  = uwm300.vesno.
      END.

      FIND uwm304 USE-INDEX uwm30401 WHERE
           uwm304.policy = uwm100.policy  AND
           uwm304.rencnt = uwm100.rencnt  AND
           uwm304.endcnt = uwm100.endcnt  AND
           uwm304.riskgp = nv_riskgp      AND
           uwm304.riskno = fi_riskno
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE uwm304 THEN DO:
          ASSIGN
              nv_distct = uwm304.distct
              nv_occlim = uwm304.occlim
              nv_pcrisk = uwm304.pcrisk.  
      END.

      FIND uwm307 USE-INDEX uwm30701      WHERE
           uwm307.policy = uwm100.policy  AND
           uwm307.rencnt = uwm100.rencnt  AND
           uwm307.endcnt = uwm100.endcnt  AND
           uwm307.riskgp = nv_riskgp      AND
           uwm307.riskno = fi_riskno      AND
           uwm307.itemno = fi_itemno      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE uwm307 THEN DO:
          ASSIGN
             nv_icno = uwm307.icno.
      END.

      IF fi_class <> "" THEN DO:
          FIND xmm016 WHERE xmm016.class = uwm120.class NO-LOCK.

         /*---------------------------------------------------------------
          เช็คว่าเป็นก/ธ line30 และมี code ins. นี้ ดึงชื่อที่อยู่ใน
         uwm100 ได้เลย
         -----------------------------------------------------------------*/

         IF uwm100.poltyp  <> "M30" AND
             uwm100.insref  <> "WMC0001"
         THEN DO:
              FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                                    xtm600.acno = fi_insref   NO-LOCK NO-ERROR.
               IF AVAIL xtm600 THEN
                   ASSIGN
                       fi_ntitle = TRIM(xtm600.ntitle)
                       fi_name1  = TRIM(xtm600.name)
                       nv_name2  = TRIM(xtm600.name2)
                       nv_name3  = TRIM(xtm600.name3)
                       nv_addr1  = TRIM(xtm600.addr1)
                       nv_addr2  = TRIM(xtm600.addr2)
                       nv_addr3  = TRIM(xtm600.addr3)
                       nv_addr4  = TRIM(xtm600.addr4)
                       nv_fname  = TRIM(xtm600.fname).
         ELSE DO:
                  FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                        xmm600.acno = fi_insref              NO-LOCK NO-ERROR.
                  IF AVAIL xmm600 THEN
                       ASSIGN
                           fi_ntitle = TRIM(xmm600.ntitle)
                           nv_fname  = TRIM(xmm600.fname)
                           fi_name1  = TRIM(xmm600.name)
                           nv_name2  = TRIM(xmm600.name2)

                           /*---
                           nv_name3  = TRIM(xmm600.name3)
                           comment by Chaiyong w. A58-0117 16/05/2015*/

                           nv_addr1  = TRIM(xmm600.addr1)
                           nv_addr2  = TRIM(xmm600.addr2)
                           nv_addr3  = TRIM(xmm600.addr3)
                           nv_addr4  = TRIM(xmm600.addr4).
         END.
    END.
    ELSE DO:
          ASSIGN
               fi_ntitle = TRIM(uwm100.ntitle)
               fi_name1  = TRIM(uwm100.name1)
               nv_name2  = TRIM(uwm100.name2)
               nv_name3  = TRIM(uwm100.name3)
               nv_addr1  = TRIM(uwm100.addr1)
               nv_addr2  = TRIM(uwm100.addr2)
               nv_addr3  = TRIM(uwm100.addr3)
               nv_addr4  = TRIM(uwm100.addr4)
               nv_fname  = TRIM(uwm100.fname).
         END.

         FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                               xmm600.acno = nv_agent    NO-LOCK NO-ERROR.
         IF AVAIL xmm600 THEN DO:
              ASSIGN nv_name  = TRIM(xmm600.name).
         END.

         FIND FIRST    xmm023 USE-INDEX xmm02301 WHERE
                                  xmm023.branch = fi_notbrh NO-LOCK NO-ERROR.
         IF NOT AVAIL xmm023 THEN DO:
              MESSAGE "Can not find " fi_notbrh " in file xmm023" View-As Alert-Box Error.
         END.
         ELSE DO:
              fi_ntbdes = xmm023.bdes.
         END.

         DISPLAY  fi_ntbdes   fi_clsdes   fi_txtdes   fi_poldes   fi_class          
                  fi_itmtxt   fi_si       fi_itemno   fi_comdat   fi_expdat        
                  fi_insref   fi_ntitle   fi_name1    fi_notbrh             
         WITH FRAME fr_cl.
      END.

      IF fi_append = "" THEN
          DISPLAY   fi_append   WITH FRAME fr_cl.
      ELSE
          DISPLAY   fi_append   WITH FRAME fr_cl.

      IF TODAY > fi_expdat THEN DO:
           fi_comdat:FGCOLOR IN FRAME fr_cl = 7.
           fi_comdat:BGCOLOR IN FRAME fr_cl = 6.       
           fi_expdat:FGCOLOR IN FRAME fr_cl = 7.
           fi_expdat:BGCOLOR IN FRAME fr_cl = 6.           
           DISPLAY  fi_comdat  fi_expdat   WITH FRAME fr_cl.
      END.     
      ELSE
           DISPLAY  fi_comdat  fi_expdat
           WITH FRAME fr_cl.

  END. /*nv_ans = YES*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_itmtxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_itmtxt C-Win
ON LEAVE OF fi_itmtxt IN FRAME fr_cl
DO:
  fi_itmtxt = Input fi_itmtxt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loclos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loclos C-Win
ON LEAVE OF fi_loclos IN FRAME fr_cl
DO:
  fi_loclos = Input fi_loclos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loclos2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loclos2 C-Win
ON LEAVE OF fi_loclos2 IN FRAME fr_cl
DO:
  fi_loclos = Input fi_loclos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_losdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_losdat C-Win
ON F4 OF fi_losdat IN FRAME fr_cl
DO:
  RUN ProClear.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_losdat C-Win
ON LEAVE OF fi_losdat IN FRAME fr_cl
DO:
        fi_losdat = INPUT fi_losdat.

        /*---
        IF uwm100.tranty = "C" THEN DO:
              IF (fi_losdat < fi_comdat OR fi_losdat >= fi_expdat) THEN 
                   MESSAGE "Policy is Cancel And Loss Date is Between Not Cover!"
                   View-As Alert-Box Warning.

        END.
        ----*/

        IF fi_losdat = ? THEN DO: 
            MESSAGE "Mandatory to Loss Date".       

        END.

        IF fi_losdat <> ? THEN DO:  /*..*/
        
        IF (fi_losdat < fi_comdat OR fi_losdat > fi_expdat) THEN 
             MESSAGE "Loss Date Must Be Between comm.date and expiry date "
             VIEW-AS  ALERT-BOX  WARNING.
             

        IF  fi_losdat > TODAY  THEN DO:
            MESSAGE "Loss Date Must Be Less than TODAY "
            VIEW-AS  Alert-Box WARNING.
            APPLY "Entry" TO  fi_losdat.
            RETURN NO-APPLY.
        END.


        DISPLAY fi_losdat WITH FRAME fr_cl.

        nv_continue = YES.
        nv_choice   = YES.

        /*-------
        FOR EACH clm100 USE-INDEX clm10008 WHERE
                            clm100.losdat = fi_losdat AND
                            clm100.policy = fi_policy AND
                            clm100.rencnt = fi_rencnt AND
                            clm100.endcnt = fi_endcnt AND
                            clm100.riskno = fi_riskno AND
                            clm100.itemno = fi_itemno
        NO-LOCK:

             IF clm100.losdat = fi_losdat OR
                  clm100.notdat = fi_notdat
             THEN DO:
                  nv_choice = NO.
                  Run Wcz\WczMsg03(Input clm100.event,
                                                       Input clm100.notdat,
                                                       Input clm100.losdat,
                                                       Input clm100.lostim,
                                                       Input clm100.policy,
                                                       Input clm100.rencnt,
                                                       Input clm100.endcnt,
                                                       Input clm100.riskno,
                                                       Input clm100.itemno,
                                                       Input clm100.losloc1,
                                                       Input clm100.entid,
                                                       Input clm100.padsts,
                                                       Input-Output nv_choice).

                  nv_continue = nv_choice.

                  IF nv_continue = NO THEN DO:
                      Run ProClear.
                      Apply "Entry" To fi_policy.
                      Return No-Apply.
                  END.
             END.
             
        END.  /* each end*/
        -------*/

        END.   /*---end losdat <> ? ---*/

        /*----
        
        IF nv_continue = YES THEN DO:

          /* ------------------- NOTIFY DATE ------------------ */
          nv_continue = YES.
          nv_choice   = YES.

          FOR EACH clm100 USE-INDEX clm10011 WHERE
                              clm100.finclo = fi_notdat AND
                              clm100.policy = fi_policy  AND
                              clm100.rencnt = fi_rencnt AND
                              clm100.endcnt = fi_endcnt AND
                              clm100.riskno = fi_riskno AND
                              clm100.itemno = fi_itemno
          NO-LOCK:
                IF clm100.losdat = fi_losdat OR
                   clm100.notdat = fi_notdat
                THEN DO:
                        nv_choice   = NO.
                        Run Wcz\WczMsg03(Input clm100.event,
                                                             Input clm100.notdat,
                                                             Input clm100.losdat,
                                                             Input clm100.lostim,
                                                             Input clm100.policy,
                                                             Input clm100.rencnt,
                                                             Input clm100.endcnt,
                                                             Input clm100.riskno,
                                                             Input clm100.itemno,
                                                             Input clm100.losloc1,
                                                             Input clm100.entid,
                                                             Input clm100.padsts,
                                                             Input-Output nv_choice).
              nv_continue = nv_choice.

              IF nv_continue = NO THEN DO:
                   Run ProClear.
                   Apply "Entry" To fi_policy.
                   Return No-Apply.
              END.
            END.
          END.
     
        END.                   /* IF nv_continue = YES THEN DO: */

        IF  nv_continue = NO THEN DO:
             RUN ProClear.
             Apply "Entry" To fi_policy.
             Return No-Apply.
        END.
        -------*/
 END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loshr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loshr C-Win
ON LEAVE OF fi_loshr IN FRAME fr_cl
DO:
    fi_loshr = input fi_loshr.

    IF fi_loshr > 24 OR fi_loshr < 0 THEN DO:
           MESSAGE "Must be in the range zero to 24" View-As Alert-Box Error.
           Apply "Entry" To fi_loshr.
           Return No-Apply.
    END.
    DISPLAY fi_loshr WITH FRAME fr_cl.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_losmin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_losmin C-Win
ON LEAVE OF fi_losmin IN FRAME fr_cl
DO:
    fi_losmin = input fi_losmin.

    IF fi_losmin > 59 OR fi_losmin < 0 THEN DO:
           MESSAGE "Must be in the range zero to 59" View-As Alert-Box Error.
           Apply "Entry" To fi_losmin.
           Return No-Apply.
    END.
    
    DISPLAY fi_losmin WITH FRAME fr_cl.      
    
    IF fi_loshr = 0 AND fi_losmin = 0 THEN nv_lostim = "     ".
    ELSE nv_lostim = STRING(fi_loshr,"99") + ":" + STRING(fi_losmin,"99").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loss1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loss1 C-Win
ON LEAVE OF fi_loss1 IN FRAME fr_cl
DO:
  fi_loss1 = Input fi_loss1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loss2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loss2 C-Win
ON LEAVE OF fi_loss2 IN FRAME fr_cl
DO:
  fi_loss2 = Input fi_loss2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loss3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loss3 C-Win
ON LEAVE OF fi_loss3 IN FRAME fr_cl
DO:
  fi_loss3 = Input fi_loss3.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name1 C-Win
ON LEAVE OF fi_name1 IN FRAME fr_cl
DO:
  fi_name1 = Input fi_name1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_natdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_natdes C-Win
ON LEAVE OF fi_natdes IN FRAME fr_cl
DO:
  fi_natdes = Input fi_natdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nature
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nature C-Win
ON LEAVE OF fi_nature IN FRAME fr_cl
DO:
      fi_nature = CAPS(INPUT fi_nature).
      
       IF fi_nature = " " THEN 
            MESSAGE " Mandatory Field Nature Of Loss" View-As Alert-Box Warning.

       IF fi_nature <> "" THEN DO:
           FIND FIRST xmm073 /*USE-INDEX xmm07301*/   WHERE   /*xmm073.class = fi_class  AND*/
                                                        xmm073.loss  =  CAPS(INPUT fi_nature) NO-LOCK NO-ERROR.
           IF AVAIL xmm073 THEN DO:
              
               fi_natdes = SUBSTRING(xmm073.ldesr,1,19).
               DISPLAY  fi_nature fi_natdes WITH FRAME fr_cl.
           END.
           ELSE DO:
               MESSAGE " Cannot Find This Nature of Loss " View-As Alert-Box Error.
               Apply "Entry" To fi_nature.
               Return No-Apply.
           END.  
        END.       
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notbrh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notbrh C-Win
ON LEAVE OF fi_notbrh IN FRAME fr_cl
DO:
       
    fi_notbrh = CAPS(INPUT fi_notbrh).
  
       IF fi_notbrh = "" THEN 
             MESSAGE "Mandatory to Notify Branch" View-As Alert-Box Warning.
       ELSE DO:
           FIND FIRST xmm023 USE-INDEX xmm02301 WHERE
                                 xmm023.branch = fi_notbrh NO-LOCK NO-ERROR.
           IF NOT AVAIL xmm023 THEN DO:
               MESSAGE "Can not find " fi_notbrh " in file xmm023" View-As Alert-Box Error.
               APPLY "ENTRY" TO fi_notbrh.
               RETURN NO-APPLY.
           END.
           ELSE fi_ntbdes = xmm023.bdes.
        END.    
       DISPLAY fi_ntbdes fi_notbrh WITH FRAME fr_cl.
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notby C-Win
ON LEAVE OF fi_notby IN FRAME fr_cl
DO:
  fi_notby = Input fi_notby.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_cl
DO:
  fi_notdat = Input fi_notdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nottim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nottim C-Win
ON LEAVE OF fi_nottim IN FRAME fr_cl
DO:
  fi_nottim = Input fi_nottim.            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ntbdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ntbdes C-Win
ON LEAVE OF fi_ntbdes IN FRAME fr_cl
DO:
  fi_ntbdes = Input fi_ntbdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ntitle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ntitle C-Win
ON LEAVE OF fi_ntitle IN FRAME fr_cl
DO:
  fi_ntitle = Input fi_ntitle.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poldes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poldes C-Win
ON LEAVE OF fi_poldes IN FRAME fr_cl
DO:
  fi_poldes = Input fi_poldes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_police
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_police C-Win
ON LEAVE OF fi_police IN FRAME fr_cl
DO:
       fi_police = CAPS(INPUT fi_police).

       IF fi_police <> " " THEN DO:
             FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                                   xtm600.acno = fi_police           NO-LOCK NO-ERROR.
             IF AVAIL xtm600 THEN
                  fi_poldes = TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name).
             ELSE DO:
                    FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                         xmm600.acno = fi_police              NO-LOCK NO-ERROR.
                    IF AVAIL xmm600 THEN fi_poldes = TRIM(xmm600.ntitle) + " "
                                                                               + TRIM(xmm600.name).
                    ELSE DO:
                           MESSAGE "This Code " fi_police "is not in file xmm600" 
                           VIEW-AS ALERT-BOX ERROR.
                           APPLY "ENTRY" TO fi_police.
                           RETURN NO-APPLY.
                    END.
             END.
      END.

      DISPLAY fi_police fi_poldes WITH FRAME fr_cl.

      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_cl
DO:
    
    fi_policy = input fi_policy.
    
    If fi_policy <> "" THEN DO:

       IF SUBSTR(fi_policy,3,1) = "7" THEN DO:
           MESSAGE "This Policy is Motor Vehicle." VIEW-AS ALERT-BOX WARNING.
           APPLY "ENTRY" TO fi_policy.
           RETURN NO-APPLY.
       END.
       ELSE DO:
           fi_policy   = Caps(Input fi_policy).
           nv_policy = fi_policy.
         /********* A47-0147 DATE 27/04/2004 *********************/
          IF n_polchk = NO OR s_policy  = "" THEN DO:
             FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                        uwm100.policy = fi_policy
             NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL uwm100 THEN DO:
                IF uwm100.cr_2 <> "" THEN DO:
                 
                   /*------- Add Chutikarn A50-0178 ------*/
                   /*----- 
                   IF SUBSTRING(uwm100.cr_2,1,1) = "D" THEN DO:
                       s_policy = fi_policy.
                       RUN Wcz\Wczchq30(INPUT-OUTPUT s_policy,
                                        INPUT-OUTPUT n_polchk).
                       fi_policy = s_policy.
                       s_policy = "".
                       DISPLAY fi_policy WITH FRAME fr_cl.
                   END.
                   ------*/
                   FIND FIRST buwm100 USE-INDEX uwm10001 WHERE
                              buwm100.policy = uwm100.cr_2 
                   NO-LOCK NO-ERROR.
                   IF AVAIL buwm100 THEN DO:
                       IF (SUBSTR(uwm100.cr_2,1,1)   = "D") OR
                          (SUBSTR(uwm100.cr_2,1,1)  >= "0" AND SUBSTR(uwm100.cr_2,1,1)  <= "9" )                           
                       THEN DO:
                           s_policy = fi_policy.
                           RUN Wcz\Wczchq30(INPUT-OUTPUT s_policy,
                                            INPUT-OUTPUT n_polchk).
                           fi_policy = s_policy.
                           s_policy = "".
                           DISPLAY fi_policy WITH FRAME fr_cl.
                       END.
                   END.
                   /*------- End Chutikarn A50-0178 ------*/
                   
/*                  Apply "Entry" To fi_policy.
 *                   Return No-Apply.*/
                END.
             END.
          END. /*n_polchk*/
         /********* A47-0147 DATE 27/04/2004 *********************/

          fi_policy  = CAPS(INPUT fi_policy).
          nv_policy = fi_policy.

          FIND LAST uwm100 USE-INDEX uwm10001 WHERE
                              uwm100.policy = fi_policy
          NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE uwm100 THEN DO:
                 IF uwm100.releas = No THEN DO:
                     MESSAGE "This Policy has not been release yet." 
                     VIEW-AS ALERT-BOX WARNING.
                     APPLY "ENTRY" TO fi_policy.
                     RETURN NO-APPLY.
                 END.

                ASSIGN
                   fi_rencnt = uwm100.rencnt
                   fi_endcnt = uwm100.endcnt
                   nv_polonf = "Y".
          END.
          ELSE DO:
             DISPLAY fi_policy WITH FRAME fr_cl.
          END.

          fi_poli = "".

          IF nv_polonf = "Y"  THEN DO:
                fi_poli = "Policy".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
          END.
          ELSE DO:
                fi_poli = "No Policy".
                fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                DISPLAY  fi_poli With Frame fr_cl.
          END.

          nv_riskgp = 0.
          fi_riskno = 1.
          fi_itemno = 1.
          DISPLAY fi_policy  fi_rencnt fi_endcnt fi_riskno  fi_itemno WITH FRAME fr_cl.
       END.
    END.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_riskno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_riskno C-Win
ON LEAVE OF fi_riskno IN FRAME fr_cl
DO:
    fi_riskno = input fi_riskno.  

    /* IF fi_riskno <> 000 THEN DO: Montrikon S. [A66-0067] */
    IF fi_riskno <> 00000 THEN DO:

       IF fi_riskno < 1 THEN DO:
           MESSAGE "Risk No. must not less than 1" View-As Alert-Box Error.
           APPLY  "ENTRY" TO fi_riskno.
           RETURN NO-APPLY.
       END.
    END.
       
       DISPLAY fi_riskno WITH FRAME fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_si
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_si C-Win
ON LEAVE OF fi_si IN FRAME fr_cl
DO:
  fi_si = Input fi_si.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surdt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surdt C-Win
ON LEAVE OF fi_surdt IN FRAME fr_cl
DO:
       fi_surdt = Input fi_surdt.
       
       IF fi_surdt <> ? THEN DO:
           /* Comment Jiraphon P. A63-0272
             IF fi_surdt < fi_accdte THEN 
                 MESSAGE "  Date Must be less than accept date  "
                 View-As Alert-Box Warning.
                 
            DISP fi_surdt WITH FRAME fr_cl.
            --*/
       END.
       ELSE fi_surdt = ?.
       DISP fi_surdt WITH FRAME fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surhr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surhr C-Win
ON LEAVE OF fi_surhr IN FRAME fr_cl
DO:
       fi_surhr = INPUT fi_surhr.
       IF fi_surhr > 24 OR fi_surhr < 0 THEN DO:
            MESSAGE "Must be in the range zero to 24" View-As Alert-Box Error.
            Apply "Entry"  To fi_surhr.
            Return No-Apply.
        END.
       DISPLAY fi_surhr WITH FRAME fr_cl.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surmin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surmin C-Win
ON LEAVE OF fi_surmin IN FRAME fr_cl
DO:
       fi_surmin = INPUT fi_surmin.
       IF fi_surmin > 59 OR fi_surmin < 0 THEN DO:
            MESSAGE "Must be in the range zero to 59" View-As Alert-Box Error.
            Apply "Entry" To fi_surmin.
            Return No-Apply.
       END.
       DISPLAY fi_surmin WITH FRAME fr_cl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_survy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_survy C-Win
ON LEAVE OF fi_survy IN FRAME fr_cl
DO:
  fi_survy = Caps(Input fi_survy).
  
      IF INPUT fi_survy <> "" THEN DO:

          FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                                xtm600.acno = fi_survy            NO-LOCK NO-ERROR.
          IF AVAIL xtm600
              THEN fi_surynam = TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name).
          ELSE DO:
             FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                   xmm600.acno = fi_survy              NO-LOCK NO-ERROR.
             IF AVAIL xmm600 THEN
                    fi_surynam = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
             ELSE DO:
                MESSAGE "This Code " fi_survy "is not in file xmm600" 
                VIEW-AS ALERT-BOX ERROR.
                APPLY "ENTRY" TO fi_survy.
                RETURN NO-APPLY.
             END.
          END.

          DISPLAY fi_survy fi_surynam WITH FRAME fr_cl.
       END.
       ELSE
          ASSIGN
             fi_survy   = ""
             fi_surynam = "".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surynam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surynam C-Win
ON LEAVE OF fi_surynam IN FRAME fr_cl
DO:
  fi_surynam = Input fi_surynam.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_telphn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_telphn C-Win
ON LEAVE OF fi_telphn IN FRAME fr_cl
DO:
  fi_telphn = Input fi_telphn.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_txtdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_txtdes C-Win
ON LEAVE OF fi_txtdes IN FRAME fr_cl
DO:
  fi_txtdes = Input fi_txtdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_userid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_userid C-Win
ON LEAVE OF fi_userid IN FRAME fr_cl
DO:
  fi_userid = Input fi_userid.
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wczo0005".
  gv_prog  = "NOTIFY ENTRY NON-MOTOR & CREATE NOTES (Not on File)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  

  RUN  WUT\WUTWICEN (c-win:handle).   
  Session:data-Entry-Return = Yes. 
    
    ASSIGN
      nv_polonf   = "N"
      fi_notdat   = TODAY 
      fi_accdte   = TODAY
      fi_acchr    = INT(SUBSTR(STRING(TIME,"HH:MM"),1,2))
      fi_accmin   = INT(SUBSTR(STRING(TIME,"HH:MM"),4,2))
      fi_event    = ""
      fi_losdat   = ?         
      nv_lostim   = ""
      fi_class    = ""
      fi_loclos   = ""
      fi_loclos2  = "" /*---Add clear location loss2 by Chaiyong W. A55-0293 13/09/2012*/
      nv_appoint  = ""        
      fi_notby    = ""
      fi_telphn   = ""        
      fi_accby    = ""
      fi_accnam   = ""        
      nv_acctim   = ""                                      
      fi_loss1    = ""        
      fi_loss2    = ""
      fi_loss3    = ""
      fi_nottim   = ""   
      fi_losmin   = 0
      fi_loshr    = 0
      nv_chkkey   = NO        
      nv_chk      = NO
      nv_default  = ""        
      nv_polsta   = ""  
      nv_riskgp   = 0         
      fi_riskno   = 0
      fi_itemno   = 0
      fi_police   = ""        
      fi_poldes   = ""
      fi_userid   =  USERID(LDBNAME(1))
      /*fi_notbrh   = SUBSTRING(fi_userid,6,1)-- A50-0178 --*/
      fi_notbrh   = TRIM(SUBSTRING(fi_userid,6,2)) /*-- A50-0178 --*/
      s_policy    = ""
      n_polchk    = NO
      nv_producer = ""
      nv_produnam = ""
      nv_dattim   = "".
     
    DISPLAY fi_accdte fi_notdat fi_acchr  fi_accmin fi_event  fi_losdat  
            fi_class  fi_loclos fi_notby  fi_telphn fi_accby  fi_accnam
            fi_loss1  fi_loss2  fi_loss3  fi_nottim fi_losmin fi_loshr
            fi_riskno fi_itemno fi_police fi_poldes fi_userid fi_notbrh 
        fi_loclos2 /*---Add disp location loss2 by Chaiyong W. A55-0293 13/09/2012*/
        WITH FRAME fr_cl.
              
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Chk_Dup C-Win 
PROCEDURE Chk_Dup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
        /* หาเบอร์ DUPLICATE */
          FIND FIRST  clm100 USE-INDEX clm10003 WHERE
                                 clm100.event = fi_event
          NO-LOCK NO-ERROR NO-WAIT.
          IF NOT AVAIL clm100 THEN DO:
                IF LOCKED clm100 THEN DO:
                     ASSIGN
                        fi_event  = ""
                        nv_notify = ""
                        fi_notdat = ?
                        fi_nottim = "".
               
                       MESSAGE   "Notify no." fi_event "ซ้ำที่ Claim No.:" clm100.claim  "โปรดบันทึกเลขNotify ใหม่."
                       VIEW-AS ALERT-BOX ERROR.
                       DISPLAY fi_event fi_notdat fi_nottim WITH FRAME fr_cl.
                       APPLY "ENTRY" TO fi_event.
                       RETURN NO-APPLY.
                END.
                ELSE DO:
                      nv_event1 = "".
                      nv_notify = fi_event.
                      /*fi_notdat = fi_accdte.      Comment Jiraphon P. A63-0272*/
                      fi_notdat = TODAY.            /*Add Jiraphon P. A63-0272*/
                      fi_nottim = nv_acctim.
                      DISPLAY  fi_event fi_notdat fi_nottim   WITH FRAME fr_cl.                
                      RUN Pro_Save.
                END.    
          END.
          ELSE DO:
              ASSIGN
                  fi_event  = ""
                  nv_notify = ""
                  nv_select = 0
                  fi_notdat = ?
                  fi_nottim = "".
                  MESSAGE   "Notify no." fi_event "ซ้ำที่ Claim No.:" clm100.claim  "โปรดบันทึกเลขNotify ใหม่."
                  VIEW-AS ALERT-BOX ERROR.
                  Run Pro_Select.
           END.
          
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
  DISPLAY fi_policy fi_rencnt fi_endcnt fi_riskno fi_itemno fi_insref fi_ntitle 
          fi_name1 fi_comdat fi_expdat fi_append fi_class fi_clsdes fi_itmtxt 
          fi_txtdes fi_si fi_notbrh fi_ntbdes fi_losdat fi_loshr fi_losmin 
          fi_userid fi_loclos fi_loclos2 fi_loss1 fi_loss2 fi_loss3 fi_cedclm 
          fi_police fi_poldes fi_nature fi_natdes fi_estim fi_cntact fi_ctel 
          fi_default fi_defdes fi_notby fi_telphn fi_accdte fi_acchr fi_accmin 
          fi_accby fi_accnam fi_survy fi_surynam fi_surdt fi_surhr fi_surmin 
          fi_event fi_notdat fi_nottim fi_display fi_poli 
      WITH FRAME fr_cl IN WINDOW C-Win.
  ENABLE fi_notbrh fi_ntbdes fi_losdat fi_loshr fi_losmin fi_userid fi_loclos 
         fi_loclos2 fi_loss1 fi_loss2 fi_loss3 fi_cedclm fi_police fi_poldes 
         fi_nature fi_natdes fi_estim fi_cntact fi_ctel fi_default fi_defdes 
         fi_notby fi_telphn fi_accdte fi_acchr fi_accmin fi_accby fi_accnam 
         fi_survy fi_surynam fi_surdt fi_surhr fi_surmin fi_event fi_notdat 
         fi_nottim bu_save bu_exit bu_new bu_print bu_police bu_default 
         bu_accby bu_survy RECT-3 RECT-4 
      WITH FRAME fr_cl IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_cl}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create C-Win 
PROCEDURE pd_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_DetailNote C-Win 
PROCEDURE Pd_DetailNote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------BEGIN A48-0046 Wantanee.S-------------*/ 
    ASSIGN
      chDocument:d_policy_no      = fi_policy
      chDocument:d_risk1          = STRING(fi_riskno,"99999") /* STRING(fi_riskno,"999") Montrikon S. [A66-0067] */
      chDocument:d_item1          = STRING(fi_itemno,"99999") /* STRING(fi_itemno,"999") Montrikon S. [A66-0067] */
      chDocument:d_location       = fi_notbrh
      chDocument:d_insured        = fi_insref + "    " + fi_ntitle + " " + fi_name1
      chDocument:d_period         = STRING(fi_comdat, "99/99/9999")
      chDocument:d_to             = STRING(fi_expdat, "99/99/9999")
      chDocument:d_loss_date      = STRING(fi_losdat, "99/99/9999")
      chDocument:d_time           = STRING(fi_loshr,"99") + ":" + STRING(fi_losmin,"99")
      chDocument:d_location1      = fi_loclos + " " + fi_loclos2 /*---Add by Chaiyong W. A55-0293 13/09/2012*/
      chDocument:police           = fi_police + "  "
      chDocument:police_disp      = fi_poldes
      chDocument:d_cause1         = fi_loss1
      chDocument:d_cause2         = fi_loss2
      chDocument:d_cause3         = fi_loss3                 
      chDocument:d_notify_by      = fi_notby   
      chDocument:d_telephone      = fi_telphn
      chDocument:d_default1       = fi_default
      chDocument:d_default2       = fi_defdes
      chDocument:d_accept_date    = STRING(fi_accdte, "99/99/9999")
      chDocument:d_accept_time    = STRING(fi_acchr,"99") + ":" + STRING(fi_accmin,"99") 
      chDocument:d_accept_by      = fi_accby
      chDocument:d_accept_name    = fi_accnam
      chDocument:d_notify_no      = fi_event
      chDocument:d_notify_date    = STRING(fi_notdat, "99/99/9999") + "  " + fi_nottim 
      chDocument:d_notfile        = fi_poli .       
/*--------------END A48-0046 Wantanee.S-------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_SentNote C-Win 
PROCEDURE Pd_SentNote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/ 

 /*------------BEGIN A48-0046 Wantanee.S-------------*/ 
 /*IF SUBSTRING(fi_policy,3,2) = "30" OR SUBSTRING(fi_policy,3,2) = "01" THEN DO: --A48-0469-*/
 IF SUBSTRING(fi_policy,3,2) = "30" OR 
    SUBSTRING(fi_policy,3,2) = "01" OR 
    SUBSTRING(fi_policy,3,2) = "04" THEN DO:

     ASSIGN
       /*nv_server   = "Safety_NotesServer/Safety" --Wantanee A48-0583 14/12/2005--*/
       /*nv_server   = "Safety_AppServer/Safety"   /*--Wantanee A48-0583 14/12/2005--*/ -- A50-0153 --*/
       nv_server   = "Safety_NotesServer/Safety" /*--Chutikarn A48-0153 06/06/2007--*/
       nv_tmp      = "safety\cl\f" + Substring(String(Year(Today)),3,2) + "_br_all.nsf" .  
              

     /*------ Add Chutikarn A50-0178 -------*/
     /*nv_lbranch = Substring(nv_policy, 2,1).*/
     IF SUBSTRING(nv_policy,1,1) = "D" OR
        SUBSTRING(nv_policy,1,1) = "I" OR
        SUBSTRING(nv_policy,1,1) = "C" OR 
        SUBSTRING(nv_policy,1,1) = "Q" THEN 
          nv_lbranch = Substring(nv_policy, 2,1).
     ELSE nv_lbranch = Substring(nv_policy, 1,2).
     /*------ End Chutikarn A50-0178 -------*/

     nv_dattim   = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").                 
                             
     CREATE "Notes.NotesSession"  chNotesSession.
     chNotesDatabase  = chNotesSession:GetDatabase (nv_server , nv_tmp).
  
     IF chNotesDatabase:IsOpen()  = NO THEN DO:
          MESSAGE "Can not open database" SKIP 
                  "Please Check database and serve" VIEW-AS ALERT-BOX ERROR .
          RETURN NO-APPLY.
     END.       

     chDocument  = chNotesDatabase:CreateDocument.
     chDocument:SAVE( TRUE, TRUE ).
    
     ASSIGN
       chDocument:NameCreate = chNotesSession:Username
       chDocument:Form       = "Filing"
       chDocument:Notify_NO  = fi_event
       chDocument:Policy_NO  = fi_policy
       chDocument:Name_In    = TRIM(fi_ntitle) + " " + fi_name1
       chDocument:producer   = nv_produnam
       chDocument:Date_Loss  = fi_losdat      
       chDocument:SumInsured = fi_si
       chDocument:reserve    = fi_estim  .
       /*nv_lbranch            = SUBSTRING(nv_policy, 2,1).-- A50-0178 */

     /*------------- Add chutikarn A50-0178 -------------*/
     
     chDocument:br = CAPS(nv_lbranch). 

     /* Table cvm006 เก็บว่า แต่ละสาขาอยู่ภาคไหน 
        เช่น 2 = North, 0 = Central              */ 
     /* ค่าใน Lotus Notes --> central <> Central */

     FIND FIRST cvm006 USE-INDEX cvm00601 WHERE 
                cvm006.iisbrn = nv_lbranch
     NO-LOCK NO-ERROR.
     IF AVAIL cvm006 THEN DO:
        IF CAPS(cvm006.branch) = "NORTH"     THEN chDocument:Region = "North"    .
        IF CAPS(cvm006.branch) = "SOUTH"     THEN chDocument:Region = "South"    .
        IF CAPS(cvm006.branch) = "EAST"      THEN chDocument:Region = "East"     .
        IF CAPS(cvm006.branch) = "WEST"      THEN chDocument:Region = "West"     .
        IF CAPS(cvm006.branch) = "NORTHEAST" THEN chDocument:Region = "Northeast".
        IF CAPS(cvm006.branch) = "CENTRAL"   THEN chDocument:Region = "Central"  .
        ELSE chDocument:Region = ""  .   
     END.
     ELSE DO:
        chDocument:Region = "".
     END.

     RUN Pd_DetailNote.
     /*--------------- End chutikarn A50-0178 -------------*/         
 END.
 ELSE DO:  /*Else n_polchk= No*/
 /*--------------END A48-0046 Wantanee.S-------------*/

     ASSIGN
       /*nv_server   = "Safety_NotesServer/Safety" --Wantanee A48-0583 14/12/2005--*/
       /*nv_server   = "Safety_AppServer/Safety"   /*--Wantanee A48-0583 14/12/2005--*/-- A50-0153 --*/

       /*---Test----
        nv_server   = ""
        nv_tmp      = "D:\Lotus\Notes\Data\safety\cl\nf" + SUBSTRING(STRING(YEAR(TODAY)),3,2) + "_br_all.nsf".
        ---Test---*/

       /*--- DB จริง */
       nv_server   = "Safety_NotesServer/Safety" /*--Chutikarn A50-0153 06/06/2007--*/
       nv_tmp      = "Safety\Cl\nf" + Substring(String(Year(Today)),3,2) + "_br_all.nsf". /*wantanee 04/01/05*/     
       /*---*/

     /*------ Add Chutikarn A50-0178 -------*/
     /*nv_lbranch = Substring(nv_policy, 2,1).*/
     IF SUBSTRING(nv_policy,1,1) = "D" OR
        SUBSTRING(nv_policy,1,1) = "I" OR
        SUBSTRING(nv_policy,1,1) = "C" OR 
        SUBSTRING(nv_policy,1,1) = "Q" THEN 
          nv_lbranch = Substring(nv_policy, 2,1).
     ELSE nv_lbranch = Substring(nv_policy, 1,2).
     /*------ End Chutikarn A50-0178 -------*/

     nv_dattim   = String(Today,"99/99/9999") + " " + String(Time,"HH:MM:SS").                
                             
     CREATE "Notes.NotesSession"  chNotesSession.
     chNotesDatabase  = chNotesSession:GetDatabase (nv_server , nv_tmp).
    
     IF chNotesDatabase:IsOpen()  = NO THEN DO:
          MESSAGE "Can not open database" SKIP 
                  "Please Check database and serve" VIEW-AS ALERT-BOX ERROR .
          RETURN No-Apply.
     END.
    
     chDocument  = chNotesDatabase:CreateDocument.
     chDocument:SAVE( TRUE, TRUE ).
    
     ASSIGN
        chDocument:NameCreate   = chNotesSession:Username
        chDocument:DateComposed = nv_dattim
        chDocument:Form         = "Filing"
        chDocument:Notify_NO    = fi_event
        chDocument:Policy_NO    = fi_policy
        chDocument:Name_In      = TRIM(fi_ntitle) + " " + fi_name1
        chDocument:producer     = nv_produnam
        chDocument:Date_Loss    = fi_losdat
        chDocument:CauseOfLoss  = TRIM(fi_loss1) + " " + 
                                  TRIM(fi_loss2) + " " +
                                  TRIM(fi_loss3)
        chDocument:SumInsured   = fi_si
        chDocument:reserve      = fi_estim        
        chDocument:adjuster     = fi_surynam.
        /*nv_lbranch            = SUBSTRING(fi_policy, 2,1). -- A50-0178 --*/
       
        /*-- Add A56-0028 by Narin --*/
        ASSIGN
            chDocument:Com_date         = STRING(fi_comdat, "99/99/9999")
            chDocument:Exp_date         = STRING(fi_expdat, "99/99/9999")
            chDocument:Locationofloss   = fi_loclos + " " + fi_loclos2
            chDocument:Retention        = nv_perret 
            chDocument:st_Surplus       = nv_per0t  
            chDocument:nd_Surplus       = nv_per0s  
            chDocument:Statutory        = nv_perstat
            chDocument:TFP              = nv_per0q  
            chDocument:QuotaShar        = nv_per0rq 
            chDocument:F01              = nv_perf1  
            chDocument:F02              = nv_perf2  
            chDocument:F03              = nv_pers8  
            chDocument:F04              = nv_perf4  
            chDocument:OTR              = nv_per0tr 
            chDocument:BTR              = nv_perbtr 
            chDocument:FTR              = nv_perftr 
            chDocument:MPS              = nv_per0ps 
            chDocument:Localfac         = nv_perrb  
            chDocument:Foreignfac       = nv_perrf  
            chDocument:TOTAL            = nv_siper.

        /*-- End Add A56-0028 by Narin --*/

     IF nv_lbranch = "0"   OR
        nv_lbranch = "L"   OR
        nv_lbranch = "M"   OR
        nv_lbranch = "W"   OR
        nv_lbranch = "V"   
     THEN chDocument:br = "0".
     ELSE chDocument:br = CAPS(nv_lbranch). 

     /*-------- Add Chutikarn A50-0178 --------*/
 END.

 chDocument:SAVE( TRUE, TRUE ).

 RELEASE OBJECT   chNotesSession.    
 RELEASE OBJECT   chNotesDataBase. 
 RELEASE OBJECT   chDocument.                                                                                           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProClear C-Win 
PROCEDURE ProClear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
              ASSIGN
                nv_polonf  = " "    fi_surynam = " "   fi_policy   = " "
                nv_poltyp  = " "    nv_dir_ri  = ?     nv_policy  = " "
                nv_recip   = " "    nv_co_per  = 0     nv_prloss  = 0
                nv_vehves  = " "    nv_addr1   = " "   nv_recid   = 0
                nv_occlim  = " "    fi_comdat  = ?     nv_recid2  = 0
                nv_sicurr  = " "    fi_itmtxt  = " "   fi_rencnt  = 0
                nv_cedco   = " "    nv_notbrh1 = " "   fi_endcnt  = 0
                nv_styp20  = " "    nv_oldic   = " "   fi_loss2   = " "
                nv_addr2   = " "    n_cnt      = 0     fi_ctel    = " "
                fi_expdat  = ?      fi_txtdes  = " "   fi_insref  = " "
                fi_ntbdes  = " "    fi_ntitle  = " "   fi_name1   = " "
                fi_survy   = " "    fi_loss3   = " "   nv_addr3   = " "
                fi_surhr   = 0      nv_cntry   = " "   fi_si      = 0
                nv_postcd  = " "    fi_losdat  = ?     nv_billco  = " "
                nv_distct  = " "    nv_surdef  = " "   fi_estim   = 0
                fi_defdes  = " "    fi_clsdes  = " "   nv_condit  = " "
                fi_notbrh  = " "    fi_surdt   = ?     fi_loss1   = " "
                nv_undyr   = " "    fi_cntact  = " "   nv_dept    = " "
                nv_coins   = ?      nv_condes  = " "   nv_vesno   = " "
                fi_acchr   = INT(SUBSTR(STRING(TIME,"HH:MM"),1,2))
                nv_pcrisk  = " "     fi_cedclm = ""
                fi_accmin  = INT(SUBSTR(STRING(TIME,"HH:MM"),4,2))
                nv_langug  = " "    nv_cedpol  = " "   fi_surmin = 0
                nv_sval20  = " "    nv_acno1   = " "   nv_agent  = " "
                nv_nextno  = 0      nv_cn_no   = 0     n_s       = " "
                nv_opnpol = " "     nv_name    = " "   nv_icno   = " "
                nv_name2  = " "     nv_name3   = " "   nv_cedces = " "
                nv_fname  = " "     nv_finint  = " "   nv_addr4  = " "
                nv_notify = " "     nv_type1   = " "
                nv_producer = ""
                nv_produnam = ""    nv_rico_t = 0
                nv_dattim = ""
                fi_nature =  ""     fi_natdes = ""  
                nv_polonf = "N".
                fi_acchr  = INT(SUBSTR(STRING(TIME,"HH:MM"),1,2)).
                fi_accmin = INT(SUBSTR(STRING(TIME,"HH:MM"),4,2)).
                fi_userid = USERID(LDBNAME(1)).
                /*fi_notbrh = SUBSTRING(fi_userid,6,1).-- A50-0178 --*/
                fi_notbrh = TRIM(SUBSTRING(fi_userid,6,2)). /*-- A50-0178 --*/

                ASSIGN  fi_event    = ""        fi_losdat   = ?
                        nv_lostim   = ""        fi_class    = ""
                        fi_loclos   = ""        nv_appoint  = ""
                        fi_notby    = ""        fi_telphn   = ""
                        fi_accby    = ""        fi_accnam   = ""
                        fi_accdte   = TODAY     nv_acctim   = ""
                        fi_nottim   = ""        fi_notdat   = TODAY
                        fi_losmin   = 0         fi_loshr    = 0
                        nv_chkkey   = NO        nv_chk      = NO
                        fi_default  = ""        nv_polsta   = ""
                        nv_riskgp   = 0         fi_riskno   = 0
                        fi_itemno   = 0
                        fi_police   = ""        fi_poldes   = ""
                        fi_append   = ""        fi_poli     = ""     
                        s_policy    = ""        n_polchk    = NO
                        fi_loclos2  = "" /*---Add By Chaiyong W. A55-0293 13/09/2012*/
                    .
               /*----Begin by Chaiyong W. A58-0117 16/05/2015*/
               FOR EACH w_rico:
                   DELETE w_rico.
               END.
               /*End by Chaiyong W. A58-0117 16/05/2015------*/


               fi_poli:FGCOLOR IN FRAME fr_cl = 19.
               fi_poli:BGCOLOR IN FRAME fr_cl = 19.   
               fi_event:BGCOLOR IN FRAME fr_cl = 19.
               fi_notdat:FGCOLOR IN FRAME fr_cl = 2.                
               fi_notdat:BGCOLOR IN FRAME fr_cl = 19.                
               fi_nottim:BGCOLOR IN FRAME fr_cl = 19.                
               fi_comdat:FGCOLOR IN FRAME fr_cl = 2.    
               fi_comdat:BGCOLOR IN FRAME fr_cl = 19.    
               fi_expdat:FGCOLOR IN FRAME fr_cl = 2.    
               fi_expdat:BGCOLOR IN FRAME fr_cl = 19.    
               Disable fi_event With Frame fr_cl.
                                             
              Display 
                    fi_expdat     fi_ntbdes      fi_survy      fi_surhr     fi_notbrh
                    fi_acchr      fi_accmin      fi_surynam    fi_comdat    fi_itmtxt
                    fi_loss3      fi_losdat      fi_clsdes     fi_surdt     fi_cntact
                    fi_surmin     fi_loss1       fi_estim      fi_si        fi_name1
                    fi_insref     fi_ctel        fi_loss2      fi_endcnt    fi_rencnt
                    fi_policy     fi_userid      fi_event      fi_loclos    fi_notby
                    fi_accby      fi_accdte      fi_nottim     fi_losmin    fi_police
                    fi_append     fi_losdat      fi_class      fi_telphn    fi_accnam
                    fi_notdat     fi_loshr       fi_riskno     fi_poldes    fi_poli
                    fi_txtdes     fi_ntitle      fi_itemno     fi_nature    fi_natdes
                    fi_default    fi_defdes      fi_cedclm  
                    fi_loclos2   /*---Add disp location loss2 by Chaiyong W. A55-0293 13/09/2012*/
              With Frame fr_cl.
    
              Apply  "Entry" To fi_policy.
              Return No-Apply.
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Print C-Win 
PROCEDURE Pro_Print :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
         FIND clm100 WHERE clm100.event = fi_event NO-LOCK NO-ERROR.
         IF AVAIL clm100 THEN nv_recid = RECID(clm100).

         Run Wcz\Wczx1(Input-Output nv_out).
      
         nv_output    = nv_out.
  
         IF     SEARCH("CTHAI3L.EXE")  <> ?  THEN DO:
                IF   nv_output    = "PRINTER"  THEN DO:
                     /*--
                      nv_output2   = "C:\3L" +
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2) +
                         ".TMP".
                     comment BY Narin L A57-0012 26/03/2014*/
                   /*----Begin by Narin L A57-0012 21/04/2014*/
                       RUN wuw\wuwrtemp(OUTPUT nv_output2).
                       nv_output2   =   nv_output2 + "3L" + 
                                      SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                                      SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +
                                      SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2) +
                                      ".TMP".
                   /*End by Narin L A57-0012 21/04/2014------*/
                     OUTPUT STREAM nf1 TO VALUE(nv_output2)  PAGED  PAGE-SIZE 40.
                END.
                ELSE
                     OUTPUT STREAM nf1 TO VALUE(nv_output)   PAGED  PAGE-SIZE 40.
        END.
        ELSE DO:
            IF  SEARCH("CTHAI3L.TXT")  <> ?  THEN DO:
                OS-DELETE  CTHAI3L.TXT.
            END.
            OUTPUT STREAM nf1  TO VALUE(nv_output)  PAGED  PAGE-SIZE  40.
        END.

        PUT STREAM nf1 CONTROL CHR(27) + CHR(64) + CHR(18).
        PUT STREAM nf1 CONTROL CHR(27) + CHR(77).
        PUT STREAM nf1 CONTROL CHR(27) + CHR(69) .
        PUT STREAM nf1 SKIP.

        n_insname = TRIM(TRIM(fi_ntitle) + " " + TRIM(fi_name1)).

        /*-------- Add Chutikarn A50-0178 ---------*/
        nv_polno  = CAPS(SUBSTRING(fi_policy,1,2)) + "-" +
                         SUBSTRING(fi_policy,3,2)  + "-" +
                         SUBSTRING(fi_policy,5,2)  + "/" +
                         SUBSTRING(fi_policy,7,6).
        /*-------- End Chutikarn A50-0178 ---------*/

        PUT STREAM nf1 " เลขที่เรื่อง    " AT 64 .
        PUT STREAM nf1 fi_event.

        PUT STREAM nf1 CONTROL CHR(27) + CHR(80).
        PUT STREAM nf1 "ใบรับแจ้ง NON-MOTOR" AT 30 SKIP(1).

        PUT STREAM nf1 CONTROL CHR(27) + CHR(77).
        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    ผู้เอาประกัน  ".
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 n_insname FORMAT "X(35)".

        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    เลขที่กรมธรรม์  ".
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 nv_polno SKIP.

        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    วันที่เกิดเหตุ  ".
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 fi_losdat.

        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    เวลา   " AT 54.
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 fi_loshr ":" fi_losmin SKIP.

        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    ลักษณะการเกิดเหตุ  ".
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 fi_loss1 SKIP.
        PUT STREAM nf1 " " FORMAT "X(23)" fi_loss2 SKIP.
        PUT STREAM nf1 " " FORMAT "x(23)" fi_loss3 SKIP(1).

        PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
        PUT STREAM nf1 "    ทรัพย์สินที่เสียหายและค่าเสียหายโดยประมาณ ".
        PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
        PUT STREAM nf1 fi_estim " Baht" SKIP.

        FIND clm100 USE-INDEX clm10003 WHERE clm100.event = fi_event NO-LOCK NO-ERROR.
        IF AVAIL clm100 THEN DO:
        FIND FIRST cld100 WHERE RECID(cld100) = clm100.fptr01 NO-LOCK NO-ERROR.
        IF AVAIL cld100 THEN DO:
             nv_recid1 = RECID(cld100).
             n_count   = 1.
             REPEAT WHILE nv_recid1 <> 0 :
                    IF n_count = 1 THEN DO:
                       FIND cld100 WHERE RECID(cld100) = nv_recid1 NO-ERROR.
                       IF NOT AVAIL cld100 THEN LEAVE.
                       ASSIGN
                           n_ltext1  = cld100.ltext
                           nv_recid1 = cld100.fpt
                           n_count   =  n_count + 1
                           n_point2  = INDEX(n_ltext1,"SURVEYOR")
                           n_point   = INDEX(n_ltext1,"TEL").
    
                   PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                   PUT STREAM nf1 "    บุคคลที่ติดต่อเพื่อตรวจสอบ ".
                   PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                   PUT STREAM nf1 SUBSTRING(n_ltext1,15,n_point - 15) FORMAT "x(40)" .
                   PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                   PUT STREAM nf1 "โทร " .
                   PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                   PUT STREAM nf1 SUBSTRING(n_ltext1,n_point + 3,n_point2 -(n_point + 3) ) FORMAT "x(40)"  SKIP.

               END.
               ELSE LEAVE.
         END.
      END.

          PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
          PUT STREAM nf1 "    ผู้แจ้ง ".
          PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
          PUT STREAM nf1 fi_notby .

          PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
          PUT STREAM nf1 "    โทร ".
          PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
          PUT STREAM nf1 fi_telphn  SKIP.

          PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
          PUT STREAM nf1 "    วันที่แจ้ง ".
          PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
          PUT STREAM nf1 fi_notdat  .

          PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
          PUT STREAM nf1 "    เวลา ".
          PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
          PUT STREAM nf1 fi_nottim  .
        
          PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
          PUT STREAM nf1 "    ผู้รับแจ้ง(ชื่อที่อ่านได้) ".
          PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
          PUT STREAM nf1 fi_accnam  SKIP.
          PUT STREAM nf1
          "    ------------------------------------------------------------------------------------" SKIP.
    
          n_point  = INDEX(n_ltext1,"SURVEYOR").
          n_point2 = INDEX(n_ltext1,"DATE").
        
          IF SUBSTR(n_ltext1,n_point + 9,2) <> " " THEN DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "    แจ้งเซอร์เวย์บริษัท ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1  SUBSTR(n_ltext1,n_point + 9,n_point2 - (n_point + 9)) FORMAT "x(20)".
          END.
          ELSE DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "    แจ้งเซอร์เวย์บริษัท ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1 "............." .
          END.

          IF SUBSTR(n_ltext1,n_point2 + 5,2) <> "00" THEN DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "  เมื่อวันที่ ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1  SUBSTR(n_ltext1,n_point2 + 5 ,10) FORMAT "x(10)".
          END.
          ELSE DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "  เมื่อวันที่ ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1 ".........." .
          END.

          n_point = INDEX(n_ltext1,"TIME").

          IF SUBSTR(n_ltext1,n_point2 + 5,2) <> "00" THEN DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "  เวลา ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1  SUBSTR(n_ltext1,n_point + 5 ,5).
          END.
          ELSE DO:
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(69).
                 PUT STREAM nf1 "  เวลา ".
                 PUT STREAM nf1 CONTROL CHR(27) + CHR(70).
                 PUT STREAM nf1 ".........." .
          END.

          FIND FIRST cld100 WHERE RECID(cld100) = clm100.fptr01 NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL cld100 THEN DO:
               n_count = 1.
               nv_recid1 = recid(cld100).
               REPEAT WHILE nv_recid1 <> 0:
                      IF n_count = 1 THEN DO:
                         FIND cld100 WHERE RECID(cld100) = nv_recid1 NO-ERROR.
                         IF NOT AVAIL cld100 THEN LEAVE.
                             n_count = n_count + 1.
                             nv_recid1 = cld100.fptr.
                      END.
                      ELSE IF n_count > 1 THEN DO:

                             FIND cld100 WHERE RECID(cld100) = nv_recid1 NO-ERROR.
                             IF NOT AVAIL cld100 THEN LEAVE.
                             n_text = cld100.ltext.
                             PUT STREAM nf1 cld100.ltext FORMAT "X(75)" SKIP.
                             PUT STREAM nf1 " " FORMAT "X(5)".
                              nv_recid1 = cld100.fptr.
                      END.
               END.
          END.
    END.
    PUT STREAM nf1 CONTROL NULL.
    OUTPUT STREAM nf1 CLOSE.
    
    IF  nv_output  = "PRINTER"  THEN DO:
          IF   SEARCH("CTHAI3L.EXE")  <> ?  THEN DO:
               OS-COMMAND  SILENT  cthai3l  -c2  -s1  VALUE(nv_output2)  > VALUE("LPT1:").
               OS-DELETE   VALUE(nv_output2).
          END.
   END.
         
   MESSAGE "Print To" nv_out "Complete" View-As Alert-Box Information.
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Save C-Win 
PROCEDURE Pro_Save :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF fi_surdt <> ? THEN DO:
  nv_ltext1 = "CONTACT PERSON " + fi_cntact + "TEL. " + fi_ctel
              + "SURVEYOR " + fi_surynam + "DATE "
              + STRING(fi_surdt,"99/99/9999")
              + "TIME " + STRING(fi_surhr,"99") +
              ":" + STRING(fi_surmin,"99") .
END.
ELSE DO:
  nv_ltext1 = "CONTACT PERSON " + fi_cntact + "TEL. " + fi_ctel
              + "SURVEYOR " + fi_surynam + "DATE "
              + "00/00/0000"
              + "TIME " + STRING(fi_surhr,"99") +
              ":" + STRING(fi_surmin,"99") .
END.

IF fi_notby <> "" THEN DO:
   IF fi_telphn <> "" THEN
      nv_appoint = fi_notby + " Tel." + fi_telphn.
   ELSE
      nv_appoint = fi_notby.
END.
ELSE
   nv_appoint = "".

FIND clm100 USE-INDEX clm10003 WHERE
     clm100.event = fi_event   NO-ERROR NO-WAIT.
IF NOT AVAIL clm100 THEN DO:
   CREATE clm100.
   nv_recid2 = RECID(clm100).

   ASSIGN
     clm100.policy = fi_policy
     clm100.losdat = fi_losdat
     clm100.riskgp = nv_riskgp
     clm100.riskno = fi_riskno
     clm100.itemno = fi_itemno
     clm100.vehves = nv_vehves
     clm100.s_no   = CAPS(fi_event)
     clm100.event  = CAPS(fi_event)
     clm100.branch = fi_notbrh
     clm100.claim  = fi_event
     clm100.notdat = fi_notdat
     clm100.finclo = fi_notdat      /* keng 15/3/2001 */
     clm100.lostim = nv_lostim
     clm100.rencnt = fi_rencnt
     clm100.endcnt = fi_endcnt
     clm100.comdat = fi_comdat
     clm100.expdat = fi_expdat
     clm100.undyr  = nv_undyr
     clm100.opnpol = nv_opnpol
     clm100.cntry  = nv_cntry
     clm100.dir_ri = nv_dir_ri
     clm100.dept   = nv_dept
     clm100.agent  = nv_agent
     clm100.poltyp = nv_poltyp
     clm100.insref = fi_insref
     clm100.ntitle = fi_ntitle
     clm100.fname  = nv_fname
     clm100.name1  = fi_name1
     clm100.name2  = nv_name2
     clm100.name3  = nv_name3
     clm100.addr1  = nv_addr1
     clm100.addr2  = nv_addr2
     clm100.addr3  = nv_addr3
     clm100.addr4  = nv_addr4
     clm100.postcd = nv_postcd
     clm100.cedco  = nv_cedco
     clm100.cedpol = nv_cedpol
     clm100.cedces = nv_cedces
     clm100.recip  = nv_recip
     clm100.coins  = nv_coins
     clm100.billco = nv_billco
     clm100.styp20 = nv_styp20
     clm100.sval20 = nv_sval20
     clm100.finint = nv_finint
     clm100.class  = fi_class
     clm100.sicurr = nv_sicurr
     clm100.loss1  = fi_loss1
     clm100.loss2  = fi_loss2
     clm100.loss3  = fi_loss3
     clm100.cedclm = " "
     clm100.revid  = " "
     clm100.revtim = " "
     clm100.prloss = nv_prloss
     clm100.topay  = 0
     clm100.paid   = 0
     clm100.res_t  = 0
     clm100.revdat = ?
     clm100.entid  = fi_userid
     clm100.entdat = fi_notdat
     clm100.enttim = fi_nottim
     clm100.ProgId_Ent = "WCZO0005" /*----Add Yosawee M. A68-0044 11/06/2025----*/
     clm100.polonf = "Y"
     clm100.fptr01 = 0
     clm100.bptr01 = 0
     clm100.co_per = nv_co_per
     clm100.tot_ri = 0
     clm100.icno   = nv_icno
     clm100.oldic  = nv_oldic
     clm100.cn_no  = nv_cn_no
     clm100.nottim = fi_nottim
     clm100.defau  = fi_default
     clm100.assi   = nv_appoint
     clm100.losloc1= fi_loclos
     clm100.losloc2= fi_loclos2 /*---Add update location loss2 by Chaiyong W. A55-0293 13/09/2012*/
     clm100.acno1  = nv_acno1
     clm100.bs_cd  = "CZO101"
     clm100.police = fi_accby
     clm100.vesno  = nv_vesno
     clm100.distct = nv_distct
     clm100.occlim = nv_occlim
     clm100.pcrisk = nv_pcrisk
     clm100.d_post = fi_police                  /*A46-0220*/

                                                /* sombat 10/01/2003 */
     clm100.driold = fi_append                  /*APPEND POLICY*/
     clm100.cedclm = fi_cedclm
     clm100.repdat = fi_accdte.    /*Add Jiraphon P. A63-0272*/

   RELEASE CLM100.
    

   FIND clm102 WHERE clm102.claim = fi_event NO-ERROR.
   IF NOT AVAIL clm102 THEN DO:
      CREATE clm102.
      ASSIGN clm102.claim  = CAPS(fi_event)
             clm102.clstat = "O"
             clm102.stcaus = " "
             clm102.stdat  = fi_notdat
             clm102.entid  = fi_userid
             clm102.entdat = fi_notdat
             clm102.enttim = fi_nottim.
   END.

   FIND clm110 WHERE clm110.claim  = fi_event AND
                     clm110.clmant = 1        NO-ERROR.
   IF NOT AVAIL clm110 THEN DO:
      CREATE clm110.
      ASSIGN clm110.claim  = fi_event
             clm110.clmant = 1
             clm110.stcaus = " "
             clm110.clmdat = fi_notdat
             clm110.ntitle = fi_ntitle
             clm110.fname  = nv_fname
             clm110.clname = fi_name1
             clm110.caddr1 = nv_addr1
             clm110.caddr2 = nv_addr2
             clm110.caddr3 = nv_addr3
             clm110.caddr4 = nv_addr4
             clm110.clmdat = fi_notdat
             clm110.postcd = nv_postcd
             clm110.icno   = nv_icno
             clm110.oldic  = nv_oldic
             clm110.entid  = fi_userid /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm110.entdat = fi_notdat /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm110.enttim = fi_nottim /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm110.ProgId_Ent = "WCZO0005". /*----Add Yosawee M. A68-0044 11/06/2025----*/ 
   END.

   FIND clm120 WHERE clm120.claim  = fi_event  AND
                     clm120.clmant = 1         AND
                     clm120.clitem = 1         AND
                     clm120.itemno = fi_itemno NO-ERROR.
   IF NOT AVAIL clm120 THEN DO:
      CREATE clm120.
      ASSIGN clm120.claim  = fi_event
             clm120.clmant = 1
             clm120.clitem = 1
             clm120.itemno = fi_itemno
             clm120.si     = fi_si
             clm120.intref = fi_accby
             clm120.extref = fi_survy
             clm120.loss   = fi_nature
             clm120.entid  = fi_userid /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm120.entdat = fi_notdat /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm120.enttim = fi_nottim /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm120.ProgId = "WCZO0005". /*----Add Yosawee M. A68-0044 11/06/2025----*/
   END.


   FIND FIRST clm131 WHERE clm131.claim  = fi_event AND
                           clm131.clmant = 1        AND
                           clm131.clitem = 1        AND
                           clm131.cpc_cd = "EPD"    NO-ERROR.
   IF NOT AVAIL clm131 THEN DO:
      CREATE clm131.
      ASSIGN clm131.claim  = fi_event
             clm131.clmant = 1
             clm131.clitem = 1
             clm131.cpc_cd = "EPD"
             clm131.trndat = fi_notdat
             clm131.entdat = fi_notdat
             clm131.enttim = fi_nottim
             clm131.entid  = fi_userid
             clm131.progid = "WCZO0005" /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm131.res    = fi_estim.
   END.

   FIND clm131 WHERE clm131.claim  = fi_event AND
                     clm131.clmant = 1        AND
                     clm131.clitem = 1        AND
                     clm131.cpc_cd = "ERC"    NO-ERROR.
   IF NOT AVAIL clm131 THEN DO:
      CREATE clm131.
      ASSIGN clm131.claim  = fi_event
             clm131.clmant = 1
             clm131.clitem = 1
             clm131.cpc_cd = "ERC"
             clm131.trndat = fi_notdat
             clm131.entdat = fi_notdat
             clm131.enttim = fi_nottim
             clm131.entid  = fi_userid
             clm131.progid = "WCZO0005" /*----Add Yosawee M. A68-0044 11/06/2025----*/
             clm131.res    = 0 .
   END.

END. /* END IF AVAIL clm100 */



FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR NO-WAIT.
IF AVAIL clm100 THEN DO:
   FOR EACH uwd200 USE-INDEX uwd20001 WHERE
            uwd200.policy = fi_policy  AND
            uwd200.rencnt = fi_rencnt AND
            uwd200.endcnt = fi_endcnt AND
            uwd200.riskgp = nv_riskgp AND
            uwd200.riskno = fi_riskno NO-LOCK BREAK  BY uwd200.policy
                                       BY uwd200.rencnt BY uwd200.endcnt
                                       BY uwd200.csftq  BY uwd200.rico
                                       BY uwd200.riskgp BY uwd200.riskno
                                       BY uwd200.c_enct:
   /*-------add by jeab 28/08/03---------*/
      
     FIND FIRST w_rico  WHERE
          w_rico.riskno = uwd200.riskno AND
          w_rico.rico  = uwd200.rico    NO-LOCK NO-ERROR NO-WAIT.
     IF NOT AVAIL w_rico THEN DO:
        CREATE w_rico.
        ASSIGN
          w_rico.riskno = uwd200.riskno
          w_rico.rico   = uwd200.rico
          w_rico.risi   = uwd200.risi
          w_rico.risi_p = uwd200.risi_p.
          nv_rico_t     = nv_rico_t + uwd200.risi_p.
          /*--    Add Narin A56-0028--*/
         
                IF uwd200.rico = "STAT"  THEN DO:
                   ASSIGN
                     w_rico.wt_perstat =  uwd200.risi_p
                     nv_perstat        =  w_rico.wt_perstat.
                END.
            
                IF uwd200.rico = "0RET"  THEN DO:
                   ASSIGN
                     w_rico.wt_perret = uwd200.risi_p
                     nv_perret        = w_rico.wt_perret.
                END.
                 
                IF SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO:
                   ASSIGN
                     w_rico.wt_per0q =  uwd200.risi_p
                     nv_per0q        =  w_rico.wt_per0q.
                END.
            
                IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                   SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
                   ASSIGN
                     w_rico.wt_per0t =  uwd200.risi_p
                     nv_per0t        =  w_rico.wt_per0t.
                END.
                    
                IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                   SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
                   ASSIGN
                     w_rico.wt_per0s =  uwd200.risi_p
                     nv_per0s        =  w_rico.wt_per0s.
                END.

                IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                   SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
                   ASSIGN
                     w_rico.wt_perf1 =  uwd200.risi_p
                     nv_perf1        =  w_rico.wt_perf1.
                END.
                IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                   SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
                   ASSIGN
                     w_rico.wt_perf2 =  uwd200.risi_p
                     nv_perf2        =  w_rico.wt_perf2.
                END.
                
                IF SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                   ASSIGN
                     w_rico.wt_per0rq =  uwd200.risi_p
                     nv_per0rq        =  w_rico.wt_per0rq.
                END.
            
               IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:
                  ASSIGN
                    w_rico.wt_per0ps =  uwd200.risi_p
                    nv_per0ps        =  w_rico.wt_per0ps.
               END.
            
               IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
                  SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                  ASSIGN
                    w_rico.wt_perbtr =  uwd200.risi_p
                    nv_perbtr        =  w_rico.wt_perbtr.
               END.

               IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
                  SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                  ASSIGN
                    w_rico.wt_per0tr =  uwd200.risi_p
                    nv_per0tr        =  w_rico.wt_per0tr.
               END.
            
               IF (SUBSTRING (uwd200.rico,1,4) = "0TA8" AND SUBSTRING (uwd200.rico,7,1) = "2" )  
                  OR (SUBSTRING (uwd200.rico,1,2) = "0T"  AND SUBSTRING (uwd200.rico,6,2) = "F3")    /* A44-0012  -> เพิ่ม F3 (Munich Re.) */
               THEN DO:
                  ASSIGN
                    w_rico.wt_pers8 =  uwd200.risi_p
                    nv_pers8        =  w_rico.wt_pers8.
               END.

               IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
                  ASSIGN
                    w_rico.wt_perf4 =  uwd200.risi_p
                    nv_perf4        =  w_rico.wt_perf4.
               END.
           
               IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                  SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                  ASSIGN
                    w_rico.wt_perftr =  uwd200.risi_p
                    nv_perftr        =  w_rico.wt_perftr.
               END.

               IF uwd200.rico    <> ""   AND 
                  uwd200.csftq   = "F"   THEN DO:
               FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                          xmm600.acno =  uwd200.rico NO-LOCK NO-ERROR. 
               
                   IF AVAIL xmm600  THEN DO:
                          /*-- Client type & A/C  type --*/
                          /* RD = Insurnace Domestic */
                       IF (xmm600.clicod = "RD") OR 
                          (xmm600.clicod = "RB" AND xmm600.acccod = "RD") THEN
                       ASSIGN
                         w_rico.wt_perrb = w_rico.wt_perrb   +  uwd200.risi_p
                         nv_perrb = w_rico.wt_perrb.    
                          /* RF = Insurance Foreign
                             RB = Reinsurance Broker 
                             RA = Reinsurance Asian */
                          ELSE IF  ( (xmm600.clicod = "RF") OR 
                                     (xmm600.clicod = "RB" AND xmm600.acccod = "RF" ) ) OR
                                   ( (xmm600.clicod = "RA") OR 
                                     (xmm600.clicod = "RB" AND xmm600.acccod = "RA" ) ) THEN
                                 
                          ASSIGN
                            w_rico.wt_perrf =  w_rico.wt_perrf  +  uwd200.risi_p
                            nv_perrf        =  w_rico.wt_perrf.
                            
                   END. /* IF AVAIL xmm600  THEN DO: */ 
               END.  /*  IF uwd200.rico    <> ""   AND */
               ASSIGN 
               nv_siper =   nv_perstat  +
                            nv_perret   +
                            nv_per0q    +
                            nv_per0t    +
                            nv_per0s    +
                            nv_perf1    +
                            nv_perf2    +
                            nv_per0rq   +
                            nv_per0ps   +
                            nv_perbtr   +
                            nv_per0tr   +
                            nv_pers8    +
                            nv_perf4    +
                            nv_perftr   +
                            nv_perrb    +
                            nv_perrf .
              
                /*-- End Add Narin A56-0028--*/  
     END.
      /*---------end by jeab---------------*/
     IF FIRST-OF(uwd200.c_enct) THEN DO:
     FIND FIRST uwm200 USE-INDEX uwm20001     WHERE
                uwm200.policy = uwd200.policy AND
                uwm200.rencnt = uwd200.rencnt AND
                uwm200.endcnt = uwd200.endcnt AND
                uwm200.csftq  = uwd200.csftq  AND
                uwm200.rico   = uwd200.rico   AND
                uwm200.c_enct = uwd200.c_enct NO-LOCK NO-ERROR.
     CREATE clm300.
     ASSIGN
       clm300.claim  = fi_event
       clm300.csftq  = uwd200.csftq
       clm300.risi_p = uwd200.risi_p
       clm300.c_no   = uwm200.c_no
       clm300.recip  = uwm200.recip
       clm300.thpol  = uwm200.thpol
       clm300.c_year = uwm200.c_year
       clm300.vcount = 0
       clm300.pladat = ?
       clm300.tclaim = ""
       /*clm300.entid  = substring(gv_id,3,6)-- A50-0178 --*/
       clm300.entid  = substring(gv_id,3,7)  /*-- A50-0178 --*/
       clm300.entdat = today
       clm300.enttim = string(time,"HH:MM:SS").

       IF clm300.csftq = "C" then clm100.co_per = clm100.co_per + clm300.risi_p.

       IF Index("DFT",clm300.csftq) <> 0 THEN DO:
         clm100.tot_ri = clm100.tot_ri + clm300.risi_p.
       END.

       FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                  xmm600.acno = uwd200.rico NO-LOCK NO-ERROR.
       IF AVAIL   xmm600 THEN DO:
         IF xmm600.relate <> " " then clm300.rico = xmm600.relate.
                                 else clm300.rico = uwd200.rico.
       END.
       ELSE clm300.rico = uwd200.rico.
    END. /* first c_enct */
  END. /* for each uwd200  */

  /*----

   IF nv_rico_t <> 100 THEN  DO:  /* jeab 28/08/03*/
       nv_rskno  =  fi_riskno.

     RUN Wcz\Wczprico(INPUT nv_rskno,
                      INPUT fi_policy).
  END.
  ------*/
END.  /* avail clm100 */

FIND clm100 WHERE RECID(clm100) = nv_recid2 NO-ERROR NO-WAIT.

FIND cld100 WHERE RECID(cld100) = clm100.fptr01 NO-ERROR.
IF NOT AVAIL cld100 THEN DO:
   CREATE cld100.
   ASSIGN
     cld100.ltext  =  nv_ltext1
     cld100.bptr   = 0
     cld100.fptr   = 0
     cld100.claim  = fi_event
     clm100.fptr01 = RECID(cld100)
     clm100.bptr01 = RECID(cld100).

END.
      IF fi_event = "" THEN LEAVE.
          nv_event1 = fi_event.  

          nv_chk = yes.
          IF nv_polonf = "Y" THEN DO:
                  fi_poli = "Policy".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
          END.
          ELSE DO:
                  fi_poli = "No Policy".
                  fi_poli:FGCOLOR IN FRAME fr_cl = 15.
                  fi_poli:BGCOLOR IN FRAME fr_cl = 9.       
                  DISPLAY  fi_poli With Frame fr_cl.
          END.
    
    Run Pd_SentNote.

    Message "Save Complete" View-As Alert-Box Information.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Select C-Win 
PROCEDURE Pro_Select :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      RUN WCZ\WCZO0002(Input-Output nv_notify,
                       Input-Output nv_select).

   /******* KEY NOTIFY **********************/                                   
     IF nv_select  = 2  THEN DO:
          IF nv_notify = "" THEN DO:
              Enable fi_event With Frame fr_cl.
              fi_event:FGCOLOR IN FRAME fr_cl = 2.
              fi_event:BGCOLOR IN FRAME fr_cl = 15.               
              Apply "Entry" To fi_event.
              Return No-Apply.
          END.  
      END.    
    /********** EXIT **************************/
      ELSE IF nv_select = 1 THEN DO:
           Apply "Close" To This-Procedure.
      END.   
    /********* RUN NOTIFY NO. ***********/
      ELSE IF nv_select = 3 THEN DO:   
           fi_event = nv_notify.
      
           IF YEAR(TODAY) <= 2003 THEN DO:
                loop_xmm603:
                REPEAT:
                     FIND FIRST xmm603 USE-INDEX xmm60301  WHERE
                                xmm603.branch =  fi_notbrh AND
                                xmm603.poltyp =  "N00"     NO-ERROR.
                     IF NOT AVAILABLE xmm603 THEN DO:
                            IF  LOCKED xmm603 THEN DO:
                                 MESSAGE " Record is being used ".
                                 NEXT loop_xmm603.
                            END.
                            ELSE DO:
                                CREATE xmm603.
                                ASSIGN xmm603.branch = CAPS(fi_notbrh)
                                       xmm603.nextno = 2
                                       nv_nextno     = 1.
                            END.
                     END.
                     ELSE DO:
                          nv_nextno     = xmm603.nextno.
                          xmm603.nextno = xmm603.nextno + 1.
                     END.
                     LEAVE loop_xmm603.
               END. /* END REPEAT */

                  fi_event  = "N" + fi_notbrh + SUBSTR((STRING(YEAR(TODAY) + 543)),3,2)
                              + STRING(nv_nextno,"999999").
                    Disable fi_event  With Frame fr_cl.   
                    fi_event:FGCOLOR IN FRAME fr_cl = 7.
                    fi_event:BGCOLOR IN FRAME fr_cl = 6. 
                    fi_notdat:FGCOLOR IN FRAME fr_cl = 7.
                    fi_notdat:BGCOLOR IN FRAME fr_cl = 6.  
                    fi_nottim:FGCOLOR IN FRAME fr_cl = 7.
                    fi_nottim:BGCOLOR IN FRAME fr_cl = 6.  
                    Disp fi_event fi_notdat  fi_nottim  With Frame fr_cl.                                                 
                                                         
            END.
            ELSE DO:
                 /* มากกว่า ปี 2003 */
                loop_xmm603:
                REPEAT:

                    FIND FIRST xmm603 USE-INDEX xmm60301  WHERE
                               xmm603.branch =  ( TRIM(CAPS(fi_notbrh))
                                                  + SUBSTR((STRING(YEAR(TODAY) + 543)),3,2))  AND        
                               xmm603.poltyp =  "N00"  NO-ERROR.
                    IF NOT AVAILABLE xmm603 THEN DO:
                       IF  LOCKED xmm603 THEN DO:
                            MESSAGE " Record is being used " VIEW-AS ALERT-BOX WARNING.
                            NEXT loop_xmm603.
                       END.
                       ELSE DO:
                           CREATE xmm603.
                            ASSIGN
                                xmm603.branch =  ( TRIM(CAPS(fi_notbrh)) + SUBSTR((STRING(YEAR(TODAY) + 543)),3,2))
                                xmm603.poltyp =  "N00"
                                xmm603.nextno = 2
                                nv_nextno     = 1.
                       END.
                    END.
                    ELSE DO:
                       nv_nextno     = xmm603.nextno.
                       xmm603.nextno = xmm603.nextno + 1.
                    END.
                    LEAVE loop_xmm603.
                END. /* END REPEAT */

                fi_event  = "N" + fi_notbrh + SUBSTR((STRING(YEAR(TODAY) + 543)),3,2) + STRING(nv_nextno,"999999").
                Disable fi_event  With Frame fr_cl.   
                fi_event:FGCOLOR IN FRAME fr_cl = 7.
                fi_event:BGCOLOR IN FRAME fr_cl = 6. 
                fi_notdat:FGCOLOR IN FRAME fr_cl = 7.
                fi_notdat:BGCOLOR IN FRAME fr_cl = 6.  
                fi_nottim:FGCOLOR IN FRAME fr_cl = 7.
                fi_nottim:BGCOLOR IN FRAME fr_cl = 6.  
                Disp fi_event fi_notdat  fi_nottim  With Frame fr_cl.                
            END.
                RELEASE xmm603.   /*Check Lock User*/
                RUN Chk_Dup.               /*Check Duplicate*/
               /* RUN Pro_Save.   */          /* S A V E   N O T I F Y */              
                nv_chk = Yes.              

          END.      /* IF nv_select  = 3                 R u n  Notify No. */
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

