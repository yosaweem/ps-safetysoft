&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME wgwtrn70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtrn70 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------
 Modify By : Porntiwa P.  A57-0300   08/09/2014  
           : ปรับแสดงค่า Make/Model ให้สามารถดูว่าเป็นค่าว่างหรือไม่
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/*Modify by : Chaiyong W. A57-0096 04/06/2014                           */
/*            Add check branch                                          */
/*--------------------------------------------------------------------------------------*/
/*Modify by : Tantawan Ch. A57-0231  30/09/2014                                         */
/*            - เพิ่มการ Release Policy to Account                                      */
/*            จะเข้าเงื่อนไข release เฉพาะกรมธรรม์ที่ Transfer เข้า Premium ได้เท่านั้น */
/*            - ตัดการ put file dup. ออก เพื่อลดจำนวนไฟลื,ยังไม่มีโปรแกรม put record dup*/
/*            - เพิ่ม user id ไว้หน้าไฟล์ที่ put เพื่อแยกว่าเป็นไฟล์ของ user ใคร        */
/*--------------------------------------------------------------------------------------*/
/*Modify by : Chaiyong W. A57-0365 24/11/2014                           */
/*            correct format Batch no                                   */
/*----------------------------------------------------------------------*/
/* Modify BY : Porntiwa P.   A58-0143   14/05/2015                      
             : Comment การ Check เงื่อนไขต่ออายุ                        */
/*----------------------------------------------------------------------*/ 
/*Modify by : Chaiyong W. A57-0462 08/07/2015                           */
/*            add chk aeon                                              */
/*----------------------------------------------------------------------*/
/* Modify By : Porntiwa P. A58-0424  11/11/2015                         */
/*           : Check Data Release                                       */
/*----------------------------------------------------------------------*/
/* Modify By : Thitirat  A58-0424  01/11/2015
             : Check Document Dup.                                      */
/*----------------------------------------------------------------------*/ 
/* Modify By : Porntiwa P.  A58-0480  03/12/2015
             : Check Message Error                                      */
             /* Modify by : Chaiyong W. A59-0312 07/07/2016                     */
/*             correct st. releas and create vat                   */ 
/*----------------------------------------------------------------------*/        
/* Modify By : Rachan I. A61-0545   15/11/2018                          */
/*             แก้ไขข้อความerrorที่แสดงตอนtransferเข้า table acm002     */
/*----------------------------------------------------------------------*/ 
/* Modify By : Jiraphon P. A62-0286  Date : 17/06/2019 
             : แก้ไข Program ID (uwm100.prog)  ให้กำหนด program id 
               ตามงานที่ผ่าน On-web , Web-service , Outsource
------------------------------------------------------------------------*/
/* Modify By : Kridtiya i. Assign A63-00029 Date. 17/02/2020 ขยาย docno 7 > 15*/   
/* Modify By : Kridtiya i. Assign A63-00029 Date. 20/02/2020 ปรับ INTEGER(sic_bran.uwm100.docno1) เป็น เช็ค ค่าว่าง */
/* Modify By : Jiraphon P. A64-0115 Date: 08/03/2021 fix database stat.symprog*/
/* Modify By : Jiraphon P. A64-0038 Date: 05/04/2021  เนื่องมี ลูปที่ check account type ที่ยังไม่ได้ comment ออกจึงทำให้ account type ที่ เป็น DI ไม่สามารถโอนงานได้*/
/* Modify By : Kridtiya i. A64-0199 Date: 16/10/2021 เพิ่มการเช็คทะเบียนรถ */
/*Modify by : Chaiying w. A66-0116 08/09/2023            */
/*          : add Transfer                               */   
/*Modify by : Chaiying w. A66-0255 07/12/2023            */
/*          : add check idno compulsory                  */  
/*Modify by : Jiraphon P. A67-0181 
              เช็ครหัส พรบ ไฟฟ้าเก่าห้ามโอน              */ 
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR.

DEF SHARED VAR n_user     AS   CHAR.
DEF SHARED VAR nv_recid     AS RECID . 
DEF SHARED VAR nv_recid1    AS RECID . 

DEF VAR nv_duprec100 AS LOGICAL.

DEF VAR nv_batchyr   AS INT.
DEF VAR nv_batchno   AS CHAR.
DEF VAR nv_batcnt    AS INT.

DEF VAR nv_total     AS CHAR.
DEF VAR nv_start     AS CHAR.
DEF VAR nv_timestart AS INT.
DEF VAR nv_timeend   AS INT.
DEF VAR nv_polmst    AS CHAR.


DEF VAR nv_brnfile   AS CHAR. 
DEF VAR nv_duprec    AS CHAR.
DEF VAR nv_Insno     AS CHAR.

DEF VAR nv_Policy   AS CHAR.
DEF VAR nv_RenCnt   AS INT FORMAT ">9".
DEF VAR nv_EndCnt   AS INT FORMAT "999".
DEF VAR nv_Branch   AS CHAR.
DEF VAR nv_next     AS LOGICAL.
DEF VAR nv_message  AS CHAR FORMAT "X(200)".
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.

DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.
/*Add Jiraphon P. A62-0286*/
DEFINE NEW SHARED WORKFILE wkacm002 NO-UNDO /* LIKE acm002 */
  FIELD ac1       LIKE sicsyac.acm002.ac1    
  FIELD ac2       LIKE sicsyac.acm002.ac2    
  FIELD ac3       LIKE sicsyac.acm002.ac3    
  FIELD ac4       LIKE sicsyac.acm002.ac4    
  FIELD ac5       LIKE sicsyac.acm002.ac5    
  FIELD ac6       LIKE sicsyac.acm002.ac6    
  FIELD ac7       LIKE sicsyac.acm002.ac7    
  FIELD acccod    LIKE sicsyac.acm002.acccod 
  FIELD acno      LIKE sicsyac.acm002.acno  FORMAT "X(10)" 
  FIELD agent     LIKE sicsyac.acm002.agent FORMAT "X(10)" 
  FIELD ac_mth    LIKE sicsyac.acm002.ac_mth 
  FIELD ac_yr     LIKE sicsyac.acm002.ac_yr  
  FIELD amt1      LIKE sicsyac.acm002.amt1   
  FIELD amt2      LIKE sicsyac.acm002.amt2   
  FIELD amt3      LIKE sicsyac.acm002.amt3   
  FIELD amt4      LIKE sicsyac.acm002.amt4   
  FIELD amt5      LIKE sicsyac.acm002.amt5   
  FIELD amt6      LIKE sicsyac.acm002.amt6   
  FIELD amt7      LIKE sicsyac.acm002.amt7   
  FIELD amtl1     LIKE sicsyac.acm002.amtl1  
  FIELD amtl2     LIKE sicsyac.acm002.amtl2  
  FIELD amtl3     LIKE sicsyac.acm002.amtl3  
  FIELD amtl4     LIKE sicsyac.acm002.amtl4  
  FIELD amtl5     LIKE sicsyac.acm002.amtl5  
  FIELD amtl6     LIKE sicsyac.acm002.amtl6  
  FIELD amtl7     LIKE sicsyac.acm002.amtl7  
  FIELD bal       LIKE sicsyac.acm002.bal    
  FIELD baloc     LIKE sicsyac.acm002.baloc  
  FIELD bankno    LIKE sicsyac.acm002.bankno 
  FIELD bpayp     LIKE sicsyac.acm002.bpayp  
  FIELD bptr01    LIKE sicsyac.acm002.bptr01 
  FIELD branch    LIKE sicsyac.acm002.branch 
  FIELD cedco     LIKE sicsyac.acm002.cedco FORMAT "X(10)" 
  FIELD cedent    LIKE sicsyac.acm002.cedent         
  FIELD cedno     LIKE sicsyac.acm002.cedno  
  FIELD cedref    LIKE sicsyac.acm002.cedref 
  FIELD cheqpr    LIKE sicsyac.acm002.cheqpr 
  FIELD cheque    LIKE sicsyac.acm002.cheque 
  FIELD chqptd    LIKE sicsyac.acm002.chqptd 
  FIELD clicod    LIKE sicsyac.acm002.clicod 
  FIELD cn_no     LIKE sicsyac.acm002.cn_no  
  FIELD comdat    LIKE sicsyac.acm002.comdat 
  FIELD comm      LIKE sicsyac.acm002.comm   
  FIELD curcod    LIKE sicsyac.acm002.curcod 
  FIELD daddr1    LIKE sicsyac.acm002.daddr1 
  FIELD daddr2    LIKE sicsyac.acm002.daddr2 
  FIELD daddr3    LIKE sicsyac.acm002.daddr3 
  FIELD daddr4    LIKE sicsyac.acm002.daddr4 
  FIELD dept      LIKE sicsyac.acm002.dept   
  FIELD detal1    LIKE sicsyac.acm002.detal1 
  FIELD detal2    LIKE sicsyac.acm002.detal2 
  FIELD disput    LIKE sicsyac.acm002.disput 
  FIELD dname     LIKE sicsyac.acm002.dname  
  FIELD docaie    LIKE sicsyac.acm002.docaie 
  FIELD docbr     LIKE sicsyac.acm002.docbr  
  FIELD docho     LIKE sicsyac.acm002.docho  
  FIELD dociln    LIKE sicsyac.acm002.dociln 
  FIELD docno     LIKE sicsyac.acm002.docno FORMAT "X(10)"
  FIELD docp      LIKE sicsyac.acm002.docp   
  FIELD dpostc    LIKE sicsyac.acm002.dpostc 
  FIELD entdat    LIKE sicsyac.acm002.entdat 
  FIELD enttim    LIKE sicsyac.acm002.enttim 
  FIELD erldat    LIKE sicsyac.acm002.erldat 
  FIELD fee       LIKE sicsyac.acm002.fee    
  FIELD fptr01    LIKE sicsyac.acm002.fptr01 
  FIELD glupd     LIKE sicsyac.acm002.glupd  
  FIELD insno     LIKE sicsyac.acm002.insno  
  FIELD insref    LIKE sicsyac.acm002.insref  FORMAT "x(10)" 
  FIELD instot    LIKE sicsyac.acm002.instot 
  FIELD mlno      LIKE sicsyac.acm002.mlno   
  FIELD mltyp1    LIKE sicsyac.acm002.mltyp1 
  FIELD netamt    LIKE sicsyac.acm002.netamt 
  FIELD netloc    LIKE sicsyac.acm002.netloc 
  FIELD policy    LIKE sicsyac.acm002.policy 
  FIELD poltyp    LIKE sicsyac.acm002.poltyp 
  FIELD prem      LIKE sicsyac.acm002.prem   
  FIELD prog      LIKE sicsyac.acm002.prog   
  FIELD recno     LIKE sicsyac.acm002.recno  
  FIELD ref       LIKE sicsyac.acm002.ref    
  FIELD stamp     LIKE sicsyac.acm002.stamp  
  FIELD tax       LIKE sicsyac.acm002.tax    
  FIELD thcess    LIKE sicsyac.acm002.thcess 
  FIELD tranbr    LIKE sicsyac.acm002.tranbr 
  FIELD trangp    LIKE sicsyac.acm002.trangp 
  FIELD tranho    LIKE sicsyac.acm002.tranho 
  FIELD trndat    LIKE sicsyac.acm002.trndat 
  FIELD trnty1    LIKE sicsyac.acm002.trnty1 
  FIELD trnty2    LIKE sicsyac.acm002.trnty2 
  FIELD usrid     LIKE sicsyac.acm002.usrid FORMAT "X(7)" 
  Field langug    like sicsyac.acm002.langug
  FIELD vehreg    LIKE sicsyac.acm002.vehreg
  FIELD rencnt    LIKE sicsyac.acm001.rencnt
  FIELD endcnt    LIKE sicsyac.acm001.endcnt.
/*End Add Jiraphon P. A62-0286*/
DEF BUFFER wk_uwm100 FOR sic_bran.uwm100.
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF NEW SHARED STREAM ns3.
DEF NEW SHARED STREAM ns5.
DEF NEW SHARED STREAM ns6.


DEF WORKFILE w_chkbr
    FIELD branch   AS CHAR FORMAT "X(2)" 
    FIELD producer AS CHAR FORMAT "X(10)".
    
DEF WORKFILE w_polno
    FIELD trndat AS DATE FORMAT "99/99/9999"
    FIELD polno  AS CHAR FORMAT "X(20)"
    FIELD ntitle AS CHAR FORMAT "X(20)"
    FIELD name1  AS CHAR FORMAT "X(30)"
    FIELD rencnt AS INT  FORMAT "999"
    FIELD endcnt AS INT  FORMAT "999"
    FIELD trty11 AS CHAR FORMAT "X"
    /*FIELD docno1 AS CHAR FORMAT "X(7)"     /*A62-0286*/*/
    FIELD docno1 AS CHAR FORMAT "X(10)"      /*A62-0286*/
    FIELD agent  AS CHAR FORMAT "X(10)"
    FIELD acno1  AS CHAR FORMAT "X(10)"
    FIELD bchyr  AS INT FORMAT "9999"
    FIELD bchno  AS CHAR FORMAT "X(13)"
    FIELD bchcnt AS INT FORMAT "99"
    FIELD releas AS LOGICAL INIT NO
    /*--- A57-0300 ---*/
    FIELD modcod AS CHAR FORMAT "X(10)"
    FIELD moddes AS CHAR FORMAT "X(30)"
    /*--- A57-0300 ---*/
    .

DEF VAR nv_des    AS CHAR    INIT "".
DEF VAR nv_csuc   AS INT     INIT 0. /*count successs*/
DEF VAR nv_cnsuc  AS INT     INIT 0. /*Count not success*/

DEFINE            VAR nv_chk    AS   CHAR FORMAT "X".
DEFINE            VAR nv_vat    AS   LOGICAL .        /*18/02/2002*/
DEFINE            VAR nv_uwd132 AS   LOGICAL .        /*28/05/2003*/

/* A57-0361 */
DEF VAR nv_brnfile1   AS CHAR. 
DEF VAR nv_duprec1    AS CHAR.
DEF VAR nv_errfile1   AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.



DEF VAR nv_trnyes   AS LOGICAL  INIT NO  NO-UNDO.
DEF VAR s_recid1    AS RECID             NO-UNDO.  /* uwm100.recid */
DEF VAR gv_acm001OK AS LOG.
DEF VAR gv_acm002OK AS LOG.

DEF VAR nv_relok    AS INT.
DEF VAR nv_relerr   AS INT.
DEF VAR nv_relyet   AS LOG.
/*--- END --- A57-0361 ---*/

DEF VAR nv_chkre  AS CHAR INIT "YES".  /*---Add by Chaiyong A58-0123 23/06/2015*/

DEF VAR nv_suscess  AS INT.
DEFINE VAR nv_message1 AS CHAR FORMAT "X(200)".
DEFINE VAR nv_progid AS CHAR FORMAT "X(200)".

DEFINE VAR nv_vehreg AS CHAR.                             /*Add Jiraphon P. A64-0199*/
DEFINE VAR nv_digit  AS CHAR INIT "0,1,2,3,4,5,6,7,8,9".  /*Add Jiraphon P. A64-0199*/
DEFINE VAR nv_count    AS INTE INIT 0.                      /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
DEFINE VAR nv_statusck AS CHAR INIT "no".                   /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
/*Add A67-0181*/
DEF BUFFER buwm120 FOR sic_bran.uwm120.   
DEF VAR n_classchk AS CHAR.
DEF VAR n_classtyp AS CHAR.
/*End A67-0181*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_uwm100

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES w_polno

/* Definitions for BROWSE br_uwm100                                     */
&Scoped-define FIELDS-IN-QUERY-br_uwm100 w_polno.trndat w_polno.polno STRING(w_polno.RenCnt,"99") + "/" + STRING(w_polno.EndCnt,"999") w_polno.ntitle + " " + w_polno.name1 w_polno.trty11 w_polno.docno1 /* Kridtiya i. Assign A63-00029 Date. 17/02/2020 ขยาย docno 7 > 15*/ /*--- A57-0300 --*/ w_polno.modcod w_polno.moddes /*--- A57-0300 --*/ w_polno.agent w_polno.acno1 w_polno.bchyr w_polno.bchno w_polno.bchcnt w_polno.releas   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwm100   
&Scoped-define SELF-NAME br_uwm100
&Scoped-define QUERY-STRING-br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno
&Scoped-define OPEN-QUERY-br_uwm100 OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
&Scoped-define TABLES-IN-QUERY-br_uwm100 w_polno
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwm100 w_polno


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_uwm100 fi_TrnDate fi_trndatt fi_acno ~
bu_refresh fi_Policyfr fi_Policyto bu_exit bu_Transfer fi_brdesc fi_brnfile ~
fi_TranPol fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk ~
fi_relerr fi_duprec to_chk RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 RECT-3 
&Scoped-Define DISPLAYED-OBJECTS fi_acdes fi_TrnDate fi_trndatt fi_acno ~
fi_Branch fi_Policyfr fi_Policyto fi_brdesc fi_brnfile fi_TranPol ~
fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk fi_relerr ~
fi_duprec to_chk 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtrn70 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "EXIT" 
     SIZE 16 BY 1.43
     FONT 6.

DEFINE BUTTON bu_refresh 
     IMAGE-UP FILE "wimage/flipu.bmp":U
     LABEL "" 
     SIZE 11.17 BY 1.14.

DEFINE BUTTON bu_Transfer 
     LABEL "TRANSFER TO PREMIUN" 
     SIZE 27.33 BY 1.43
     FONT 6.

DEFINE VARIABLE fi_acdes AS CHARACTER FORMAT "X(30)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Branch AS CHARACTER FORMAT "X(2)":U 
      VIEW-AS TEXT 
     SIZE 5.17 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 27 BY 1
     FONT 36 NO-UNDO.

DEFINE VARIABLE fi_brnfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_duprec AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_errfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_File AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Policyfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Policyto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_relerr AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_relOk AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_strTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TotalTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TranPol AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TrnDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatt AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 1.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 30 BY 2.14
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-636
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-640
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 1.52
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-649
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78.67 BY 10.57.

DEFINE VARIABLE to_chk AS LOGICAL INITIAL no 
     LABEL "No-Print" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.5 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_uwm100 FOR 
      w_polno SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwm100 wgwtrn70 _FREEFORM
  QUERY br_uwm100 DISPLAY
      w_polno.trndat COLUMN-LABEL "Trn Date"       FORMAT "99/99/9999"
w_polno.polno  COLUMN-LABEL "Policy No"      FORMAT "X(14)"
STRING(w_polno.RenCnt,"99") + "/" +  STRING(w_polno.EndCnt,"999") COLUMN-LABEL "R/E"
w_polno.ntitle + " "  + w_polno.name1 COLUMN-LABEL "Insure" FORMAT "X(25)"
w_polno.trty11 COLUMN-LABEL "Ty1"            FORMAT "X"
w_polno.docno1 COLUMN-LABEL "Doc.no.1"       FORMAT "X(15)"  /*   Kridtiya i. Assign A63-00029 Date. 17/02/2020 ขยาย docno 7 > 15*/   
/*--- A57-0300 --*/
w_polno.modcod COLUMN-LABEL "Model Code"     FORMAT "X(9)"
w_polno.moddes COLUMN-LABEL "Make Detail"    FORMAT "X(25)"
/*--- A57-0300 --*/
w_polno.agent  COLUMN-LABEL "Agent Code"     FORMAT "X(10)"
w_polno.acno1  COLUMN-LABEL "Account no."    FORMAT "X(10)"
w_polno.bchyr  COLUMN-LABEL "Bch Year"       FORMAT "9999"
w_polno.bchno  COLUMN-LABEL "Bch No."        FORMAT "X(20)"
w_polno.bchcnt COLUMN-LABEL "Batch Cnt."     FORMAT "99"
w_polno.releas COLUMN-LABEL "Releas"         FORMAT "Yes/No"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130.5 BY 12.14 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_uwm100 AT ROW 5.29 COL 2
     fi_acdes AT ROW 3.81 COL 78.5 COLON-ALIGNED
     fi_TrnDate AT ROW 2.48 COL 61.5 COLON-ALIGNED NO-LABEL
     fi_trndatt AT ROW 2.48 COL 83 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 3.81 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 2.62 COL 121.17
     fi_Branch AT ROW 2.57 COL 9.17 COLON-ALIGNED NO-LABEL
     fi_Policyfr AT ROW 19.1 COL 87 COLON-ALIGNED NO-LABEL
     fi_Policyto AT ROW 20.29 COL 87 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 25.48 COL 115.17
     bu_Transfer AT ROW 25.52 COL 84.83
     fi_brdesc AT ROW 2.52 COL 15 COLON-ALIGNED NO-LABEL
     fi_brnfile AT ROW 18.91 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_TranPol AT ROW 20 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_errfile AT ROW 22.19 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_strTime AT ROW 24.43 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 24.43 COL 45.17 COLON-ALIGNED NO-LABEL
     fi_TotalTime AT ROW 24.43 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_File AT ROW 21.1 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_relOk AT ROW 25.57 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_relerr AT ROW 26.71 COL 27 COLON-ALIGNED NO-LABEL
     fi_duprec AT ROW 23.29 COL 27.33 COLON-ALIGNED NO-LABEL
     to_chk AT ROW 2.67 COL 104.5
     "From" VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 19.05 COL 81.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Account Code :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 3.86 COL 44.67
          FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.17 BY .95 AT ROW 20.24 COL 85
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Update File" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 21.05 COL 16.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Transfer Error put to file" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 22.14 COL 5.17
          BGCOLOR 19 FGCOLOR 5 FONT 6
     "To" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 2.48 COL 79.5
          FONT 6
     "Transfer policy" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 20 COL 13.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Policy No. Write to file" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 18.91 COL 6.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Start Time" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 24.43 COL 17.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Total" VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 24.43 COL 60.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "End" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 24.48 COL 42
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "    Show Detail Transfer" VIEW-AS TEXT
          SIZE 78 BY .95 AT ROW 17.67 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Policy Duplicate put to file" VIEW-AS TEXT
          SIZE 25.67 BY .95 AT ROW 23.29 COL 2.67
          BGCOLOR 19 FGCOLOR 5 FONT 6
     "   Policy Transfer" VIEW-AS TEXT
          SIZE 51 BY .95 AT ROW 17.67 COL 81
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Branch :" VIEW-AS TEXT
          SIZE 8.17 BY 1 AT ROW 2.62 COL 1.67
          FONT 6
     "Query Batch No Transfer Motor Policy To Premium" VIEW-AS TEXT
          SIZE 53.5 BY .91 AT ROW 1.24 COL 42.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Tran.Date From" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 2.48 COL 44.5
          FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.83 BY 27.52.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Policy Release Completed" VIEW-AS TEXT
          SIZE 25.33 BY .95 AT ROW 25.57 COL 3
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Policy Release Error" VIEW-AS TEXT
          SIZE 20.17 BY .95 AT ROW 26.71 COL 8.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     RECT-1 AT ROW 1.05 COL 1.33
     RECT-636 AT ROW 5.05 COL 1.5
     RECT-2 AT ROW 25.14 COL 131.5 RIGHT-ALIGNED
     RECT-640 AT ROW 2.43 COL 120.5
     RECT-649 AT ROW 17.57 COL 2.33
     RECT-3 AT ROW 25.14 COL 112.5 RIGHT-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.83 BY 27.52.


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
  CREATE WINDOW wgwtrn70 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwtrn70 : Query Batch No Transfer Motor Policy To Premium"
         HEIGHT             = 27.43
         WIDTH              = 132.83
         MAX-HEIGHT         = 46.43
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.43
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
IF NOT wgwtrn70:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtrn70
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_uwm100 1 fr_main */
/* SETTINGS FOR FILL-IN fi_acdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Branch IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME fr_main
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-3 IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn70)
THEN wgwtrn70:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_uwm100
/* Query rebuild information for BROWSE br_uwm100
     _START_FREEFORM
OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_uwm100 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwtrn70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn70 wgwtrn70
ON END-ERROR OF wgwtrn70 /* wgwtrn70 : Query Batch No Transfer Motor Policy To Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn70 wgwtrn70
ON WINDOW-CLOSE OF wgwtrn70 /* wgwtrn70 : Query Batch No Transfer Motor Policy To Premium */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwm100
&Scoped-define SELF-NAME br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrn70
ON ROW-DISPLAY OF br_uwm100 IN FRAME fr_main
DO:
    /*--- Add A57-0300 ---*/
    IF w_polno.modcod = "" THEN DO:

        w_polno.polno :BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.
        w_polno.modcod:BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.
        w_polno.moddes:BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.

        w_polno.polno :FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
        w_polno.modcod:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
        w_polno.moddes:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.

        w_polno.polno :FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
        w_polno.modcod:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
        w_polno.moddes:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.

    END.
    /*--- End A57-0300 ---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrn70
ON VALUE-CHANGED OF br_uwm100 IN FRAME fr_main
DO:
  /*--- Add A58-0424 ---*/
  FIND CURRENT w_polno NO-LOCK NO-ERROR.
  IF NOT AVAIL w_polno THEN DO:
  END.
  ELSE DO:
      DISPLAY w_polno.polno @ fi_policyfr WITH FRAME fr_main.
  END.
  /*--- End A58-0424 ---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtrn70
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
APPLY  "CLOSE"  TO THIS-PROCEDURE.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh wgwtrn70
ON CHOOSE OF bu_refresh IN FRAME fr_main
DO:
    /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
    ASSIGN
        fi_trndate = INPUT fi_trndate
        fi_Trndatt = INPUT fi_Trndatt
        fi_acno = CAPS(TRIM(INPUT fi_acno)).

    
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.

    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.
    /*End  by Chaiyong W. A57-0096 04/06/2014----*/

    RUN PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer wgwtrn70
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* TRANSFER TO PREMIUN */
DO:
/* sic_bran = gw_Safe
   brStat   = gw_sate */

    /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
    ASSIGN
        fi_trndate  = INPUT fi_trndate
        fi_Trndatt  = INPUT fi_Trndatt
        fi_acno     = CAPS(TRIM(INPUT fi_acno))
        fi_policyfr = INPUT fi_policyfr
        fi_policyto = INPUT fi_policyto
        to_chk      = INPUT to_chk  /*---Add by Chaiyong A58-0462 08/07/2015*/
        .

    
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.


    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.
    
    IF fi_policyfr = "" THEN DO:
        MESSAGE "Policy From is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyfr.
        RETURN NO-APPLY.
    END.

    IF fi_policyto = "" THEN DO:
        MESSAGE "Policy To is mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyto.
        RETURN NO-APPLY.
    END.

    IF fi_policyfr > fi_policyto THEN DO:
        MESSAGE "Policy From ต้องน้อยกว่า Policy TO" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyto.
        RETURN NO-APPLY.
    END.
    /*End by Chaiyong W. A57-0096 04/06/2014-----*/


ASSIGN
 fi_brnfile   = ""
 fi_TranPol   = ""
 fi_File      = ""
 fi_errfile   = "" 
 fi_strTime   = "" 
 fi_time      = "" 
 fi_TotalTime = ""
 nv_Insno   = ""
 nv_total     = ""
 nv_start     = STRING(TIME,"HH:MM:SS")
 fi_strTime   = STRING(TIME,"HH:MM:SS")
 nv_timestart = TIME
 nv_timeend   = TIME
 nv_polmst    = "".

 /* A57-0361 */
ASSIGN
 fi_relOk = ""
 fi_relerr = ""
    
 nv_relok  = 0
 nv_relerr = 0 .
 /* A57-0361 */ 


 /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
 nv_csuc  = 0.
 nv_cnsuc = 0.
 /*End by Chaiyong W. A57-0096 04/06/2014-----*/


 /*---Begin by Chaiyong W. A57-0462 23/06/2015*/
IF TO_chk = YES THEN
    nv_chkre = "NO".
ELSE nv_chkre = "YES".
/*End by Chaiyong W. A57-0462 23/06/2015-----*/

/*
nv_errfile   = "C:\GWTRANF\" +                    
                       STRING(MONTH(TODAY),"99")    + 
                       STRING(DAY(TODAY),"99")      + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".
nv_brnfile   = "C:\GWTRANF\" + 
                       STRING(MONTH(TODAY),"99")    +
                       STRING(DAY(TODAY),"99")      +
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".
nv_duprec    = "C:\GWTRANF\" +                  
                       STRING(MONTH(TODAY),"99")    + 
                       STRING(DAY(TODAY),"99")      + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".dup".    


OUTPUT STREAM ns1 TO VALUE(nv_errfile).
OUTPUT STREAM ns2 TO VALUE(nv_brnfile).
OUTPUT STREAM ns3 TO VALUE(nv_duprec). 
*/

/* Tantawan --- A57-0361 --- ใส่ชื่อ User เข้าไปด้วย ---*/
 nv_errfile   = "C:\GWTRANF\" + 
                          STRING(CAPS(n_user)) + "_" +
                        STRING(MONTH(TODAY),"99")    + 
                        STRING(DAY(TODAY),"99")      + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

 nv_brnfile   = "C:\GWTRANF\" + 
                          STRING(CAPS(n_user)) + "_" +
                        STRING(MONTH(TODAY),"99")    +
                        STRING(DAY(TODAY),"99")      +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".

 nv_duprec    = "C:\GWTRANF\" +                  
                          STRING(CAPS(n_user)) + "_" +
                        STRING(MONTH(TODAY),"99")    +
                        STRING(DAY(TODAY),"99")      +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".dup".    

 nv_errfile1  = "C:\GWTRANF\" + "REL_"               +
                                STRING(CAPS(n_user)) +
                        STRING(MONTH(TODAY),"99")    + 
                        STRING(DAY(TODAY),"99")      + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

 nv_brnfile1  = "C:\GWTRANF\" + "REL_"               +
                                STRING(CAPS(n_user)) +
                        STRING(MONTH(TODAY),"99")    +
                        STRING(DAY(TODAY),"99")      +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".

 OUTPUT STREAM ns1 TO VALUE(nv_errfile).  
 OUTPUT STREAM ns2 TO VALUE(nv_brnfile).  
 OUTPUT STREAM ns3 TO VALUE(nv_duprec).  

 OUTPUT STREAM ns5 TO VALUE(nv_errfile1).
 OUTPUT STREAM ns6 TO VALUE(nv_brnfile1).
 /*--- END --- Tantawan --- A57-0361 ---*/


/*---Header Err---*/
PUT STREAM ns1
    "Transfer Error  "
    "Transfer Date : " TODAY  FORMAT "99/99/9999"
    "  Time : " STRING(TIME,"HH:MM:SS") 
    "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.  /* Add A53-0015 Chutikarn */
PUT STREAM ns1 FILL("-",90) FORMAT "X(90)" SKIP.
PUT STREAM ns1 "Policy No.       R / E   Error " SKIP.
/*---Header fuw---*/
PUT STREAM ns2
    "Transfer Complete   "
    "Transfer Date : " TODAY  FORMAT "99/99/9999"
    "  Time : " STRING(TIME,"HH:MM:SS") 
    "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
PUT STREAM ns2 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns2 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID   Insure Name " SKIP.

/*---Header Dup---*/
PUT STREAM ns3
"Transfer Duplicate   "
"Transfer Date : " TODAY  FORMAT "99/99/9999"
"  Time : " STRING(TIME,"HH:MM:SS") 
"  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
PUT STREAM ns3 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns3 "Policy No.      R/E    Dup. on Policy No.   R/E " SKIP.
/*----------------*/

/*--- Tantawan --- A57-0361 ---*/
/*---Header Release Completed---*/
PUT STREAM ns5
"Release Completed   "
"Release Date : " TODAY  FORMAT "99/99/9999"
"  Time : " STRING(TIME,"HH:MM:SS") 
"  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
PUT STREAM ns5 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns5 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID    Insure Name " SKIP.
/*----------------*/
/*---Header Release Error ---*/
PUT STREAM ns6
"Release Error   "
"Release Date : " TODAY  FORMAT "99/99/9999"
"  Time : " STRING(TIME,"HH:MM:SS") 
"  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
PUT STREAM ns6 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns6 "Policy No.      R/E     TrnType Docno    Rel.Date    UserID    Insure Name " SKIP.
/*----------------*/
 /*--- END --- Tantawan --- A57-0361 ---*/

/*--

FOR EACH  sic_bran.uwm100 USE-INDEX  uwm10001
    WHERE sic_bran.uwm100.policy >= fi_Policyfr
      AND sic_bran.uwm100.policy <= fi_Policyto
    BY sic_bran.uwm100.Policy:
comment by Chaiyong W. A57-0096 04/06/2014*/

nv_suscess = 0.  /*A58-0424*/
/*----Begin by chaiyong W. A57-0096 04/06/2014*/
FOR EACH w_polno WHERE 
    w_polno.polno >= fi_policyfr AND 
    w_polno.polno <= fi_policyto NO-LOCK BREAK BY w_polno.polno.

    nv_suscess = nv_suscess + 1.  /*A58-0424*/

    FIND FIRST  sic_bran.uwm100 USE-INDEX  uwm10001
    WHERE uwm100.policy = w_polno.polno  AND
          uwm100.rencnt = w_polno.rencnt AND
          uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL uwm100 THEN DO:
/*End by Chaiyong W. A57-0096 04/06/2014------*/
        ASSIGN
         nv_batchyr = uwm100.bchyr
         nv_batchno = uwm100.bchNo 
         nv_batcnt  = uwm100.bchCnt
         nv_Policy  = uwm100.Policy
         nv_RenCnt  = uwm100.RenCnt
         nv_EndCnt  = uwm100.EndCnt
         nv_Insno   = uwm100.insref.

         s_recid1  = RECID(uwm100).
         
         /*--Check batch--*/
         IF nv_batchyr <= 0  THEN DO:
            MESSAGE "Batch Year Error...!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         IF nv_batchno = ""  THEN DO:
            MESSAGE "Batch No can't blank..!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         ELSE DO:
            FIND LAST uzm701 USE-INDEX uzm70102
               WHERE uzm701.bchyr = nv_batchyr AND 
                     uzm701.bchno = nv_batchno NO-LOCK NO-ERROR.
            IF NOT AVAIL uzm701 THEN DO:
              MESSAGE "Not found Batch File Master on file uzm701" VIEW-AS ALERT-BOX.
              RETURN NO-APPLY.
            END.
            ELSE DO:
              IF uzm701.bchyr <> nv_batchyr THEN DO:
                 MESSAGE "Not found Batch File Master on file uzm701 (Year)" VIEW-AS ALERT-BOX.
                 RETURN NO-APPLY.
              END.
            END.
         END.
         IF nv_batcnt <= 0  THEN DO:
            MESSAGE "Batch Count error..!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         FIND LAST uzm701 USE-INDEX uzm70102
             WHERE uzm701.bchyr   =  nv_batchyr AND
                   uzm701.bchno   =  nv_batchno AND
                   uzm701.bchcnt  =  nv_batcnt NO-LOCK  NO-ERROR. /*A58-0251 Eakkapong ใส่ no-lock*/
         IF NOT AVAIL uzm701 THEN DO:
             MESSAGE "Batch No./Count " nv_batchno "/" nv_batcnt " not found" VIEW-AS ALERT-BOX.
             RETURN NO-APPLY.
         END.
         ELSE DO:
             /*--- เช็ค Batch status = Yes จึงจะให้ transfer batch no ได้ ---*/
             IF  uzm701.cnfflg = NO  THEN DO: 
                 MESSAGE "Batch Status Not Complete..!!" VIEW-AS ALERT-BOX.                  
                 RETURN NO-APPLY.
             END.
             /*--- เช็ค trfflg = Yes แสดงว่ามีการ transfer แล้ว ---*/
             IF uzm701.trfflg = YES THEN DO:
                 MESSAGE "This Batch No. used transfer to Premium..!!" VIEW-AS ALERT-BOX.         
                 RETURN NO-APPLY.
             END.
         END.
         DO :
         
             ASSIGN
              /*  sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS")*/ /*A58-0251 Eakkapong */
                fi_brnfile = nv_brnfile
                fi_errfile = nv_errfile
                fi_duprec  = nv_duprec.

             DISP fi_brnfile fi_errfile fi_duprec fi_strTime WITH FRAME fr_main.
    
             ASSIGN
              nv_error = NO
              fi_TranPol =  STRING(sic_bran.uwm100.Policy,"XX-XX-XX/XXXXXX") + " " + 
                            STRING(sic_bran.uwm100.RenCnt,"99") + "/" +
                            STRING(sic_bran.uwm100.EndCnt,"999") + "      " +
                            sic_bran.uwm100.Name1
    
              fi_time = STRING(TIME,"HH:MM:SS").
              nv_timeend   = TIME.
    
              nv_RecUwm100 = RECID(sic_bran.uwm100).
              
              nv_message = "".

              RUN PDCheckns1.
              
              DISP  fi_TranPol fi_time WITH FRAME fr_main.
              /*-----MOTOR POLICY ON WEB----*/
              IF nv_error = NO THEN DO:      
                   /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
                   nv_csuc  = nv_csuc + 1.
                   /*End by Chaiyong W. A57-0096 04/06/2014-----*/
                 DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
    
                 DO TRANSACTION: /*---add by Chaiyong W. A59-0312 07/07/2016*/
                     /*MESSAGE "1" VIEW-AS ALERT-BOX.*/
                     RUN wgw\wgwgen01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt,
                                       INPUT nv_chkre /*---Add by Chaiyong A57-0462 08/07/2015*/
                                       ).
                     DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                     DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                     DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                     DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                      
                     DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).

                 /*---Begin by Chaiyong W. A59-0312 07/07/2016*/
                     DISPLAY  "Release" @ fi_File WITH FRAME fr_main.
                     RUN wgw\wgwgenrl (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).

                     /*---
                 END. /*End by Chaiyong W. A59-0312 07/07/2016----*/
                 comment by Chaiyong W. A60-0174 18/04/2017*/

    
                     IF nv_error = NO THEN DO:
    
                         PUT STREAM ns2
                            sic_bran.uwm100.policy FORMAT "x(16)" " " 
                            sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  " 
                            nv_policy FORMAT "X(16)" " "
                            nv_rencnt "/" nv_endcnt "  "
                            sic_bran.uwm100.trndat "  "
                            sic_bran.uwm100.entdat "  "
                            sic_bran.uwm100.usrid "   " 
                            TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                            TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
    
                         /*--- Tantawan --- A57-0361 --- เพิ่มการ Release to Account พร้อมกับการ Transfer GW to Premium */
    
                         fi_relerr = nv_errfile1.
                         fi_relok  = nv_brnfile1.
                         DISP fi_relok fi_relerr WITH FRAME fr_main.
    
                         IF nv_chkre = "YES" THEN /*---add by Chaiyong W. A57-0462 08/07/2015*/
                         RUN PD_ChkRelease.
                         /*-- END -- A57-0361 */
                     END.
                 END. /*add by Chaiyong W. A60-0174 18/04/2017*/

              END. /*nv_error = no*/
    
              /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
              ELSE nv_cnsuc  = nv_cnsuc + 1.
              /*End by Chaiyong W. A57-0096 04/06/2014-----*/
    
         END. /*  ELSE DO:*/
    END.  /*For each*/

END.  /*---for each w_polno by Chaiyong W. A57-0096 04/06/201*/
OUTPUT STREAM ns1 close.
OUTPUT STREAM ns2 close.
OUTPUT STREAM ns3 CLOSE.
OUTPUT STREAM ns5 close.
OUTPUT STREAM ns6 close.

fi_TotalTime    = STRING((nv_timeend - nv_timestart),"HH:MM:SS").
DISP  fi_TotalTime WITH FRAME fr_main.

/*---
MESSAGE "Transfer Data To Premium Complete..!" VIEW-AS ALERT-BOX INFORMATION.
comment by Chaiyong W. A57-0096 04/06/2014*/

/*--- Comment A58-0424 --
/*---Begin by Chaiyong W. A57-0096 04/06/2014*/
IF nv_cnsuc = 0 THEN
    MESSAGE "Transfer Data To Premium Complete..!"  nv_csuc   "Records"  VIEW-AS ALERT-BOX INFORMATION.
ELSE
    MESSAGE "Transfer Data To Premium Complete..!"  nv_csuc   "Records" SKIP 
        "Not Success..................!"  nv_cnsuc  "Records" VIEW-AS ALERT-BOX INFORMATION.
/*End by Chaiyong W. A57-0096 04/06/2014-----*/


/* A57-0361 */
IF nv_relerr = 0 THEN
    MESSAGE "Release Premium to Account Completed..!"  nv_relok   "Records"  VIEW-AS ALERT-BOX INFORMATION.
ELSE
    MESSAGE "Release Premium to Account Completed..!"  nv_relok   "Records" SKIP 
            "Not Release ..................!"  nv_relerr  "Records" VIEW-AS ALERT-BOX INFORMATION.
/* A57-0361 */
--- End Comment A58-0424 --*/
IF nv_message <> "" THEN nv_message1 = "Reason : " + nv_message.
                    ELSE nv_message1 = "++++++++++++++++++++++++++++++++++++++".

/*--- Add A58-0480 --*/
MESSAGE "Transfer Data Total :    " nv_suscess "     Records" SKIP(1)
        "=============== Complete ================"  SKIP(1)
        "Trans. to Premium  :     " nv_csuc  "     Records" SKIP
        "Trans. to Account   :     " nv_csuc "     Records" SKIP(1)
        "============= Not Complete ===============" SKIP(1)
        "Not Trans. Premium :     " nv_cnsuc  "     Records"  SKIP
        "Not Trans. Account  :     " nv_cnsuc "     Records" SKIP(1)
        nv_message1                                 
VIEW-AS ALERT-BOX INFORMATION.
/*--- End A58-0480 --*/

/*-- Comment Message A58-0480 --
MESSAGE "Transfer Data Total :    " nv_suscess "     Records" SKIP(1)
        "=============== Complete ================"  SKIP(1)
        "Trans. to Premium  :     " nv_csuc  "     Records" SKIP
        "Trans. to Account   :     " nv_csuc "     Records" SKIP(1)
        "============= Not Complete ===============" SKIP(1)
        "Not Trans. Premium :     " nv_cnsuc  "     Records"  SKIP
        "Not Trans. Account  :     " nv_cnsuc "     Records" SKIP(1)
        nv_message1                                 SKIP
        "++++++++++++++++++++++++++++++++++++++"
VIEW-AS ALERT-BOX INFORMATION.
---*/

RUN PDUpdateQ.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acdes wgwtrn70
ON LEAVE OF fi_acdes IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno wgwtrn70
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
    /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
    fi_acno = CAPS(TRIM(INPUT fi_acno)).

    ASSIGN
        fi_acdes  = ""
        nv_branch = "".
    
    DISP fi_acno fi_acdes WITH FRAME fr_main.
    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno = fi_acno NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN DO:


            
            FIND FIRST w_chkbr WHERE
                   (w_chkbr.branch = "*" AND w_chkbr.producer = "*") OR 
                   (w_chkbr.branch = "*" AND w_chkbr.producer = fi_acno) NO-LOCK NO-ERROR.
            IF AVAIL w_chkbr THEN DO:
                FOR EACH sicsyac.xmm023 USE-INDEX xmm02301 NO-LOCK:
                    IF nv_branch = "" THEN
                        nv_branch = nv_branch + xmm023.branch.
                    ELSE
                        nv_branch = nv_branch + "," + xmm023.branch.
                END.
            END.
            ELSE DO:
                FOR EACH w_chkbr WHERE 
                         w_chkbr.producer = fi_acno OR 
                         w_chkbr.producer = "*"     NO-LOCK:
                    IF nv_branch = "" THEN
                        nv_branch = nv_branch + w_chkbr.branch.
                    ELSE
                        nv_branch = nv_branch + "," + w_chkbr.branch.
                END.
            END.

            IF nv_branch = "" THEN DO:
                MESSAGE "Not found Parameter Security User ID SET!!!" VIEW-AS ALERT-BOX INFORMATION.
                APPLY "ENTRY"  TO fi_acno.
                RETURN NO-APPLY.  
            END.



            fi_acdes = sicsyac.xmm600.NAME.
            DISP fi_acno fi_acdes WITH FRAME fr_main.
        END.
        ELSE DO:
            MESSAGE "Not found Parameter Account Code!!!" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "ENTRY"  TO fi_acno.
            RETURN NO-APPLY.
        END.
    END.
    /*End by Chaiyong W. A57-0096 04/06/2014-----*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Branch wgwtrn70
ON LEAVE OF fi_Branch IN FRAME fr_main
DO:
  fi_branch = CAPS (INPUT fi_branch).
  fi_brdesc = "".
  DISP fi_branch WITH FRAME fr_Main.



  /*---
  IF fi_branch <> ""  THEN DO:   
      FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm023 THEN DO:
         fi_brdesc = sic_bran.xmm023.bdes.
         DISP fi_brdesc WITH FRAME fr_Main.

         RUN pdUpdateQ.
         ENABLE  br_Uwm100 WITH FRAME fr_main.
      END.     
  END. 
  comment by Chaiyong W. A57-0096 04/06/2014*/

  /*----Begin by Chaiyong W. A57-0096 04/06/2014*/
  fi_branch = TRIM(fi_branch).
  IF fi_branch = "" AND nv_des <> "" AND INDEX(nv_des,",") <> 0 THEN DO: 
      ASSIGN
          fi_brdesc = nv_des
          nv_branch = nv_des.
      DISP fi_brdesc WITH FRAME fr_Main.
      RUN pdUpdateQ.
      ENABLE  br_Uwm100 WITH FRAME fr_main.
  END.
  ELSE DO:
      IF LOOKUP(fi_branch,nv_des) <> 0 THEN DO:
          FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
          IF AVAIL sic_bran.xmm023 THEN DO:
             ASSIGN
                 nv_branch = fi_branch
                 fi_brdesc = sic_bran.xmm023.bdes.
             DISP fi_brdesc WITH FRAME fr_Main.
             RUN pdUpdateQ.
             ENABLE  br_Uwm100 WITH FRAME fr_main.
          END.
      END.
  END.
  /*End by Chaiyong W. A57-0096 04/06/2014------*/


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrn70
ON LEAVE OF fi_Policyfr IN FRAME fr_main
DO:
  fi_Policyfr = CAPS (INPUT fi_Policyfr).
  DISP fi_policyfr WITH FRAME fr_main.

  IF fi_policyto = "" THEN DO:
     fi_policyto = fi_policyfr.
     DISP fi_policyto WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrn70
ON RETURN OF fi_Policyfr IN FRAME fr_main
DO:
    fi_Policyfr = CAPS (INPUT fi_Policyfr).
    IF fi_policyto < fi_policyfr THEN
        fi_policyto = fi_policyfr.
    DISP fi_policyfr fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyto wgwtrn70
ON LEAVE OF fi_Policyto IN FRAME fr_main
DO:
  fi_Policyto = CAPS (INPUT fi_Policyto).
  DISP fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_TrnDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_TrnDate wgwtrn70
ON LEAVE OF fi_TrnDate IN FRAME fr_main
DO:
  fi_TrnDate = INPUT fi_TrnDate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrn70
ON LEAVE OF fi_trndatt IN FRAME fr_main
DO:
    fi_Trndatt = INPUT fi_Trndatt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrn70
ON RETURN OF fi_trndatt IN FRAME fr_main
DO:
    fi_Trndatt = INPUT fi_Trndatt.
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_chk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_chk wgwtrn70
ON VALUE-CHANGED OF to_chk IN FRAME fr_main /* No-Print */
DO:
    ASSIGN
        TO_chk = INPUT TO_chk
        fi_trndate = INPUT fi_trndate
        fi_Trndatt = INPUT fi_Trndatt
        fi_acno = CAPS(TRIM(INPUT fi_acno)).

    /*----Begin by Chaiyong W. A60-0174 18/04/2017*/
    FOR EACH w_polno:
        DELETE w_polno.
    END.
    OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
    DISABLE br_uwm100 WITH FRAME fr_main.
    /*End by Chaiyong W. A60-0174 18/04/2017------*/

    
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.

    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.

    RUN PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtrn70 


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
  
  gv_prgid = "wgwtrn70.W".
  gv_prog  = "Query Batch No Transfer Motor Policy To Premium".  
  /*RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).*/
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 
/*MESSAGE
  PDBNAME (1) LDBNAME(1) SKIP
  PDBNAME (2) LDBNAME(2) SKIP
  PDBNAME (3) LDBNAME(3) SKIP 
  PDBNAME (4) LDBNAME(4) SKIP   
  PDBNAME (5) LDBNAME(5) SKIP
  PDBNAME (6) LDBNAME(6) SKIP  
  VIEW-AS ALERT-BOX.
*/
  /*---
  ASSIGN nv_branch = TRIM(SUBSTRING(n_user,6,2)).
         fi_branch = nv_branch.
         fi_TrnDate = TODAY.
  DISP fi_branch fi_TrnDate WITH FRAME fr_main.

  FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm023 THEN DO:
         fi_brdesc = sic_bran.xmm023.bdes.
         DISP fi_brdesc WITH FRAME fr_Main.

         /*---RUN pdUpdateQ.
         ENABLE  br_Uwm100 WITH FRAME fr_main.---*/
      END.
      
  comment by Chaiyong W. A57-0096 04/06/2014*/

    /*----Begin by Chaiyong W. A57-0096 04/06/2014*/
    ASSIGN
        fi_Trndatt = TODAY
        fi_TrnDate = TODAY
        nv_branch  = "".  /*Collect Branch*/

    FIND FIRST brstat.usrsec_fil WHERE brstat.usrsec_fil.usrid = n_user AND
               TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5))  = "*"  AND 
               TRIM(SUBSTR(brstat.usrsec_fil.CLASS,6,10)) = "*" NO-LOCK NO-ERROR.
    IF AVAIL usrsec_fil THEN DO:
        ASSIGN
            fi_branch = ""
            fi_brdesc = "ALL Branch".
        CREATE w_chkbr.
        ASSIGN
            w_chkbr.branch   = "*"
            w_chkbr.producer = "*".
    END.
    ELSE DO:
        CREATE w_chkbr.
        ASSIGN
            w_chkbr.branch   = TRIM(SUBSTRING(n_user,6,2))
            w_chkbr.producer = "*"
            nv_des           = TRIM(SUBSTRING(n_user,6,2)) .



        FOR EACH brstat.usrsec_fil WHERE brstat.usrsec_fil.usrid = n_user NO-LOCK:

            IF  TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5)) <> TRIM(SUBSTRING(n_user,6,2)) THEN DO:
                CREATE w_chkbr.
                ASSIGN
                    w_chkbr.branch   = TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5))
                    w_chkbr.producer = TRIM(SUBSTR(brstat.usrsec_fil.CLASS,6,10)).



                IF w_chkbr.branch = "" THEN w_chkbr.branch = "*".
                IF w_chkbr.producer = "" THEN w_chkbr.producer = "*".

                IF  LOOKUP(TRIM(w_chkbr.branch),nv_des) = 0 THEN DO:
                    IF w_chkbr.branch = "*" THEN
                        IF LOOKUP(TRIM(w_chkbr.producer),nv_des) = 0  THEN
                            nv_des = nv_des.
                        ELSE
                            nv_des = nv_des + "," + w_chkbr.branch.
                     ELSE
                         nv_des = nv_des + "," + w_chkbr.branch.
                END.

            END.
        END.
        
        IF INDEX(nv_des,",") = 0 THEN DO:    
            FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = nv_des NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm023 THEN DO:
                ASSIGN
                    fi_branch = nv_des
                    fi_brdesc = sicsyac.xmm023.bdes.
            END.
            ELSE DO:
                MESSAGE "Please Check Parameter Branch!!!" VIEW-AS ALERT-BOX INFORMATION.
                RETURN NO-APPLY.
            END.
        END. 
        ELSE fi_brdesc = nv_des.
    END.
    
    IF fi_brdesc = "" THEN nv_des = "".

    DISP fi_branch  fi_brdesc fi_TrnDate fi_Trndatt WITH FRAME fr_main.
    /*End by Chaiyong W. A57-0096 04/06/2014------*/


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtrn70  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn70)
  THEN DELETE WIDGET wgwtrn70.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtrn70  _DEFAULT-ENABLE
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
  DISPLAY fi_acdes fi_TrnDate fi_trndatt fi_acno fi_Branch fi_Policyfr 
          fi_Policyto fi_brdesc fi_brnfile fi_TranPol fi_errfile fi_strTime 
          fi_time fi_TotalTime fi_File fi_relOk fi_relerr fi_duprec to_chk 
      WITH FRAME fr_main IN WINDOW wgwtrn70.
  ENABLE br_uwm100 fi_TrnDate fi_trndatt fi_acno bu_refresh fi_Policyfr 
         fi_Policyto bu_exit bu_Transfer fi_brdesc fi_brnfile fi_TranPol 
         fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk fi_relerr 
         fi_duprec to_chk RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 RECT-3 
      WITH FRAME fr_main IN WINDOW wgwtrn70.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtrn70.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckns1 wgwtrn70 
PROCEDURE PDCheckns1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_vaterr AS LOG INIT NO.
DEF VAR  nv_icno   AS CHAR INIT "". /*---add by Chaiyong W. A66-0255 19/01/2024*/
DEF VAR  n_mesag   AS CHAR INIT "". /*---add by Chaiyong W. A66-0255 19/01/2024*/
ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

/*-- A57-0361 --*/
FIND FIRST sicuw.uwm100 USE-INDEX uwm10001
    WHERE sicuw.uwm100.policy = sic_bran.uwm100.policy NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:

    ASSIGN
     putchr1 = "Policy Duplication on sicuw.uwm100 " +  string(sicuw.uwm100.policy) + " " + string(sicuw.uwm100.rencnt) + "/" + string(sicuw.uwm100.endcnt)
     putchr  = textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns3 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.
ELSE DO:
/*-- A57-0361 --*/
    
    FIND LAST wk_uwm100 WHERE RECID(wk_uwm100) = nv_RecUwm100.
    IF NOT AVAIL wk_uwm100 THEN DO:
       ASSIGN
        putchr1 = "Not Found Record on sic_bran.uwm100" .
        putchr  = textchr  + "  " + TRIM(putchr1).
       PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
       nv_message = putchr1.
       nv_error = YES.
     /*NEXT.*/
    END.
    ELSE DO:
      IF wk_uwm100.poltyp = "" THEN DO:
         ASSIGN
          putchr1 = "ไม่มีค่า Policy Type"
          putchr  = textchr + "  " + TRIM(putchr1).

         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.branch = "" THEN DO:
         ASSIGN
          putchr1 = "ไม่มีค่า Branch"
          putchr  = textchr + "  " + TRIM(putchr1).

         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.comdat = ? THEN DO:
         ASSIGN 
           putchr1 = "ไม่มีค่า Comdate"
           putchr  = textchr + "  " + TRIM(putchr1).

         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
        /*NEXT.*/
      END.
      IF wk_uwm100.expdat = ? THEN DO:
         ASSIGN
           putchr1 = "ไม่มีค่า Expiry Date"
           putchr  = textchr + "  " + TRIM(putchr1).
          PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
          nv_message = putchr1.
          nv_error = YES.
        /*NEXT.*/
      END.
      IF wk_uwm100.expdat < wk_uwm100.comdat THEN DO:   /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
          ASSIGN
              putchr1 = "วันที่Expiry Dateน้อยกว่าวันที่ Com Date"
              putchr  = textchr + "  " + TRIM(putchr1).
          PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
          IF putchr1 <> "" THEN nv_message = putchr1.
          nv_error = YES.
          /* NEXT.  */
      END.  /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
      IF wk_uwm100.name1 = "" THEN DO:
         ASSIGN
          putchr1 = "ไม่มีค่า Name Of Insured"
          putchr  = textchr  + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.prem_t = 0 THEN DO:
         ASSIGN
          putchr1 = "ไม่มีค่า Premium"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.tranty = "" 
         AND nv_chkre = "YES" /*---add by Chaiyong W. A57-0462 08/07/2015*/ 
         THEN DO:
         ASSIGN
          putchr1 = "ไม่สามารถระบุประเภทงานได้"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.policy = "" THEN DO:
         ASSIGN
          putchr1 = "Policy No. is blank"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      /*-- Comment A58-0143 --
      IF wk_uwm100.RenCnt <> 0 THEN DO:
         ASSIGN
          putchr1 = "Renewal Count error"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      -- End Comment A58-0143 --*/
      IF wk_uwm100.EndCnt <> 0 THEN DO:
         ASSIGN
          putchr1 = "Endorsement Count error"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.agent = "" OR wk_uwm100.acno1 = "" THEN DO:
         ASSIGN
          putchr1 = "Producer, Agent are blank"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF wk_uwm100.insref = "" THEN DO:
         ASSIGN
          putchr1 = "Insured Code is blank"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF TRIM(wk_uwm100.Addr1) + TRIM(wk_uwm100.Addr2) +
         TRIM(wk_uwm100.Addr3) + TRIM(wk_uwm100.Addr4) = "" THEN DO:
         ASSIGN
          putchr1 = "Address is blank"
          putchr  = textchr + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.   
      /* A57-0361 */
      IF sic_bran.uwm100.trndat > TODAY THEN DO:
          ASSIGN
           putchr1 = "Transaction Date Over System Date".
           putchr  =  textchr  + "  " + TRIM(putchr1).
          PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
          nv_message = putchr1.
          nv_error = YES.
      END.
    
    
      /*UWM120*/
      FIND LAST sic_bran.uwm120 USE-INDEX uwm12001
          WHERE uwm120.policy = wk_uwm100.policy
            AND uwm120.rencnt = wk_uwm100.rencnt
            AND uwm120.endcnt = wk_uwm100.endcnt
            AND uwm120.riskgp = 0
            AND uwm120.riskno = 1
            AND uwm120.bchyr  = nv_batchyr
            AND uwm120.bchno  = nv_batchno
            AND uwm120.bchcnt = nv_batcnt NO-LOCK NO-ERROR.
     IF NOT AVAIL uwm120 THEN DO:
        ASSIGN
         putchr1 = "Not Found Record on sic_bran.uwm120".
         putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
      /*NEXT.*/
     END.
     /*UWM130*/
     FIND LAST sic_bran.uwm130 USE-INDEX uwm13001
         WHERE uwm130.policy = wk_uwm100.policy
           AND uwm130.rencnt = wk_uwm100.rencnt
           AND uwm130.endcnt = wk_uwm100.endcnt
           AND uwm130.riskgp = 0
           AND uwm130.riskno = 1
           AND uwm130.itemno = 1
           AND uwm130.bchyr = nv_batchyr 
           AND uwm130.bchno = nv_batchno 
           AND uwm130.bchcnt  = nv_batcnt NO-LOCK NO-ERROR.
     IF NOT AVAIL  uwm130 THEN DO:
        ASSIGN
         putchr1 = "Not Found Record on sic_bran.uwm130" .
         putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
      /*NEXT.*/
     END.
     /*UWM301*/
     FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
         WHERE uwm301.policy  = wk_uwm100.policy
           AND uwm301.rencnt  = wk_uwm100.rencnt
           AND uwm301.endcnt  = wk_uwm100.endcnt
           AND uwm301.riskgp  = 0
           AND uwm301.riskno  = 1
           AND uwm301.itemno  = 1
           AND uwm301.bchno   = nv_batchno
           AND uwm301.bchcnt  = nv_batcnt
           AND uwm301.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
     IF NOT AVAIL  uwm301 THEN DO:
        ASSIGN
          putchr1 = "Not Found Record on sic_bran.uwm301" .
          putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
      /*NEXT.*/
     END.
     ELSE DO:
      IF LENGTH(sic_bran.uwm301.vehreg) > 11 THEN DO:
         ASSIGN
          putchr1 = "Warning : Vehicle Register More Than 11 Characters".    
          putchr  =  textchr  + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF sic_bran.uwm301.vehreg = "" THEN DO:
         ASSIGN
          putchr1 = "Vehicle Register is mandatory field.".
          putchr  =  textchr  + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      IF sic_bran.uwm301.modcod = "" THEN DO:
         ASSIGN
          putchr1 = "Redbook Code เป็นค่าว่าง ".
          putchr  =  textchr  + "  " + TRIM(putchr1).
         PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_error = YES.
       /*NEXT.*/
      END.
      /*Add Jiraphon P. A64-0199*/
      IF sic_bran.uwm301.vehreg <> "" THEN DO:
          nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
          /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/ 
          IF substring(nv_vehreg,1,1) = "/" OR substring(nv_vehreg,1,1) = "\" THEN DO:
          END.
          ELSE IF LENGTH(nv_vehreg) > 3 THEN DO:
              nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 1)). /*2 Position*/
              IF SUBSTR(nv_vehreg,1,1) >= "ก" AND  SUBSTR(nv_vehreg,1,1) <= "ฮ" AND
                  SUBSTR(nv_vehreg,2,1) >= "ก" AND  SUBSTR(nv_vehreg,2,1) <= "ฮ" THEN DO:
                  nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                  nv_vehreg = SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2,1).
                  IF nv_vehreg = " " THEN DO:
                      nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                      nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2)).
                      FIND FIRST sicuw.uwm500 USE-INDEX uwm50001 WHERE             
                          sicuw.uwm500.prov_n = nv_vehreg NO-LOCK NO-ERROR.
                      IF NOT AVAIL sicuw.uwm500 THEN DO: 
                          putchr1    = "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg.
                          putchr     = textchr  + "  " + TRIM(putchr1).
                          PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                          IF putchr1 <> "" THEN nv_message = putchr1.
                          nv_error   = YES.
                      END.
                  END.
                  ELSE DO:
                      putchr1    = "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg.
                      putchr     = textchr  + "  " + TRIM(putchr1).
                      PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                      IF putchr1 <> "" THEN nv_message = putchr1.
                      nv_error   = YES.
                  END.
              END.
          END. /*substring(nv_vehreg,1,1) = "/"*/ 
         /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/ 
      END.
      /*End Add Jiraphon P. A64-0199*/
     END. /*ELSE DO:*/
    
     /*UWD132*/
     FIND LAST sic_bran.uwd132 USE-INDEX uwd13201
         WHERE uwd132.policy  = wk_uwm100.policy
           AND uwd132.rencnt  = wk_uwm100.rencnt
           AND uwd132.endcnt  = wk_uwm100.endcnt
           AND uwd132.riskgp  = 0
           AND uwd132.riskno  = 1
           AND uwd132.itemno  = 1
           AND uwd132.bchno   = nv_batchno
           AND uwd132.bchcnt  = nv_batcnt
           AND uwd132.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
     IF NOT AVAIL uwd132 THEN DO:
        ASSIGN
         putchr1 = "Not Found Record on sic_bran.uwd132" .
         putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
      /*NEXT.*/
     END.
     /*----Begin by Chaiyong W. A66-0255 07/12/2023*/
     IF wk_uwm100.prem_t < 0 THEN DO:
         ASSIGN
         putchr1 = "ต้นกรมฯ เบี้ยต้องไม่ติดลบ" .
         putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.

     END.
     ELSE IF wk_uwm100.sigr_p < 0 THEN DO:
         ASSIGN
             putchr1 = "Si Total >= 0" .
             putchr  =  textchr  + "  " + TRIM(putchr1).
            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
            nv_message = putchr1.
            nv_error = YES.
     END.
     ELSE DO:
         FIND sic_bran.xmm600 WHERE sic_bran.xmm600.acno = wk_uwm100.insref NO-LOCK NO-ERROR.
        IF  AVAIL sic_bran.xmm600 THEN nv_icno = xmm600.icno.
        nv_icno = TRIM(nv_icno).
        IF nv_icno = "" OR nv_icno = ? THEN nv_icno = wk_uwm100.icno .
        RUN whp\whpcicno3(INPUT  nv_icno ,
                             INPUT   wk_uwm100.insref,
                             INPUT  nv_progid  ,
                             INPUT  RECID(wk_uwm100)   ,
                             INPUT  wk_uwm100.poltyp   ,
                             INPUT  wk_uwm100.policy, 
                             INPUT  "GW",
                             INPUT  "",
                             INPUT  "",
                             OUTPUT n_mesag ,
                             OUTPUT putchr1 )     .
        IF putchr1 <> "" THEN DO:
            putchr  = textchr  + "  " + TRIM(putchr1).
            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
            nv_message = putchr1.
            nv_error = YES.
        END.
     END.
     /*End  by Chaiyong W. A66-0255 07/12/2023-----*/


    
    END. /*--WK_UWM100--*/

    RUN PDChkAccount. /*A58-0428*/

END. /* not dup. */

/*-- Check Document No. --*/
IF sic_bran.uwm100.docno1 <> "0000000" AND sic_bran.uwm100.docno1 <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
               sicuw.uwm100.trty11 = sic_bran.uwm100.trty11 AND
               sicuw.uwm100.docno1 = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        ASSIGN
            putchr1 = "Document No. ซ้ำกับ Policy : " + sicuw.uwm100.policy.
            putchr  =  textchr  + "  " + TRIM(putchr1).
    
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.
END.

/*
/*--- Add A57-0300 Check Vat 100 ---*/
RUN wgw\wgwvat01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  
                  INPUT nv_Policy, INPUT nv_RenCnt, INPUT nv_EndCnt,
                  OUTPUT nv_error, OUTPUT putchr1).

putchr  =  textchr  + "  " + TRIM(putchr1).
PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
nv_message = putchr1.
/*--- End A57-0300 Check Vat 100 ---*/
*/

IF nv_chkre = "YES" THEN DO: /*---add by Chaiyong W. A57-0462 23/06/2015*/

    RUN wgw\wgwvat01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  
                      INPUT nv_Policy, INPUT nv_RenCnt, INPUT nv_EndCnt,
                      OUTPUT nv_vaterr, OUTPUT putchr1).
    
    IF nv_vaterr THEN DO:
    
        nv_error = YES.
    
        putchr  =  textchr  + "  " + TRIM(putchr1).
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
    END.
END.  /*---add by Chaiyong W. A57-0462 23/06/2015*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkAccount wgwtrn70 
PROCEDURE PDChkAccount :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A58-0424     
------------------------------------------------------------------------------*/
DEF VAR nv_rprem AS DECI.
DEF VAR nv_rstp  AS DECI.
DEF VAR nv_rtax  AS DECI.
DEF VAR nv_rcom  AS DECI.
DEF VAR nv_wprem AS DECI.

FIND FIRST sicsyac.acm001 USE-INDEX acm00101 WHERE
           sicsyac.acm001.trnty1 = sic_bran.uwm100.trty11 AND
           sicsyac.acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
IF AVAIL sicsyac.acm001 THEN DO:
    ASSIGN
        putchr1 = "Document No. already on Account Master file acm001".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.    

FIND FIRST sicsyac.acm002 USE-INDEX acm00201 WHERE
           sicsyac.acm002.trnty1 = sic_bran.uwm100.trty11 AND
           sicsyac.acm002.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
IF AVAIL acm002 THEN DO:
    ASSIGN
        /*putchr1 = "Document No. already on Account Master file acm002" + acm002.policy. Rachan I. A61-0545   15/11/2018*/
        putchr1 = "Document No. " + sic_bran.uwm100.docno1 + " already on Account Master file acm002 " + acm002.policy. /*Rachan I. A61-0545   15/11/2018*/
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF sic_bran.uwm100.prem_t <> 0 THEN DO:
    IF (sic_bran.uwm100.docno1 = "0000000"  OR
        sic_bran.uwm100.docno1 = "" )       THEN DO:
        ASSIGN
            putchr1 = "Dr/Cr not print".
            putchr  = textchr  + "  " + TRIM(putchr1).

        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.
END.

FOR EACH sic_bran.uwm120 WHERE
         sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
         sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK:

    nv_rprem  = nv_rprem  + sic_bran.uwm120.prem_r.
    nv_rstp   = nv_rstp   + sic_bran.uwm120.rstp_r.
    nv_rtax   = nv_rtax   + sic_bran.uwm120.rtax_r.
    nv_rcom   = nv_rcom   + sic_bran.uwm120.com1_r + sic_bran.uwm120.com2_r.
END.

IF sic_bran.uwm100.prem_t <> nv_rprem THEN DO:
    ASSIGN
        putchr1 = "Premium Policy (uwm100) not equal Risk (sic_bran.uwm120) ".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF sic_bran.uwm100.rstp_t <> nv_rstp THEN DO:
    ASSIGN
        putchr1 = "Stamp  Policy (uwm100) not equal Risk (sic_bran.uwm120)".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF sic_bran.uwm100.rtax_t <> nv_rtax THEN DO:
    ASSIGN
        putchr1 = "Tax Policy (uwm100) not equal Risk (sic_bran.uwm120)".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF (sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t) <> nv_rcom THEN DO:
    ASSIGN
        putchr1 = "Commission Policy (uwm100) not equal Risk (sic_bran.uwm120)".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

FOR EACH sic_bran.uwd132 WHERE
         sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
         sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt NO-LOCK:
    nv_wprem  = nv_wprem  + sic_bran.uwd132.prem_c.
END.

IF sic_bran.uwm100.prem_t <> nv_wprem THEN DO:
    ASSIGN
        putchr1 = "Premium Policy (sic_bran.uwm100) not equal Insured Item (sic_bran.uwd132)".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF sic_bran.uwm100.sch_p = NO OR sic_bran.uwm100.drn_p = NO THEN DO:
    ASSIGN
        putchr1 = "Policy or Debit Note is not print , Can't transfer to Account".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.

IF sic_bran.uwm100.prem_t <> 0 OR sic_bran.uwm100.com1_t <> 0 OR sic_bran.uwm100.com2_t <> 0 OR
   sic_bran.uwm100.pstp   <> 0 OR sic_bran.uwm100.pfee   <> 0 OR sic_bran.uwm100.ptax   <> 0 OR
   sic_bran.uwm100.rstp_t <> 0 OR sic_bran.uwm100.rfee_t <> 0 OR sic_bran.uwm100.rtax_t <> 0 THEN DO:

    /*IF INTEGER(sic_bran.uwm100.docno1) = 0  THEN DO:*/   /*kridtiya i. A63-00029*/
    IF  sic_bran.uwm100.docno1 = ""           OR           /*kridtiya i. A63-00029*/
        sic_bran.uwm100.docno1 = "0000000"    OR           /*kridtiya i. A63-00029*/
        sic_bran.uwm100.docno1 = "0000000000"     THEN DO: /*kridtiya i. A63-00029*/
        ASSIGN
            putchr1 = "ไมมีเลขที่ใบแจ้งหนี้หรือใบลดหนี้".
            putchr  = textchr  + "  " + TRIM(putchr1).

        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.
END.

IF (sic_bran.uwm100.poltyp = "V72"  OR
    sic_bran.uwm100.poltyp = "V73"  OR
    sic_bran.uwm100.poltyp = "V74") THEN DO:

    nv_uwd132 = YES.

    FOR EACH sic_bran.uwm130  WHERE
             sic_bran.uwm130.policy  = sic_bran.uwm100.policy  AND
             sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
             sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK:
        FIND FIRST sic_bran.uwd132  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sic_bran.uwd132 THEN nv_uwd132 = NO.
    END.

    IF nv_uwd132 = NO THEN DO:
        ASSIGN
            putchr1 = "ไม่พบข้อมูล หน้าเบี้ย(uwd132) ติดต่อ Computer".
            putchr  = textchr  + "  " + TRIM(putchr1).

        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.
END.

/*-- Check Sticker No. --*/
IF (sic_bran.uwm100.poltyp = "V70"  OR
    sic_bran.uwm100.poltyp = "V72"  OR
    sic_bran.uwm100.poltyp = "V73"  OR
    sic_bran.uwm100.poltyp = "V74") THEN DO:

    FIND FIRST sic_bran.uwm130  WHERE
               sic_bran.uwm130.policy  = sic_bran.uwm100.policy  AND
               sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
               sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sic_bran.uwm130 THEN DO:
        ASSIGN
            putchr1 = "ไม่พบข้อมูล รายการคุ้มครอง(sic_bran.uwm130) ติดต่อ Computer".
            putchr  = textchr  + "  " + TRIM(putchr1).
   
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.

    END.
END.

FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.
IF NOT AVAIL xmm600 THEN DO:
    ASSIGN
        putchr1 = "Not found Agent,Producer Can not Release to Account".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.
ELSE DO:
    FIND sicsyac.xmm022 USE-INDEX xmm02201 WHERE 
         sicsyac.xmm022.acccod = sicsyac.xmm600.acccod NO-LOCK NO-WAIT NO-ERROR.
    IF NOT AVAIL sicsyac.xmm022 THEN DO:
        FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
        IF xmm090.glref <> "0" THEN DO:
            ASSIGN
                putchr1 = "Policy Release cannot find GL Debtor Control A/C No. xmm022".
                putchr  = textchr  + "  " + TRIM(putchr1).

            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
            nv_message = putchr1.
            nv_error = YES.
        END.
    END.

    FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm090 THEN DO:
        IF xmm090.glref <> "0" THEN DO:
            ASSIGN
                putchr1 = "Policy Release cannot find GL A/C Nos. on xmm202".
                putchr  = textchr  + "  " + TRIM(putchr1).

            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
            nv_message = putchr1.
            nv_error = YES.
        END.
    END.
    /*--- Start Comment A64-0038 -------------
    IF sicsyac.xmm600.acccod <> "AG" AND     /* direc */
       sicsyac.xmm600.acccod <> "BR" AND 
       sicsyac.xmm600.acccod <> "RD" AND     /* inward */
       sicsyac.xmm600.acccod <> "RF" AND 
       sicsyac.xmm600.acccod <> "RB" THEN DO:
        ASSIGN
            putchr1 = "Not AGENT/BROKER TYPE, Can't Release to Account".
            putchr  = textchr  + "  " + TRIM(putchr1).

        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.
    ------ Comment A64-0038 -- 05/04/2021 --*/
END.

IF sic_bran.uwm100.acno1  = "B300100" OR
   sic_bran.uwm100.acno1  = "B3V0100" OR
   sic_bran.uwm100.acno1  = "B3K0100" OR
   sic_bran.uwm100.acno1  = "B3C0100" OR
   sic_bran.uwm100.acno1  = "B3V2100" THEN DO:

    ASSIGN
        putchr1 = "Code Producer is Sriprathom , Can not Releas to Account".
        putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ wgwtrn70 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME fr_Main fi_Branch.

/*Find Parameter  Add Jiraphon P. A62-0286*/
FOR EACH stat.symprog USE-INDEX symprog05 WHERE stat.symprog.grpcod = "Onweb" NO-LOCK:
    IF nv_progid = "" THEN nv_progid = stat.symprog.prog.
    ELSE IF lookup(stat.symprog.prog,nv_progid) = 0 THEN nv_progid = nv_progid + "," + stat.symprog.prog.
    ELSE NEXT.
END.

/*----
IF fi_acno <> "" THEN DO: 
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10094
     WHERE sic_bran.uwm100.Acno1  = fi_Acno     
       AND sic_bran.uwm100.branch = fi_branch  
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.Prog   = "gwGen100" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.
ELSE DO:
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10021
     WHERE sic_bran.uwm100.Trndat = fi_TrnDate
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.Prog   = "gwGen100" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.

comment by Chaiyong W. A57-0096 04/06/2014*/

/*----Begin by Chaiyong W. A57-0096 04/06/2014*/
FOR EACH w_polno:
    DELETE w_polno.
END.
loop_list: /*---add by chaiyong W. A57-0462 23/06/2015*/
FOR EACH  sic_bran.uwm100 USE-INDEX  uwm10021
    WHERE sic_bran.uwm100.Trndat >= fi_TrnDate
    AND sic_bran.uwm100.trndat <= fi_trndatt 
    AND sic_bran.uwm100.acno1  = fi_Acno  
    AND LOOKUP(sic_bran.uwm100.branch,nv_branch) <> 0  
    AND sic_bran.uwm100.releas = NO    
    AND LOOKUP(sic_bran.uwm100.prog,nv_progid) <> 0  /*Add Jiraphon P. A62-0286*/
    AND sic_bran.uwm100.endcnt = 0 AND sic_bran.uwm100.polsta  <> "CA" /*---add by Chaiyong W. A66-0116 02/11/2023*/


    /*AND sic_bran.uwm100.Prog   = "gwGen100"*/ NO-LOCK BREAK BY  sic_bran.uwm100.Policy .


     /*---Begin by Chaiyong W. A57-0462 23/06/2015*/
    IF sic_bran.uwm100.poltyp <> "V70" AND sic_bran.uwm100.poltyp <> "V72" AND
       sic_bran.uwm100.poltyp <> "V73" AND sic_bran.uwm100.poltyp <> "V74" THEN NEXT loop_list.
    IF TO_chk = YES THEN DO:
        IF sic_bran.uwm100.sch_p = YES OR
           sic_Bran.uwm100.drn_p = YES OR
           sic_Bran.uwm100.docno1 <> "" THEN
            NEXT loop_list.
    END.
    ELSE DO:
        IF TRIM(sic_Bran.uwm100.docno1) = "" OR TRIM(sic_Bran.uwm100.docno1) = ? THEN NEXT loop_list.
    END.
    /*End by Chaiyong W. A58-0462 23/06/2015-----*/

    FIND FIRST w_polno WHERE w_polno.polno = sic_bran.uwm100.policy AND
        w_polno.rencnt = sic_bran.uwm100.rencnt AND
        w_polno.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
    IF NOT AVAIL w_polno THEN DO:
        CREATE w_polno.
        ASSIGN
            w_polno.trndat              =       sic_bran.uwm100.trndat 
            w_polno.polno               =       sic_bran.uwm100.policy
            w_polno.ntitle              =       sic_bran.uwm100.ntitle
            w_polno.name1               =       sic_bran.uwm100.name1
            w_polno.rencnt              =       sic_bran.uwm100.rencnt
            w_polno.endcnt              =       sic_bran.uwm100.endcnt 
            w_polno.trty11              =       sic_bran.uwm100.trty11 
            w_polno.docno1              =       sic_bran.uwm100.docno1   
            w_polno.agent               =       sic_bran.uwm100.agent  
            w_polno.acno1               =       sic_bran.uwm100.acno1  
            w_polno.bchyr               =       sic_bran.uwm100.bchyr  
            w_polno.bchno               =       sic_bran.uwm100.bchno  
            w_polno.bchcnt              =       sic_bran.uwm100.bchcnt 
            w_polno.releas              =       sic_bran.uwm100.releas.

        FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
             WHERE sic_bran.uwm301.policy = sic_bran.uwm100.policy
               AND sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt
               AND sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt
               AND sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr
               AND sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno
               AND sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm301 THEN DO:
            ASSIGN
                w_polno.modcod  =  sic_bran.uwm301.modcod
                w_polno.moddes  =  sic_bran.uwm301.moddes.
        END.
    END.

END.
OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
/*end by Chaiyong W. A57-0096 04/06/2014*/
/*----Begin by Chaiyong W. A60-0174 18/04/2017*/
FIND FIRST w_polno WHERE w_polno.polno <> "" NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL w_polno THEN ENABLE  br_uwm100 WITH FRAME fr_main.
ELSE DISABLE br_uwm100 WITH FRAME fr_main.
/*End by Chaiyong W. A60-0174 18/04/2017------*/


/*---
IF fi_acno <> "" THEN DO:
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX uwm10007
     WHERE sic_bran.uwm100.releas = NO
       AND sic_bran.uwm100.sch_p  = YES
       AND sic_bran.uwm100.drn_p  = YES
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.acno1  = fi_acno
       AND sic_bran.uwm100.Prog   = "gwGen100" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.
ELSE DO:
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX uwm10007
     WHERE sic_bran.uwm100.releas = NO
       AND sic_bran.uwm100.sch_p  = YES
       AND sic_bran.uwm100.drn_p  = YES
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.Prog   = "gwGen100" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.
-----*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_acm001 wgwtrn70 
PROCEDURE PD_acm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- A57-0361 ---*/
gv_acm001OK = NO.

CREATE sicsyac.acm001.
ASSIGN
  acm001.acno      = sicsyac.acm002.acno
  acm001.agent     = sicsyac.acm002.agent 
  acm001.curcod    = sicsyac.acm002.curcod
  acm001.branch    = sicsyac.acm002.branch
  acm001.trangp    = sicsyac.acm002.trangp
  acm001.trndat    = sicsyac.acm002.trndat
  acm001.ac_mth    = sicsyac.acm002.ac_mth
  acm001.ac_yr     = sicsyac.acm002.ac_yr
  acm001.trnty1    = sicsyac.acm002.trnty1
  acm001.trnty2    = sicsyac.acm002.trnty2
  acm001.docno     = sicsyac.acm002.docno
  acm001.insno     = sicsyac.acm002.insno
  acm001.instot    = sicsyac.acm002.instot
  acm001.clicod    = sicsyac.acm002.clicod
  acm001.acccod    = sicsyac.acm002.acccod
  acm001.prem      = sicsyac.acm002.prem
  acm001.comm      = sicsyac.acm002.comm
  acm001.fee       = sicsyac.acm002.fee
  acm001.stamp     = sicsyac.acm002.stamp
  acm001.tax       = sicsyac.acm002.tax
  acm001.netamt    = sicsyac.acm002.netamt
  acm001.netloc    = sicsyac.acm002.netloc
  acm001.bal       = sicsyac.acm002.bal
  acm001.baloc     = sicsyac.acm002.baloc
  acm001.ref       = sicsyac.acm002.ref
  acm001.cheque    = sicsyac.acm002.cheque
  acm001.comdat    = sicsyac.acm002.comdat
  acm001.poltyp    = sicsyac.acm002.poltyp
  acm001.policy    = sicsyac.acm002.policy
  acm001.recno     = sicsyac.acm002.recno
  acm001.cn_no     = sicsyac.acm002.cn_no
  acm001.vehreg    = sicsyac.acm002.vehreg
  acm001.disput    = sicsyac.acm002.disput
  acm001.erldat    = sicsyac.acm002.erldat
  acm001.insref    = sicsyac.acm002.insref
  acm001.mltyp1    = sicsyac.acm002.mltyp1
  acm001.mlno      = sicsyac.acm002.mlno
  acm001.cedno     = sicsyac.acm002.cedno
  acm001.cedent    = sicsyac.acm002.cedent
  acm001.cedref    = sicsyac.acm002.cedref
  acm001.thcess    = sicsyac.acm002.thcess
  acm001.bankno    = sicsyac.acm002.bankno
  acm001.cedco     = sicsyac.acm002.cedco
  acm001.usrid     = sicsyac.acm002.usrid
  acm001.entdat    = sicsyac.acm002.entdat
  acm001.enttim    = sicsyac.acm002.enttim
  acm001.ac1       = sicsyac.acm002.ac1
  acm001.ac2       = sicsyac.acm002.ac2.
ASSIGN
  acm001.ac3       = sicsyac.acm002.ac3
  acm001.ac4       = sicsyac.acm002.ac4
  acm001.ac5       = sicsyac.acm002.ac5
  acm001.ac6       = sicsyac.acm002.ac6
  acm001.ac7[ 1]   = sicsyac.acm002.ac7[ 1]
  acm001.ac7[ 2]   = sicsyac.acm002.ac7[ 2]
  acm001.ac7[ 3]   = sicsyac.acm002.ac7[ 3]
  acm001.ac7[ 4]   = sicsyac.acm002.ac7[ 4]
  acm001.ac7[ 5]   = sicsyac.acm002.ac7[ 5]
  acm001.ac7[ 6]   = sicsyac.acm002.ac7[ 6]
  acm001.ac7[ 7]   = sicsyac.acm002.ac7[ 7]
  acm001.ac7[ 8]   = sicsyac.acm002.ac7[ 8]
  acm001.ac7[ 9]   = sicsyac.acm002.ac7[ 9]
  acm001.ac7[10]   = sicsyac.acm002.ac7[10]
  acm001.ac7[11]   = sicsyac.acm002.ac7[11]
  acm001.ac7[12]   = sicsyac.acm002.ac7[12]
  acm001.ac7[13]   = sicsyac.acm002.ac7[13]
  acm001.ac7[14]   = sicsyac.acm002.ac7[14]
  acm001.amt1      = sicsyac.acm002.amt1
  acm001.amt2      = sicsyac.acm002.amt2
  acm001.amt3      = sicsyac.acm002.amt3
  acm001.amt4      = sicsyac.acm002.amt4
  acm001.amt5      = sicsyac.acm002.amt5
  acm001.amt6      = sicsyac.acm002.amt6
  acm001.amt7[ 1]  = sicsyac.acm002.amt7[ 1]
  acm001.amt7[ 2]  = sicsyac.acm002.amt7[ 2]
  acm001.amt7[ 3]  = sicsyac.acm002.amt7[ 3]
  acm001.amt7[ 4]  = sicsyac.acm002.amt7[ 4]
  acm001.amt7[ 5]  = sicsyac.acm002.amt7[ 5]
  acm001.amt7[ 6]  = sicsyac.acm002.amt7[ 6]
  acm001.amt7[ 7]  = sicsyac.acm002.amt7[ 7]
  acm001.amt7[ 8]  = sicsyac.acm002.amt7[ 8]
  acm001.amt7[ 9]  = sicsyac.acm002.amt7[ 9]
  acm001.amt7[10]  = sicsyac.acm002.amt7[10]
  acm001.amt7[11]  = sicsyac.acm002.amt7[11]
  acm001.amt7[12]  = sicsyac.acm002.amt7[12]
  acm001.amt7[13]  = sicsyac.acm002.amt7[13]
  acm001.amt7[14]  = sicsyac.acm002.amt7[14]
  acm001.amtl1     = sicsyac.acm002.amtl1
  acm001.amtl2     = sicsyac.acm002.amtl2
  acm001.amtl3     = sicsyac.acm002.amtl3
  acm001.amtl4     = sicsyac.acm002.amtl4
  acm001.amtl5     = sicsyac.acm002.amtl5
  acm001.amtl6     = sicsyac.acm002.amtl6
  acm001.amtl7[ 1] = sicsyac.acm002.amtl7[ 1]
  acm001.amtl7[ 2] = sicsyac.acm002.amtl7[ 2]
  acm001.amtl7[ 3] = sicsyac.acm002.amtl7[ 3]
  acm001.amtl7[ 4] = sicsyac.acm002.amtl7[ 4]
  acm001.amtl7[ 5] = sicsyac.acm002.amtl7[ 5]
  acm001.amtl7[ 6] = sicsyac.acm002.amtl7[ 6]
  acm001.amtl7[ 7] = sicsyac.acm002.amtl7[ 7]
  acm001.amtl7[ 8] = sicsyac.acm002.amtl7[ 8]
  acm001.amtl7[ 9] = sicsyac.acm002.amtl7[ 9]
  acm001.amtl7[10] = sicsyac.acm002.amtl7[10]
  acm001.amtl7[11] = sicsyac.acm002.amtl7[11]
  acm001.amtl7[12] = sicsyac.acm002.amtl7[12]
  acm001.amtl7[13] = sicsyac.acm002.amtl7[13]
  acm001.amtl7[14] = sicsyac.acm002.amtl7[14].
ASSIGN
  acm001.dept      = sicsyac.acm002.dept
  acm001.docaie    = sicsyac.acm002.docaie
  acm001.dname     = sicsyac.acm002.dname
  acm001.daddr1    = sicsyac.acm002.daddr1
  acm001.daddr2    = sicsyac.acm002.daddr2
  acm001.daddr3    = sicsyac.acm002.daddr3
  acm001.daddr4    = sicsyac.acm002.daddr4
  acm001.dpostc    = sicsyac.acm002.dpostc
  acm001.dpostc    = sicsyac.acm002.dpostc
  acm001.detal1    = sicsyac.acm002.detal1
  acm001.detal2    = sicsyac.acm002.detal2
  acm001.bankp     = NO             /*  5.1.additon (b) */
  acm001.dociln    = sicsyac.acm002.dociln
  acm001.cheqpr    = sicsyac.acm002.cheqpr
  acm001.prog      = sicsyac.acm002.prog
  acm001.fptr01    = sicsyac.acm002.fptr01
  acm001.bptr01    = sicsyac.acm002.bptr01
  acm001.latdat    = ?              /*  5.1.additon (b) */
  acm001.langug    = sicsyac.acm002.langug
  acm001.lattyp    = "".

ASSIGN
  acm001.rencnt    = sic_bran.uwm100.rencnt
  acm001.endcnt    = sic_bran.uwm100.endcnt.

gv_acm001OK = YES.

/*--- A57-0361 ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_acm002 wgwtrn70 
PROCEDURE PD_acm002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- A57-0361 ---*/
DEF VAR n_cnt       AS INT.
DEF VAR n_branch    AS CHAR.
DEF VAR n_dept      AS CHAR.
DEF VAR n_poltyp    AS CHAR.
DEF VAR n_domoff    AS CHAR.
DEF VAR n_region    AS CHAR.
DEF VAR N_IO        AS CHAR.
DEF VAR nt_cnt      AS INT.
DEF VAR nt_ac       AS CHAR EXTENT 8.
DEF VAR nt_amt      AS DECI EXTENT 8.

/* uwo10091.i   
   uwo10093.i  รับค่าผ่าน parameter เป็นบางค่า
   uwo10095.i  Now,Update Coinsurance and Facultative Transactions
*/

gv_acm002OK = NO.

CREATE sicsyac.acm002.
ASSIGN
  sicsyac.acm002.acno   = sic_bran.uwm100.acno1   /*  5.1.(1) */
  sicsyac.acm002.agent  = sic_bran.uwm100.agent   /*  5.1.(1.1) 000059 */
  sicsyac.acm002.curcod = sic_bran.uwm100.curbil  /*  5.1.(2) */
  sicsyac.acm002.branch = sic_bran.uwm100.branch  /*  5.1.(3) */
  
  /*  5.1.(4) is put to end of include file because it dependents on (15) */
  sicsyac.acm002.ac_mth = 0             /*  5.1.(5) */
  sicsyac.acm002.ac_yr  = 0             /*     :    */
  sicsyac.acm002.amtl1  = 0             /*     :    */
  sicsyac.acm002.amtl2  = 0             /*     :    */
  sicsyac.acm002.amtl3  = 0             /*     :    */
  sicsyac.acm002.amtl4  = 0             /*     :    */
  sicsyac.acm002.amtl5  = 0             /*     :    */
  sicsyac.acm002.amtl6  = 0             /*  5.1.(5) */
  sicsyac.acm002.amtl7[1] = 0           /*     :    */
  sicsyac.acm002.amtl7[2] = 0           /*     :    */
  sicsyac.acm002.amtl7[3] = 0           /*     :    */
  sicsyac.acm002.amtl7[4] = 0           /*     :    */
  sicsyac.acm002.amtl7[5] = 0           /*     :    */
  sicsyac.acm002.amtl7[6] = 0           /*     :    */
  sicsyac.acm002.amtl7[7] = 0           /*     :    */
  sicsyac.acm002.amtl7[8] = 0           /*     :    */
  sicsyac.acm002.amtl7[9] = 0           /*     :    */
  sicsyac.acm002.amtl7[10] = 0          /*     :    */
  sicsyac.acm002.amtl7[11] = 0          /*     :    */
  sicsyac.acm002.amtl7[12] = 0          /*     :    */
  sicsyac.acm002.amtl7[13] = 0          /*     :    */
  sicsyac.acm002.amtl7[14] = 0.         /*  5.1.(5) */

ASSIGN
  sicsyac.acm002.trndat = TODAY             /*sic_bran.uwm100.trndat */    /*  5.1.(6)else */
  sicsyac.acm002.prem   = sic_bran.uwm100.prem_t                           /*  5.1.(7)else */
  sicsyac.acm002.comm   = sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t           /*  5.1.(8)else */
  sicsyac.acm002.stamp  = sic_bran.uwm100.pstp   + sic_bran.uwm100.rstp_t           /*  5.1.(9)else */
  sicsyac.acm002.fee    = sic_bran.uwm100.pfee   + sic_bran.uwm100.rfee_t           /*  5.1.(10)else*/
  sicsyac.acm002.tax    = sic_bran.uwm100.ptax   + sic_bran.uwm100.rtax_t           /*  5.1.(11)else*/
  sicsyac.acm002.insno  = 1                                       /*  5.1.(18)else*/
  sicsyac.acm002.instot = sic_bran.uwm100.instot
  sicsyac.acm002.docno  = sic_bran.uwm100.docno1
  sicsyac.acm002.recno  = IF sic_bran.uwm100.endno <> "" THEN sic_bran.uwm100.endno ELSE sic_bran.uwm100.renno.                         /*  5.1.(23) */    
    
  .

ASSIGN
  sicsyac.acm002.comdat = sic_bran.uwm100.comdat                         /*  5.1.(22) */
  sicsyac.acm002.poltyp = sic_bran.uwm100.poltyp                         /*     :     */
  sicsyac.acm002.policy = sic_bran.uwm100.policy                         /*     :     */
  sicsyac.acm002.cn_no  = sic_bran.uwm100.cn_no                          /*     :     */
  sicsyac.acm002.insref = sic_bran.uwm100.insref                         /*     :     */
  sicsyac.acm002.cedco  = sic_bran.uwm100.cedco                          /*     :     */
  sicsyac.acm002.dept   = sic_bran.uwm100.dept                           /*  5.1.(22) */
  sicsyac.acm002.disput = NO                                    /*  5.1.(25) */
  sicsyac.acm002.mlno   = sic_bran.uwm100.receit                         /*  5.1.(26) */
  sicsyac.acm002.mltyp1 = IF sicsyac.acm002.mlno = "" THEN "" ELSE "Y" /*  5.1.(27) */
  sicsyac.acm002.cedref = sic_bran.uwm100.cedpol                         /*  5.1.(28) */
  sicsyac.acm002.thcess = sic_bran.uwm100.cedces                         /*  5.1.(28) */
  sicsyac.acm002.usrid  = SUBSTRING(n_user,3,6)                 /*  5.1.(29) */
  sicsyac.acm002.entdat = TODAY                                 /*     :     */
  sicsyac.acm002.enttim = STRING(TIME,"hh:mm:ss")               /*  5.1.(29) */
  .

  sicsyac.acm002.amt1   = sicsyac.acm002.netamt.                       /*  5.1.(30) */

ASSIGN 

  sicsyac.acm002.netamt = sicsyac.acm002.prem + sicsyac.acm002.comm + sicsyac.acm002.stamp + sicsyac.acm002.fee  + sicsyac.acm002.tax      /*  5.1.(12) */
  sicsyac.acm002.netloc = ROUND(sicsyac.acm002.netamt * sic_bran.uwm100.curate , 2)    /*  5.1.(13) */                  
  sicsyac.acm002.bal    = sicsyac.acm002.netamt                               /*  5.1.(14) */                  
  sicsyac.acm002.baloc  = sicsyac.acm002.netloc.                              /*  5.1.(14) */                  

  sicsyac.acm002.trnty1 = IF sicsyac.acm002.netamt >= 0 THEN IF sic_bran.uwm100.dir_ri THEN "M"                         
                                               ELSE "O"                                          
                   ELSE IF sic_bran.uwm100.dir_ri THEN "R" ELSE "T".                                      /*  5.1.(15).1 */
IF (sicsyac.acm002.prem <= 0 AND sicsyac.acm002.stamp <= 0 AND sicsyac.acm002.tax <= 0) AND sicsyac.acm002.comm > 0 THEN  
    sicsyac.acm002.trnty1 =  IF sic_bran.uwm100.dir_ri THEN "R"  ELSE "T".

  sicsyac.acm002.trnty2 = sic_bran.uwm100.tranty.                              /*  5.1.(16)   */

FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = sicsyac.acm002.acno NO-LOCK NO-ERROR NO-WAIT.
ASSIGN
  sicsyac.acm002.clicod = xmm600.clicod    /*  5.1.(20).1 */
  sicsyac.acm002.acccod = xmm600.acccod.   /*  5.1.(20).2 */

/*  5.1.(32) */
ASSIGN
  sicsyac.acm002.amt2    = - sic_bran.uwm100.prem_t
  sicsyac.acm002.amt3    = - (sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t)
  sicsyac.acm002.amt4    = - sic_bran.uwm100.pstp
  sicsyac.acm002.amt5    = - sic_bran.uwm100.pfee
  sicsyac.acm002.amt6    = - sic_bran.uwm100.ptax
  sicsyac.acm002.amt7[1] = - sic_bran.uwm100.rstp_t     /* amt7 */
  sicsyac.acm002.amt7[2] = - sic_bran.uwm100.rfee_t     /* amt8 */
  sicsyac.acm002.amt7[3] = - sic_bran.uwm100.rtax_t.    /* amt9 */
/* end of  5.1.(32) */

n_cnt = 0.
sicsyac.acm002.vehreg = "".

FOR EACH sic_bran.uwm301 USE-INDEX uwm30101
    WHERE sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
          sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
          sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt :
 ASSIGN 
   n_cnt = n_cnt + 1 
   sicsyac.acm002.vehreg = sic_bran.uwm301.vehreg.  /*  5.1.(24) */
END.
IF n_cnt > 1 THEN  sicsyac.acm002.vehreg = "VARIOUS".      /* end of  5.1.(24) */

/*  5.1.(31) */
FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = sicsyac.acm002.acno NO-LOCK NO-WAIT NO-ERROR.
FIND sicsyac.xmm022 USE-INDEX xmm02201 WHERE xmm022.acccod = xmm600.acccod NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL xmm022 THEN sicsyac.acm002.ac1 = xmm022.gldebt.
ELSE DO:
  FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
  IF xmm090.glref = "0" THEN DO:
     sicsyac.acm002.ac1 = "".  /*  5.1.(31).[1] */
  END.
END.
/* end of  5.1.(31) */


/*  5.1.(33) */
FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
  n_branch = IF xmm090.brsep  THEN  sicsyac.acm002.branch ELSE "".         /*  5.1.33.i */
  n_dept   = IF xmm090.depsep THEN  sicsyac.acm002.dept   ELSE "".         /*  5.1.33.ii */
  n_poltyp = IF xmm090.polsep THEN  sicsyac.acm002.poltyp ELSE "".         /*  5.1.33.iii */

IF NOT xmm090.dosep  THEN n_domoff = "" .
ELSE DO:
  FIND FIRST sicsyac.xmm024 NO-LOCK NO-ERROR.
  n_domoff = if sic_bran.uwm100.cntry = xmm024.bascty then "D" else "O".
END.

IF xmm090.regsep AND NOT sic_bran.uwm100.dir_ri  THEN DO: 
  FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = sicsyac.acm002.acno NO-LOCK NO-ERROR NO-WAIT.
  FIND sicsyac.xmm011 USE-INDEX xmm01101 WHERE xmm011.cntry = xmm600.cntry NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL xmm011 THEN n_region = xmm011.region.
  ELSE n_region = "".
END.
ELSE
n_region = "".
N_IO = "I".

FIND sicsyac.xmm202 USE-INDEX xmm20201 WHERE
     xmm202.branch = n_branch      AND
     xmm202.dept   = n_dept        AND
     xmm202.poltyp = n_poltyp      AND
     xmm202.domoff = n_domoff      AND
     xmm202.in_out = n_io          AND
     xmm202.dir_ri = sic_bran.uwm100.dir_ri AND
     xmm202.region = n_region      NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL xmm202 THEN DO:

    DO nt_cnt = 1 TO 8:
      nt_ac[nt_cnt] = "".
      nt_amt[nt_cnt] = 0.
    END.

    nt_cnt = 0.

    /* Jiraphon P. A62-0286
    {uw/uwo10097.i amt2 premgl}
    {uw/uwo10097.i amt3 commgl}
    {uw/uwo10097.i amt4 pstpgl}
    {uw/uwo10097.i amt5 pfeegl}
    {uw/uwo10097.i amt6 ptaxgl}
    {uw/uwo10097.i amt7[1] rstpgl}
    {uw/uwo10097.i amt7[2] rfeegl}
    {uw/uwo10097.i amt7[3] rtaxgl}
    */
    /*Add Jiraphon P. A62-0286*/
    {WGW/WGW20097.i amt2 premgl}
    {WGW/WGW20097.i amt3 commgl}
    {WGW/WGW20097.i amt4 pstpgl}
    {WGW/WGW20097.i amt5 pfeegl}
    {WGW/WGW20097.i amt6 ptaxgl}
    {WGW/WGW20097.i amt7[1] rstpgl}
    {WGW/WGW20097.i amt7[2] rfeegl}
    {WGW/WGW20097.i amt7[3] rtaxgl}
    /*End Add Jiraphon P. A62-0286*/

  ASSIGN
    sicsyac.acm002.ac2     = nt_ac[1]
    sicsyac.acm002.amt2    = nt_amt[1]
    sicsyac.acm002.ac3     = nt_ac[2]
    sicsyac.acm002.amt3    = nt_amt[2]
    sicsyac.acm002.ac4     = nt_ac[3]
    sicsyac.acm002.amt4    = nt_amt[3]
    sicsyac.acm002.ac5     = nt_ac[4]
    sicsyac.acm002.amt5    = nt_amt[4]
    sicsyac.acm002.ac6     = nt_ac[5]
    sicsyac.acm002.amt6    = nt_amt[5]
    sicsyac.acm002.ac7[1]  = nt_ac[6]
    sicsyac.acm002.amt7[1] = nt_amt[6]
    sicsyac.acm002.ac7[2]  = nt_ac[7]
    sicsyac.acm002.amt7[2] = nt_amt[7]
    sicsyac.acm002.ac7[3]  = nt_ac[8]
    sicsyac.acm002.amt7[3] = nt_amt[8].
END.
ELSE
DO:
  FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
  IF xmm090.glref = "0" THEN DO:
    ASSIGN
      sicsyac.acm002.ac2    = ""
      sicsyac.acm002.ac3    = ""
      sicsyac.acm002.ac4    = ""
      sicsyac.acm002.ac5    = ""
      sicsyac.acm002.ac6    = ""
      sicsyac.acm002.ac7[1] = ""            /* ac7 */
      sicsyac.acm002.ac7[2] = ""            /* ac8 */
      sicsyac.acm002.ac7[3] = "".           /* ac9 */
  END.
END.
/* end of  5.1.(33) */

/*  5.1.(34) */
ASSIGN
  sicsyac.acm002.ac7[4]  = "" sicsyac.acm002.amt7[4]  = 0   /* ac10,amt10 */
  sicsyac.acm002.ac7[5]  = "" sicsyac.acm002.amt7[5]  = 0   /* ac11,amt11 */
  sicsyac.acm002.ac7[6]  = "" sicsyac.acm002.amt7[6]  = 0   /* ac12,amt12 */
  sicsyac.acm002.ac7[7]  = "" sicsyac.acm002.amt7[7]  = 0   /* ac13,amt13 */
  sicsyac.acm002.ac7[8]  = "" sicsyac.acm002.amt7[8]  = 0   /* ac14,amt14 */
  sicsyac.acm002.ac7[9]  = "" sicsyac.acm002.amt7[9]  = 0   /* ac15,amt15 */
  sicsyac.acm002.ac7[10] = "" sicsyac.acm002.amt7[10] = 0   /* ac16,amt16 */
  sicsyac.acm002.ac7[11] = "" sicsyac.acm002.amt7[11] = 0   /* ac17,amt17 */
  sicsyac.acm002.ac7[12] = "" sicsyac.acm002.amt7[12] = 0   /* ac18,amt18 */
  sicsyac.acm002.ac7[13] = "" sicsyac.acm002.amt7[13] = 0   /* ac19,amt19 */
  sicsyac.acm002.ac7[14] = IF sic_bran.uwm100.endcnt = 0 THEN "" ELSE STRING(sic_bran.uwm100.enddat,"99/99/9999") 
                       sicsyac.acm002.amt7[14] = 0. 
/* end of  5.1.(34) */

ASSIGN
  sicsyac.acm002.docaie = IF sic_bran.uwm100.insddr THEN "I" ELSE "A" /*  5.1.(35) */
  sicsyac.acm002.prog   = "uwo10091"                         /*  5.1.(36) */
  sicsyac.acm002.cheqpr = NO                                 /*  5.1.(37) */
  sicsyac.acm002.dociln = "N"                                /*  5.1.(37) */

  sicsyac.acm002.cheque = ""                                 /*  5.1.(38) */
  sicsyac.acm002.erldat = ?                                  /*     :     */
  sicsyac.acm002.cedno  = ""                                 /*     :     */
  sicsyac.acm002.cedent = ""                                 /*     :     */
  sicsyac.acm002.bankno = ""                                 /*     :     */
  sicsyac.acm002.dname  = ""                                 /*     :     */
  sicsyac.acm002.daddr1 = ""                                 /*     :     */
  sicsyac.acm002.daddr2 = ""                                 /*     :     */
  sicsyac.acm002.daddr3 = ""                                 /*     :     */
  sicsyac.acm002.daddr4 = ""                                 /*     :     */
  sicsyac.acm002.detal1 = ""                                 /*     :     */
  sicsyac.acm002.dpostc = ""                                 /*     :     */
  sicsyac.acm002.detal2 = ""                                 /*  5.1.(38) */
  sicsyac.acm002.docp   = YES                                /*  5.1.(39) */
  sicsyac.acm002.bpayp  = YES                                /*     :     */
  sicsyac.acm002.chqptd = YES                                /*     :     */
  sicsyac.acm002.docbr  = NO                                 /*     :     */
  sicsyac.acm002.docho  = NO                                 /*     :     */
  sicsyac.acm002.tranbr = NO                                 /*     :     */
  sicsyac.acm002.tranho = NO                                 /*     :     */
  sicsyac.acm002.glupd  = NO                                 /*  5.1.(39) */
  sicsyac.acm002.langug = " "                                /*  5.1.(40) */

sicsyac.acm002.trangp = IF INDEX("MNOPRSTU",sicsyac.acm002.trnty1) <> 0 THEN "1"
            ELSE IF INDEX("WX",      sicsyac.acm002.trnty1) <> 0 THEN "2"
            ELSE IF INDEX("Y"       ,sicsyac.acm002.trnty1) <> 0 THEN "3"
            ELSE IF INDEX("Z"       ,sicsyac.acm002.trnty1) <> 0 THEN "4"
            ELSE IF INDEX("QV"      ,sicsyac.acm002.trnty1) <> 0 THEN "5"
            ELSE IF INDEX("AB"      ,sicsyac.acm002.trnty1) <> 0 THEN "6"
            ELSE "".                                    /*  5.1.(4)  */

/*  5.1.(21) */
sicsyac.acm002.ref = IF sic_bran.uwm100.cedpol <> "" THEN ( "Your Policy " + sic_bran.uwm100.cedpol) ELSE "".

sicsyac.acm002.ref = sicsyac.acm002.ref  +
              (if trim(sicsyac.acm002.ref) = " " then "" else " ") +
              ( IF sic_bran.uwm100.cedces <> ""  THEN ("Cession no. " + sic_bran.uwm100.cedces)
              ELSE "" ).

IF sicsyac.acm002.ref = "" THEN DO:
  SUBSTRING(sicsyac.acm002.ref,1,47) = (if sic_bran.uwm100.agtref = " " then "" else sic_bran.uwm100.agtref + " ") + sicsyac.acm002.vehreg + 
                                (if sicsyac.acm002.vehreg = " " then "" else " ") + sic_bran.uwm100.ntitle +
                                (if sic_bran.uwm100.ntitle <> "" then " " else "" ) + sic_bran.uwm100.fname  +
                                (if sic_bran.uwm100.fname <> "" then " " else ""  ) + sic_bran.uwm100.name1.
END.
/* end of  5.1.(21) */

ASSIGN
  sicsyac.acm002.bptr01 = 0
  sicsyac.acm002.fptr01 = 0 .

gv_acm002OK = YES.

/* END uwo10091.i */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ChkRelease wgwtrn70 
PROCEDURE PD_ChkRelease :
/*------------------------------------------------------------------------------
  Purpose:  เพิ่มการ Release ไปที่ Account พร้อมกับตอน Transfer GW to Premium
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Tantawan --- A57-0361 ---- Check Error befor Release to Account ---*/
DEF VAR nv_rprem AS DECI.
DEF VAR nv_rstp  AS DECI.
DEF VAR nv_rtax  AS DECI.
DEF VAR nv_rcom  AS DECI.
DEF VAR nv_wprem AS DECI.

DEF VAR nv_uwd132 AS LOG.

nv_trnyes = YES.

ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

/*  5.1.17.(iv) */
FIND sicsyac.acm001 USE-INDEX acm00101 
      WHERE acm001.trnty1 = sic_bran.uwm100.trty11 AND
            acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR .
IF AVAIL acm001 THEN DO:
    ASSIGN
      putchr1 = "Document No. already on Account Master file acm001".
      putchr  = textchr  + "  " + TRIM(putchr1).

     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.
END.

/**/
FIND FIRST sicsyac.acm002 USE-INDEX acm00201 
        WHERE acm002.trnty1 = sic_bran.uwm100.trty11 AND
              acm002.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
IF AVAIL acm002 THEN DO: /* docno ไม่ซ้ำ */
  ASSIGN
      putchr1 = "Document No. already on Account Master file acm002" + acm002.policy.
      putchr  = textchr  + "  " + TRIM(putchr1).

     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.
END.
/**/

IF  sic_bran.uwm100.prem_t  <> 0         THEN DO:
    IF (sic_bran.uwm100.docno1  = "0000000"  OR
        sic_bran.uwm100.docno1  = "" )       THEN DO:
        ASSIGN
          putchr1 = "Dr/Cr not print".
          putchr  = textchr  + "  " + TRIM(putchr1).

         PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_trnyes = No.
    END.
END.

FOR EACH  sic_bran.uwm120
    WHERE sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
          sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
          sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK.

   nv_rprem  = nv_rprem  + sic_bran.uwm120.prem_r.
   nv_rstp   = nv_rstp   + sic_bran.uwm120.rstp_r.
   nv_rtax   = nv_rtax   + sic_bran.uwm120.rtax_r.
   nv_rcom   = nv_rcom   + sic_bran.uwm120.com1_r + sic_bran.uwm120.com2_r.
END.

IF  sic_bran.uwm100.prem_t  <> nv_rprem   THEN DO:
   ASSIGN
     putchr1 = "Premium Policy (uwm100) not equal Risk (sic_bran.uwm120) ".
     putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_trnyes = No.
END.

IF  sic_bran.uwm100.rstp_t  <> nv_rstp    THEN DO:

   ASSIGN
     putchr1 = "Stamp  Policy (uwm100) not equal Risk (sic_bran.uwm120)".
     putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_trnyes = No.
END.

IF  sic_bran.uwm100.rtax_t  <> nv_rtax   THEN DO:
   ASSIGN
     putchr1 = "Tax Policy (uwm100) not equal Risk (sic_bran.uwm120)".
     putchr  = textchr  + "  " + TRIM(putchr1).

    PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_trnyes = No.
END.

IF (sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t)  <> nv_rcom THEN DO:

    ASSIGN
      putchr1 = "Commission Policy (uwm100) not equal Risk (sic_bran.uwm120)".
      putchr  = textchr  + "  " + TRIM(putchr1).

     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.
END.


FOR EACH  sic_bran.uwd132  
    WHERE  sic_bran.uwd132.policy  = sic_bran.uwm100.policy  AND
           sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt  AND
           sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK .

   nv_wprem  = nv_wprem  + sic_bran.uwd132.prem_c.
END.

IF  sic_bran.uwm100.prem_t  <> nv_wprem   THEN DO:
    ASSIGN
      putchr1 = "Premium Policy (sic_bran.uwm100) not equal Insured Item (sic_bran.uwd132)".
      putchr  = textchr  + "  " + TRIM(putchr1).

     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.
END.

IF  sic_bran.uwm100.sch_p = NO OR sic_bran.uwm100.drn_p = NO  THEN DO:
    ASSIGN
      putchr1 = "Policy or Debit Note is not print , Can't transfer to Account".
      putchr  = textchr  + "  " + TRIM(putchr1).

     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.
END.

/*Add A67-0181*/
IF sic_bran.uwm100.poltyp >= "V72" AND sic_bran.uwm100.poltyp <= "V74"  THEN DO:
    n_classchk = "".
    IF sic_bran.uwm100.polsta <> "CA" THEN DO: 
        IF sic_bran.uwm100.endcnt = 0 THEN DO:
            FIND LAST sic_bran.uwm120 USE-INDEX uwm12001 WHERE sic_bran.uwm120.policy = sic_bran.uwm100.policy AND 
                sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uwm120 THEN DO:
                IF SUBSTRING(sic_bran.uwm120.class,1,1) >= "0" AND SUBSTRING(sic_bran.uwm120.class,1,1) <= "9" THEN DO:
                    IF SUBSTRING(sic_bran.uwm120.class,LENGTH(sic_bran.uwm120.class)) = "E" THEN DO:
                        RUN WUW\wuwpuzpdt(INPUT  TODAY         ,
                                          INPUT  "Form_Print"  ,
                                          INPUT  ""            ,
                                          INPUT  "COMPULSORY"  ,
                                          INPUT  sic_bran.uwm120.class  ,
                                          OUTPUT n_classchk    ,
                                          OUTPUT n_classtyp    ).
                        IF n_classchk <> "Y" THEN DO:
                            putchr1 = "โปรดตรวจสอบรหัสรถ " + sic_bran.uwm120.CLASS + " " + string(sic_bran.uwm120.riskno).
                            putchr  = textchr  + "  " + TRIM(putchr1).
            
                            PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
                            nv_message = putchr1.
                            nv_trnyes = No.
                        END.
                    END.
                END.
            END.
        END.
        ELSE DO:
            FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uwm120 THEN DO:
    
                FIND LAST buwm120 USE-INDEX uwm12001 WHERE buwm120.policy = sic_bran.uwm100.policy AND 
                    buwm120.rencnt = sic_bran.uwm100.rencnt AND
                    buwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
                IF AVAIL buwm120 THEN DO:
    
                    IF sic_bran.uwm120.riskno <> buwm120.riskno THEN DO:
                        IF sic_bran.uwm120.CLASS <> buwm120.CLASS THEN DO:
                            IF SUBSTRING(buwm120.class,1,1) >= "0" AND SUBSTRING(buwm120.class,1,1) <= "9" THEN DO:
                                IF SUBSTRING(buwm120.class,LENGTH(buwm120.class)) = "E" THEN DO:
                                    RUN WUW\wuwpuzpdt(INPUT  TODAY     ,
                                                      INPUT  "Form_Print"  ,
                                                      INPUT  ""            ,
                                                      INPUT  "COMPULSORY"  ,
                                                      INPUT  buwm120.class ,
                                                      OUTPUT n_classchk    ,
                                                      OUTPUT n_classtyp    ).
                                    IF n_classchk <> "Y" THEN DO:
                                        putchr1 = "โปรดตรวจสอบรหัสรถ " + buwm120.CLASS + " " + string(buwm120.riskno).
                                        putchr  = textchr  + "  " + TRIM(putchr1).
                        
                                        PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
                                        nv_message = putchr1.
                                        nv_trnyes = No.
                                    END.
                                END.
                            END.
                        END.
                    END.
                END.
            END.
        END.
    END.
    /*
    FOR EACH sic_bran.uwm120 WHERE sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                                   sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                                   sic_bran.uwm120.endcnt = 0 NO-LOCK.

        IF SUBSTRING(sic_bran.uwm120.class,1,1) >= "0" AND SUBSTRING(sic_bran.uwm120.class,1,1) <= "9" THEN DO:
            IF SUBSTRING(sic_bran.uwm120.class,LENGTH(sic_bran.uwm120.class)) = "E" THEN DO:
                putchr1 = "โปรดตรวจสอบรหัสรถ " + sic_bran.uwm120.CLASS + " " + string(sic_bran.uwm120.riskno).
                putchr  = textchr  + "  " + TRIM(putchr1).

                PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
                nv_message = putchr1.
                nv_trnyes = No.
            END.
        END.
    END.
    */
END.
/*End A67-0181*/

IF  sic_bran.uwm100.prem_t <> 0 OR sic_bran.uwm100.com1_t <> 0 OR sic_bran.uwm100.com2_t <> 0 OR
    sic_bran.uwm100.pstp   <> 0 OR sic_bran.uwm100.pfee   <> 0 OR sic_bran.uwm100.ptax   <> 0 OR
    sic_bran.uwm100.rstp_t <> 0 OR sic_bran.uwm100.rfee_t <> 0 OR sic_bran.uwm100.rtax_t <> 0 THEN DO:

    /*IF  INTEGER(sic_bran.uwm100.docno1) = 0  THEN DO:*/   /*Kridtiya i. A63-00029*/
    IF  sic_bran.uwm100.docno1  = ""           OR           /*Kridtiya i. A63-00029*/
        sic_bran.uwm100.docno1  = "0000000"    OR           /*Kridtiya i. A63-00029*/
        sic_bran.uwm100.docno1  = "0000000000"   THEN DO:   /*Kridtiya i. A63-00029*/

        ASSIGN
          putchr1 = "ไมมีเลขที่ใบแจ้งหนี้หรือใบลดหนี้".
          putchr  = textchr  + "  " + TRIM(putchr1).
    
         PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
         nv_message = putchr1.
         nv_trnyes = No.
    END.
END.

IF (sic_bran.uwm100.poltyp = "V72"  OR
    sic_bran.uwm100.poltyp = "V73"  OR
    sic_bran.uwm100.poltyp = "V74") THEN DO:

   nv_uwd132 = YES.

   FOR EACH sic_bran.uwm130  WHERE
            sic_bran.uwm130.policy  = sic_bran.uwm100.policy  AND
            sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK:

     FIND FIRST sic_bran.uwd132  WHERE
                sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp  AND
                sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  NO-LOCK NO-ERROR NO-WAIT.
     IF NOT AVAILABLE sic_bran.uwd132 THEN nv_uwd132 = NO.

   END.

   IF nv_uwd132 = NO THEN DO:
        ASSIGN
         putchr1 = "ไม่พบข้อมูล หน้าเบี้ย(uwd132) ติดต่อ Computer".
         putchr  = textchr  + "  " + TRIM(putchr1).
   
        PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_trnyes = No.
   END.
END.

 /* เช็คกรมธรรม์ พรบ.ว่ามีเลขที่ Sticker หรือไม่! */
IF (sic_bran.uwm100.poltyp = "V70"  OR
    sic_bran.uwm100.poltyp = "V72"  OR
    sic_bran.uwm100.poltyp = "V73"  OR
    sic_bran.uwm100.poltyp = "V74") THEN DO:

    FIND FIRST sic_bran.uwm130  WHERE
               sic_bran.uwm130.policy  = sic_bran.uwm100.policy  AND
               sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
               sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sic_bran.uwm130 THEN DO:
        ASSIGN
         putchr1 = "ไม่พบข้อมูล รายการคุ้มครอง(sic_bran.uwm130) ติดต่อ Computer".
         putchr  = textchr  + "  " + TRIM(putchr1).
   
        PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_trnyes = No.

    END.
END.

FIND FIRST sicsyac.xmm600 WHERE xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.
IF NOT AVAIL xmm600 THEN DO:
   ASSIGN
    putchr1 = "Not found Agent,Producer Can not Release to Account".
    putchr  = textchr  + "  " + TRIM(putchr1).
   
   PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
   nv_message = putchr1.
   nv_trnyes = No.
END. 
ELSE DO:
   FIND sicsyac.xmm022 USE-INDEX xmm02201 WHERE xmm022.acccod = xmm600.acccod NO-LOCK NO-WAIT NO-ERROR.
   IF NOT AVAIL xmm022 THEN DO:
   
     FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
     IF xmm090.glref <> "0" THEN DO:
       ASSIGN
        putchr1 = "Policy Release cannot find GL Debtor Control A/C No. xmm022".
        putchr  = textchr  + "  " + TRIM(putchr1).
   
       PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
       nv_message = putchr1.
       nv_trnyes = No.
     END.
   END.

   FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
   IF xmm090.glref <> "0" THEN DO:
      ASSIGN
       putchr1 = "Policy Release cannot find GL A/C Nos. on xmm202".
       putchr  = textchr  + "  " + TRIM(putchr1).

      PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
      nv_message = putchr1.
      nv_trnyes = No.
   END.
  /*------- Comment A64-0038 ------
  IF   xmm600.acccod   <> "AG"  AND      /* direc */
       xmm600.acccod   <> "BR"  AND 
       xmm600.acccod   <> "RD"  AND      /* inward */
       xmm600.acccod   <> "RF"  AND 
       xmm600.acccod   <> "RB"  THEN DO :
 
     ASSIGN
      putchr1 = "Not AGENT/BROKER TYPE, Can't Release to Account".
      putchr  = textchr  + "  " + TRIM(putchr1).
 
     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.

  END.
  ------ Comment A64-0038 ----*/
END.

 /*--------------------------*/

IF sic_bran.uwm100.agent  = "" OR sic_bran.uwm100.agent = "." OR
   sic_bran.uwm100.acno1  = "" OR sic_bran.uwm100.acno1 = "." THEN DO:
    ASSIGN
     putchr1 = "Code Agent,Producer is Blank or point Can not Releas to Account".
     putchr  = textchr  + "  " + TRIM(putchr1).
  
    PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_trnyes = No.
END.

 /* ------- */
 IF  sic_bran.uwm100.acno1  = "B300100" OR
     sic_bran.uwm100.acno1  = "B3V0100" OR
     sic_bran.uwm100.acno1  = "B3K0100" OR
     sic_bran.uwm100.acno1  = "B3C0100" OR
     sic_bran.uwm100.acno1  = "B3V2100" THEN DO:

     ASSIGN
      putchr1 = "Code Producer is Sriprathom , Can not Releas to Account".
      putchr  = textchr  + "  " + TRIM(putchr1).
   
     PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_trnyes = No.

 END.
 /* ------- */
 
 IF nv_trnyes = YES THEN DO:   /* ไม่มี Error */
 
    RUN PD_Release.
 END.
 ELSE nv_relerr = nv_relerr + 1.

 /* เข้า OIC เฉพาะงาน พรบ. */
 IF  sic_bran.uwm100.poltyp  = "V72" OR  
     sic_bran.uwm100.poltyp  = "V73" OR
     sic_bran.uwm100.poltyp  = "V74" THEN DO:
 
     RUN PD_UZOICCOM .       

 END.
 ELSE DO: 
     IF sic_bran.uwm100.poltyp  = "V70" THEN DO:
         FIND FIRST uwd132  WHERE
                  uwd132.policy  = sic_bran.uwm100.policy  AND
                  uwd132.rencnt  = sic_bran.uwm100.rencnt  AND
                  uwd132.endcnt  = sic_bran.uwm100.endcnt  AND 
                  uwd132.bencod  = "COMP" NO-LOCK NO-ERROR NO-WAIT. /* เฉพาะ 70 ที่มีงาน พรบ. */
         IF AVAILABLE uwd132 THEN 
             RUN PD_UZOICCOM .       
     END.
 END.
/*--- Tantawan --- A57-0361 ---- Check Error befor Release to Account ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Release wgwtrn70 
PROCEDURE PD_Release :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 /*---Begin by Chaiyong W. A66-0116 08/09/2023*/
DEF VAR nv_st1 AS CHAR INIT "".
DEF VAR nv_st2 AS CHAR INIT "".
/*End  by Chaiyong W. A66-0116 08/09/2023----*/
/*--- A57-0361 ---*/
DO TRANSACTION:

    FIND FIRST sicsyac.acm002 USE-INDEX acm00201 
        WHERE acm002.trnty1 = sic_bran.uwm100.trty11 AND
              acm002.docno  = sic_bran.uwm100.docno1 NO-ERROR.
    IF NOT AVAIL acm002 THEN DO: /* docno ไม่ซ้ำ */

        RUN PD_acm002.

        IF gv_acm002OK THEN DO:

            FIND FIRST sicsyac.acm001 USE-INDEX acm00101
                WHERE acm001.trnty1 = sic_bran.uwm100.trty11 AND
                      acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
            IF NOT AVAIL acm001 THEN DO:  /* docno ไม่ซ้ำ */

                RUN PD_acm001.

                IF gv_acm001OK THEN DO:


                    DISPLAY  "Release to Account " @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwrelea (INPUT  nv_batchyr, INPUT  nv_batchno, INPUT  nv_batcnt, 
                                      INPUT  nv_Policy,  INPUT  nv_RenCnt,  INPUT  nv_EndCnt,
                                      INPUT-OUTPUT nv_relok ,
                                      INPUT-OUTPUT nv_relerr,
                                            OUTPUT nv_relyet).


                    /*---Begin by Chaiyong W. A66-0116 08/09/2023*/
                    nv_st1 = "Transfer".
                    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                        sicuw.uwm100.policy = sic_bran.uwm100.policy AND
                        sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
                        sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN RUN wuz\wuzvptv4(INPUT RECID(sicuw.uwm100),INPUT-OUTPUT nv_st1 ,OUTPUT nv_st2).
                  
                    /*End  by Chaiyong W. A66-0116 08/09/2023----*/


                END.
            END.
            ELSE DO:  /*-- begin A60-0174 --*/
                ASSIGN
                    putchr1 = "Document No. already on Account Master file acm001".
                putchr  = textchr  + "  " + TRIM(putchr1).
                
                PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
                nv_message = putchr1.
                nv_trnyes = No.
                nv_relerr = nv_relerr + 1.
            END.  /*-- end  A60-0174 --*/
        END.
    END.
    ELSE DO:  /*-- Add A58-0424 --*/
        ASSIGN
          putchr1 = "Document No. already on Account Master file acm002".
          putchr  = textchr  + "  " + TRIM(putchr1).
    
        PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_trnyes = No.
        nv_relerr = nv_relerr + 1.
    END. /*-- End Add A58-0424 --*/

END.

RELEASE acm002.
RELEASE acm001.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_UZOICCOM wgwtrn70 
PROCEDURE PD_UZOICCOM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*--- A57-0361 ---*/
/*
(     UZ\UZOICCOM     INPUT uwm100.policy,
                            uwm100.rencnt,
                            uwm100.endcnt,
                           "COMOICINT" ,
                            "UZO098" )
*/

DEFINE VAR nv_jobvat_id AS CHARACTER FORMAT "X(12)" INIT "COMOICINT".      /* Printer Id */
DEFINE VAR gv_prgid     AS CHARACTER FORMAT "X(12)" INIT "WGWTRN70.W".     /* Printer Id */

DEFINE VAR nv_message  AS CHARACTER                NO-UNDO.
DEFINE VAR nv_jobname  AS CHARACTER FORMAT "X(25)" INITIAL "" NO-UNDO.
DEFINE VAR nv_time     AS CHARACTER FORMAT "X(08)" INITIAL "" NO-UNDO.

DEFINE VAR nv_branch   AS CHARACTER FORMAT "X(02)".
DEFINE VAR nv_ptrid    AS CHARACTER FORMAT "X(10)".

DEFINE VAR nv_prioty   AS INTEGER                  INITIAL 0 .
DEFINE VAR nv_seq      AS INTEGER                  INITIAL 0 .

IF sic_bran.uwm100.releas = YES THEN DO:
    
    nv_ptrid   = nv_jobvat_id.
    nv_branch  = sic_bran.uwm100.branch.                           /* Branch     */
    nv_jobname = SUBSTRING(sic_bran.uwm100.policy,1,12)  + "-" +
                 STRING(sic_bran.uwm100.rencnt,"999")    + "/" +
                 STRING(sic_bran.uwm100.endcnt,"999").
    nv_time    = "".
    nv_time    = sic_bran.uwm100.enttim.
    nv_seq     = 0.
    
    FIND FIRST sicsyac.sqm001 USE-INDEX sqm00103   
         WHERE sqm001.jobno     = sic_bran.uwm100.policy 
         AND   sqm001.prmts[2]  = STRING(sic_bran.uwm100.rencnt,"999")
         AND   sqm001.prmts[3]  = STRING(sic_bran.uwm100.endcnt,"999")
         AND   sqm001.Jobq#     = nv_ptrid  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sqm001 THEN DO:
        loop_chk:
        REPEAT:
          nv_seq    = nv_seq + 1 . 
          nv_prioty = TIME.
          nv_time   = STRING(TIME,"HH:MM:SS") + STRING(nv_seq). /* suthida t. 24-06-56 12.00*/
        
          FIND FIRST sicsyac.sqm001 WHERE
                     sqm001.Jobq#  = nv_ptrid       AND 
                     sqm001.Prioty = nv_prioty      AND 
                     sqm001.Qdate  = sic_bran.uwm100.trndat  AND 
                     sqm001.Qtime  = nv_time        NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sqm001 THEN DO:
             PAUSE 1 NO-MESSAGE.        /* ห้ามปลดออก เพราะ ต้องการหน่วงเวลา */
             NEXT.
          END. 
          ELSE DO:

              DO TRANSACTION:
            
                CREATE sqm001.
                ASSIGN
            
                sqm001.Jobq#     = nv_ptrid           /*Job Queue = Printer Id*/
                sqm001.Prioty    = nv_prioty          /*Priority      */
                sqm001.Qdate     = sic_bran.uwm100.trndat      /*Date          */
                sqm001.Qtime     = nv_time                            
                sqm001.progid    = gv_prgid           /*Progid        */
                sqm001.Jobname   = nv_jobname         /*Jobname       */
                sqm001.schtim    = nv_time            /*Scheduled Time*/
                sqm001.schdat    = sic_bran.uwm100.trndat      /*Scheduled Date*/
                sqm001.Qname     = sic_bran.uwm100.name1       /*Jobname       */
                sqm001.Stsflg    = sic_bran.uwm100.polsta      /*Status        */
                /* -------------------------------------------------- */
                sqm001.Uname     = sic_bran.uwm100.usrid       /*User Name     */
                sqm001.Dbnme     = nv_branch          /*Dbname        */
                sqm001.Jobno     = sic_bran.uwm100.policy      /*Jobno         */
                sqm001.prmts[1]  = sic_bran.uwm100.policy      /*Paratms       */
                sqm001.prmts[2]  = STRING(sic_bran.uwm100.rencnt,"999")
                sqm001.prmts[3]  = STRING(sic_bran.uwm100.endcnt,"999")
                sqm001.prmts[4]  = sic_bran.uwm100.endno
                sqm001.prmts[5]  = ""
                sqm001.prmts[6]  = ""
                sqm001.prmts[7]  = ""
                sqm001.prmts[8]  = ""
                sqm001.prmts[9]  = ""
                
                sqm001.prmts[10] = sic_bran.uwm100.acno1
                sqm001.prmts[11] = sic_bran.uwm100.trty11
                sqm001.prmts[12] = sic_bran.uwm100.docno1
                /* VAT */
                sqm001.prmts[13] = TRIM(STRING(sic_bran.uwm100.gstrat,">>>>>9.99"))
                sqm001.prmts[14] = TRIM(STRING(sic_bran.uwm100.prem_t  ,">>>>>>>9.99-"))
                sqm001.prmts[15] = TRIM(STRING(sic_bran.uwm100.rstp_t ,">>>>>9.99-"))
                sqm001.prmts[16] = TRIM(STRING(sic_bran.uwm100.rtax_t   ,">>>>>9.99-")).
            
              END.               /* DO TRANSACTION: */
          END.

          IF nv_seq  >= 1000 THEN nv_seq  = 0.
          LEAVE loop_chk.
        
        END.                 /* loop_chk: */
    END. /* NOT Found*/
END.

RELEASE sqm001.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

