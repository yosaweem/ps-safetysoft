&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
  File: 

  Description: 
  
  DB CONNECT : sicsyac , sicuw , stat
               gw_safe -ld sic_bran  , gw_stat -ld brstat
               sic_bran -ld ctxbran  , stat -ld ctxstat    (Citrix)

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: Porntiwa T.   19/09/2016  A59-0291
           Export Data Inspection to Mobile
           
  Modify by: Jiraphon P  17/05/2018  A60-0464
           : Auto Transfer Data Gw Transfer to Premium   
  Modify by: Jiraphon P  01/08/2018  A60-0464
           : แก้ไข Loop Create Lotus Note , Send Mail และ Tranfer Vat Invoice ตาม Policy Type              
------------------------------------------------------------------------
 Modify By : Tantawan Ch. A62-0005  DATE: 15/01/2016
             - Update Invoice Branch ตาม Parameter
               ถ้าไม่มีการ set ให้ใช้ตาม Policy Branch           
------------------------------------------------------------------------*/
/* Modify By : Jiraphon P. A62-0286  Date : 17/06/2019 
             : แก้ไข Program ID (uwm100.prog)  ให้กำหนด program id 
               ตามงานที่ผ่าน On-web , Web-service , Outsource
------------------------------------------------------------------------*/
/* Modify By : Jiraphon P. A63-0439  Date 25/09/2020
             : แก้ไข Loop Release และ Send OIC เนื่องจากกรมธรรม์ช่องทาง On-web 
               ไม่ถูกส่งไป Real time OIC
------------------------------------------------------------------------*/
/* Modify By : Jiraphon P. A63-0377  Date 02/10/2020
             : เพิ่ม Release sqm001 หลังการ Create sqm001 เนื่องจากติด lock กับโปรแกรมส่งข้อมูล OIC
------------------------------------------------------------------------*/
/* Modify By : Kridtiya i. A64-0199 Date: 16/10/2021 เพิ่มการเช็คทะเบียนรถ    */
/*          This .W file was created with the Progress AppBuilder.            */
/* Modify by : Chaiyong W. A65-0185 21/07/2022
            : Add Loop Create uwm100.code1      */
/*----------------------------------------------------------------------------*/
/****************************************************************************************** 
Modify By : Songkran P. A65-0141   12/09/2022      
            : เปลี่ยนส่งข้อมูลเป็นระบบ Webservice SOAP API            
Modify by : Chaiyong W. A66-0221 06/10/2023
            : Transfer Non Motor    
Modify by : Jiraphon P. F67-0001 21/08/2024
          : กรมธรรม์ CA ไม่ต้อง transfer เข้า premium                    
******************************************************************************************/ 
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE VAR  nv_chkprog AS CHAR.   /*Add Jiraphon P. A62-0286*/

DEFINE VAR nv_poltyp   AS CHARACTER FORMAT "X(5)"  INITIAL "" NO-UNDO.

DEFINE VAR n_file      AS CHAR.
DEFINE VAR n_file1     AS CHAR.
DEFINE VAR nv_textfile AS CHAR.

DEFINE STREAM nfile.

DEFINE TEMP-TABLE ctemp NO-UNDO
  FIELD dirtext         AS CHARACTER FORMAT "X(100)"  INITIAL "".

DEFINE TEMP-TABLE cdir  NO-UNDO
  FIELD DirName         AS CHARACTER FORMAT "X(150)"  INITIAL ""
  FIELD FilNAME         AS CHARACTER FORMAT "X(50)"   INITIAL ""
  FIELD UseFileName     AS CHARACTER FORMAT "X(200)"  INITIAL "".

DEF NEW SHARED TEMP-TABLE ttext 
    FIELD tcount AS INT INIT 0
    FIELD ntext  AS CHAR INIT "".

DEFINE NEW SHARED TEMP-TABLE wBran
    FIELD Company AS CHAR FORMAT "X(10)"
    FIELD Branch  AS CHAR FORMAT "X(2)"
    FIELD path    AS CHAR FORMAT "X(50)"
    FIELD mail    AS CHAR FORMAT "X(100)"
    FIELD CCmail  AS CHAR FORMAT "X(100)"
    FIELD bDesc   AS CHAR FORMAT "X(50)".

DEFINE VARIABLE nv_searchfile  AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE nv_filename    AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE nv_savedir     AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE nv_savefile    AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE nv_opendfile   AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE nv_changedir   AS CHARACTER FORMAT "X(150)".

DEF VAR nv_pathacno2 AS CHAR.
DEF VAR ip_addr      AS CHAR INIT "".    
DEF VAR ip_cc        AS CHAR INIT "".    
DEF VAR ip_subject   AS CHAR INIT "".    
DEF VAR ip_body      AS CHAR INIT "".    
DEF VAR ip_file      AS CHAR INIT "".    
DEF VAR ip_bcc       AS CHAR INIT "".    

DEF VAR chNotesSession  AS Com-Handle.
DEF VAR mail-file       AS CHAR.  /*check id*/
DEF VAR mail-server     AS CHAR.  /*Check server*/
DEF VAR chNotesDataBase AS Com-Handle.
DEF VAR chnotesatttach  AS COM-HANDLE.  /*Attach file*/
DEF VAR chdocument      AS COM-HANDLE.
DEF VAR chItem          AS COM-HANDLE.
DEF VAR chNotesView     AS COM-HANDLE.
DEF VAR chNavView       AS  COM-HANDLE .
DEF VAR chViewEntry     AS  COM-HANDLE .

DEF VAR chassign        AS COM-HANDLE.
DEF VAR chreceive       AS COM-HANDLE.

DEF VAR file01 AS CHAR.
DEF VAR file02 AS CHAR.
DEF VAR file03 AS CHAR.
DEF VAR file04 AS CHAR.
DEF VAR file05 AS CHAR.
DEF VAR file06 AS CHAR.
DEF VAR file07 AS CHAR.
DEF VAR file08 AS CHAR.
DEF VAR file09 AS CHAR.
DEF VAR file10 AS CHAR.
DEF VAR file11 AS CHAR.
DEF VAR file12 AS CHAR.
DEF VAR file13 AS CHAR.
DEF VAR file14 AS CHAR.
DEF VAR file15 AS CHAR.
DEF VAR file16 AS CHAR.

DEF VAR n_filepig AS CHAR.

/*DEFINE BUFFER bIntClm FOR IntClmMob.*/
DEFINE VAR nv_recid01 AS RECID.
DEFINE VAR nv_update  AS LOGICAL.
DEFINE VAR nv_count   AS INTE.
DEFINE VAR nv_filenam AS CHAR.
DEFINE VAR nv_clmid   AS INTE.
DEFINE VAR n_rec1     AS INTE INIT 0.
DEFINE VAR n_rec2     AS INTE INIT 0.
DEFINE VAR n_brkcnt   AS INTE INIT 0.
DEFINE VAR n_check    AS LOGICAL.
DEFINE VAR FirstTime  AS INTE. 
DEFINE VAR i AS INTE.
DEFINE VAR N AS INTE.
DEFINE VAR C AS INTE INIT 7.
DEFINE VAR nv_meet AS CHAR.

DEFINE STREAM ns1.
DEFINE STREAM ns2.

DEFINE VAR ChkCon AS LOGICAL INIT YES.
DEFINE VAR ChkDb  AS CHAR EXTENT 6.

DEFINE WORKFILE wsqm001
   FIELD prmts  AS CHAR EXTENT 16 
   FIELD Dbnme  AS CHAR 
   FIELD Qname  AS CHAR 
   FIELD Qdate  AS DATE. 

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR.

DEF NEW SHARED VAR n_user     AS   CHAR.
DEF NEW SHARED VAR nv_recid   AS RECID . 
DEF NEW SHARED VAR nv_recid1  AS RECID . 

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
    FIELD docno1 AS CHAR FORMAT "X(10)"
    FIELD agent  AS CHAR FORMAT "X(10)"
    FIELD acno1  AS CHAR FORMAT "X(10)"
    FIELD bchyr  AS INT FORMAT "9999"
    FIELD bchno  AS CHAR FORMAT "X(13)"
    FIELD bchcnt AS INT FORMAT "99"
    FIELD releas AS LOGICAL INIT NO
    FIELD modcod AS CHAR FORMAT "X(10)"
    FIELD moddes AS CHAR FORMAT "X(30)"
    .

DEFINE VAR nv_des    AS CHAR    INIT "".
DEFINE VAR nv_csuc   AS INT     INIT 0. /*count successs*/
DEFINE VAR nv_cnsuc  AS INT     INIT 0. /*Count not success*/

DEFINE VAR nv_chk    AS   CHAR FORMAT "X".
DEFINE VAR nv_vat    AS   LOGICAL .       
DEFINE VAR nv_uwd132 AS   LOGICAL .       

DEFINE VAR nv_brnfile1   AS CHAR. 
DEFINE VAR nv_duprec1    AS CHAR.
DEFINE VAR nv_errfile1   AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.

DEFINE VAR nv_trnyes   AS LOGICAL  INIT NO  NO-UNDO.
DEFINE VAR s_recid1    AS RECID             NO-UNDO.  
DEFINE VAR gv_acm001OK AS LOG.
DEFINE VAR gv_acm002OK AS LOG.

DEFINE VAR nv_relok    AS INT.
DEFINE VAR nv_relerr   AS INT.
DEFINE VAR nv_relyet   AS LOG.

DEFINE VAR nv_chkre  AS CHAR INIT "YES". 

DEFINE VAR nv_suscess  AS INT.
DEFINE VAR nv_message1 AS CHAR FORMAT "X(200)".
DEFINE VAR nv_vaterr   AS LOG INIT NO.
DEFINE VAR nv_invtyp   AS CHAR.
DEFINE VAR nv_rprem    AS DECI.
DEFINE VAR nv_rstp     AS DECI.
DEFINE VAR nv_rtax     AS DECI.
DEFINE VAR nv_rcom     AS DECI.
DEFINE VAR nv_wprem    AS DECI.

DEFINE VAR nv_trnvat   AS LOGICAL  INIT NO  NO-UNDO.
DEFINE VAR nv_trnerr   AS LOGICAL  INIT NO  NO-UNDO.

DEFINE BUFFER bsqm001 FOR sic_bran.sqm001.
DEFINE VAR s_sqm001 AS RECID.

DEFINE VAR nv_cnt AS INTE.
DEFINE VAR nv_date AS DATE.

DEFINE WORKFILE wmail 
    FIELD compno AS CHAR
    FIELD email  AS CHAR FORMAT "X(80)".

DEFINE VAR nv_name    AS CHAR FORMAT "X(100)".
DEFINE VAR nv_premtot AS DECI FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR nv_batdt AS CHAR INIT "".

DEFINE VAR n_cnt       AS INTE. 

/*Add Jiraphon P. A60-0464*/
DEFINE TEMP-TABLE tbBranch
    FIELD tbBran AS CHAR FORMAT "x(2)"
    FIELD tbDesc AS CHAR FORMAT "x(50)".


DEFINE VAR nv_branchNotes AS CHAR INIT "".
DEFINE VAR nv_bran        AS CHAR.
DEFINE VAR nv_leave       AS CHAR.
DEFINE VAR nv_brandesc    AS CHAR.
DEFINE VAR nv_Notesfile   AS CHAR.
DEFINE VAR nv_mailBran    AS CHAR FORMAT "X(5)".
DEFINE VAR nv_sendmail    AS CHAR FORMAT "x(100)".
DEFINE VAR np_emailto     AS CHARACTER NO-UNDO.
DEFINE VAR np_emailCC     AS CHARACTER NO-UNDO.
DEFINE VAR nv_mail        AS CHAR.

DEFINE VAR nv_sendto    AS CHAR.
DEFINE VAR nv_array     AS CHAR EXTENT.

DEFINE VAR nv_sendCC    AS CHAR.
DEFINE VAR nv_arrayCC   AS CHAR EXTENT.

DEFINE VAR nv_NextID    AS CHAR INIT "".
DEF VAR nv_NewInput AS CHAR NO-UNDO. 
DEF VAR nv_err    AS CHAR NO-UNDO.


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

DEF VAR nv_st AS CHAR INIT "".
DEF VAR nv_timefr AS INT.
DEF VAR nv_timeto AS INT.
DEFINE VAR nv_today  AS DATE .
DEFINE VAR nv_tomor  AS DATE .
DEFINE VAR nv_chkdat AS LOGICAL INIT NO. 
/*end Jiraphon P. A60-0464*/

DEF VAR chk_time_fr AS CHAR.
DEF VAR chk_time_to AS CHAR.
DEF VAR chk_send    AS LOGICAL INIT NO.
DEF VAR chk_export  AS CHAR FORMAT "X(10)".
DEF VAR chk_CDay    AS CHAR FORMAT "X(10)".


DEFINE VAR nv_TOEmail AS CHAR.  /*gwctx.sqm001.prmts[6] IP Addr.*/
DEFINE VAR nv_CCEmail AS CHAR.  /*gwctx.sqm001.prmts[7] CC Addr.*/

DEFINE TEMP-TABLE tbWebmail
    FIELD WebBran AS CHAR FORMAT "x(2)"    /*Branch*/
    FIELD WebComp AS CHAR FORMAT "x(50)".  /*รหัส Company*/

DEF VAR nv_InvBrn AS CHAR .  /* A62-0005 */

/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global */
DEFINE VAR nv_server       AS CHAR.
DEFINE VAR nv_tmp          AS CHAR.

DEFINE VAR nv_vehreg AS CHAR.                             /*Add Jiraphon P. A64-0199*/
DEFINE VAR nv_digit  AS CHAR INIT "0,1,2,3,4,5,6,7,8,9".  /*Add Jiraphon P. A64-0199*/
DEFINE VAR nv_countveh    AS INTE INIT 0.                    /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
DEFINE VAR nv_statusck AS CHAR INIT "no".                 /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
DEFINE VAR nv_transfer AS CHAR INIT "".                   /*--add by Chaiyong W. A65-0185 21/07/2022*/

/*--- Add A65-0141 ---*/
DEFINE VAR n_cktrndata AS CHAR INIT "".  
DEFINE VAR nv_inspec AS INTE INIT 0.
DEFINE TEMP-TABLE tautogw
    FIELD recpol AS RECID
    FIELD company AS CHAR   
    FIELD acno   AS CHAR   
    FIELD poljob AS CHAR
    FIELD email  AS CHAR
    FIELD ispbox AS CHAR
    FIELD condi  AS CHAR.


/*--- End Add A65-0141 ---*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_typereport fistatus burun buexit fipath ~
fistatus1 fiDetail fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 RECT-319 ~
RECT-320 RECT-321 RECT-322 RECT-323 
&Scoped-Define DISPLAYED-OBJECTS ra_typereport fistatus fipath fistatus1 ~
fiDetail fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "Exit" 
     SIZE 6.5 BY 1
     FONT 6.

DEFINE BUTTON burun 
     LABEL "Run" 
     SIZE 6.5 BY 1.1
     FONT 6.

DEFINE VARIABLE fiDetail AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 65.33 BY 1
     BGCOLOR 20 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fipath AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.17 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fistatus AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fistatus1 AS CHARACTER FORMAT "X(5)":U 
      VIEW-AS TEXT 
     SIZE 16.67 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 23 NO-UNDO.

DEFINE VARIABLE fi_timefr1 AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.83 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_timefr2 AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.83 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_timeto1 AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_timeto2 AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typereport AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "No", 1,
"Yes", 2
     SIZE 15 BY 1 TOOLTIP "Send To Policy on Web Report"
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-319
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67.17 BY 1.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-320
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67 BY 4.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-321
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 1.57
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-322
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 1.57
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-323
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67 BY 1.43
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_typereport AT ROW 5.24 COL 51.5 NO-LABEL WIDGET-ID 72
     fistatus AT ROW 2.71 COL 23.83 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     burun AT ROW 3.24 COL 51.83 WIDGET-ID 6
     buexit AT ROW 3.29 COL 60 WIDGET-ID 8
     fipath AT ROW 3.95 COL 8.5 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fistatus1 AT ROW 1.29 COL 41.67 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fiDetail AT ROW 6.71 COL 2.17 NO-LABEL WIDGET-ID 18
     fi_timefr1 AT ROW 5.19 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_timefr2 AT ROW 5.19 COL 24.83 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_timeto1 AT ROW 5.19 COL 37.33 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_timeto2 AT ROW 5.19 COL 42.5 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     "RUN QUEUE STATUS :" VIEW-AS TEXT
          SIZE 22.5 BY 1 AT ROW 2.71 COL 2.5 WIDGET-ID 10
          BGCOLOR 8 FONT 6
     " [ MOTOR ]" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 2.71 COL 36.17 WIDGET-ID 14
          BGCOLOR 8 FGCOLOR 4 FONT 6
     ":" VIEW-AS TEXT
          SIZE 1 BY 1 AT ROW 5.14 COL 25.83 WIDGET-ID 64
          BGCOLOR 8 FONT 6
     ":" VIEW-AS TEXT
          SIZE 1 BY 1 AT ROW 5.14 COL 43.33 WIDGET-ID 70
          BGCOLOR 8 FONT 6
     " Queue Auto Transfer GW to Premium:" VIEW-AS TEXT
          SIZE 41.5 BY 1 AT ROW 1.24 COL 2 WIDGET-ID 2
          BGCOLOR 3 FGCOLOR 7 FONT 13
     "PATH :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 3.91 COL 2.67 WIDGET-ID 38
          BGCOLOR 8 FONT 6
     "TIME SEND MAIL:" VIEW-AS TEXT
          SIZE 18.33 BY 1 AT ROW 5.24 COL 2.67 WIDGET-ID 40
          BGCOLOR 8 FONT 6
     "TO" VIEW-AS TEXT
          SIZE 4.33 BY 1 AT ROW 5.19 COL 33.33 WIDGET-ID 42
          BGCOLOR 8 FONT 6
     RECT-319 AT ROW 1.1 COL 1.33 WIDGET-ID 4
     RECT-320 AT ROW 2.43 COL 1.5 WIDGET-ID 16
     RECT-321 AT ROW 3 COL 59.17 WIDGET-ID 20
     RECT-322 AT ROW 3 COL 51 WIDGET-ID 22
     RECT-323 AT ROW 6.48 COL 1.5 WIDGET-ID 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 67.67 BY 7.1 WIDGET-ID 100.


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
         TITLE              = "WGWGEQ70 - Auto Transfer GW to Premium"
         HEIGHT             = 7.1
         WIDTH              = 68
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fiDetail IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fistatus:HIDDEN IN FRAME fr_main           = TRUE.

ASSIGN 
       fi_timefr1:HIDDEN IN FRAME fr_main           = TRUE.

ASSIGN 
       fi_timefr2:HIDDEN IN FRAME fr_main           = TRUE.

ASSIGN 
       fi_timeto1:HIDDEN IN FRAME fr_main           = TRUE.

ASSIGN 
       fi_timeto2:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWGEQ70 - Auto Transfer GW to Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWGEQ70 - Auto Transfer GW to Premium */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME burun
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL burun C-Win
ON CHOOSE OF burun IN FRAME fr_main /* Run */
DO:
  
  IF fistatus = "" THEN DO:
      MESSAGE "Field stat is mandatory" VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fistatus IN FRAME fr_main.
      RETURN NO-APPLY.
  END.
  ELSE DO:

    nv_timefr = ((fi_timefr1 * 60) + fi_timefr2) * 60 .
    nv_timeto = ((fi_timeto1 * 60) + fi_timeto2) * 60 .
    
    /*-- Add Jiraphon P. A60-0464 --*/
    chk_time_fr = STRING(fi_timefr1,"99") + ":" + STRING(fi_timefr2,"99") + ":00".
    chk_time_to = STRING(fi_timeto1,"99") + ":" + STRING(fi_timeto2,"99") + ":00".
    chk_send    = NO.
    /*-- End Jiraphon P. A60-0464 --*/

    RUN PD_xmm023.      /*Find Branch Premium*/      /* Add Jiraphon P. A60-0464 */
    RUN PDlishbranch.   /*find Branch Lotus Notes*/  /* Add Jiraphon P. A60-0464 */

    Loop_cnktime:
    REPEAT:
        nv_leave = "".
        IF chk_send = NO THEN DO: 

            chk_CDay = STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999").

            RUN PDTransData. /*Process Transfer*/ 
        END.
       
        fiDetail = STRING(TIME) + " Check Data Transfer,Please Wait..Time: " + STRING(TIME,"HH:MM:SS").
        DISPLAY fiDetail WITH FRAME fr_main.
        PAUSE 2 NO-MESSAGE.

        IF LASTKEY = KEYCODE("F4") OR nv_leave = "F4"  THEN DO: 
            ENABLE burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
            DISP burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
            LEAVE Loop_cnktime.
        END.

        IF chk_send = YES THEN DO:
            IF ra_typereport = 2 THEN DO:
                fiDetail = STRING(TIME) + " Please Wait..Export File..Time: " + STRING(TIME,"HH:MM:SS").
                DISP fiDetail WITH FRAME fr_main.
        
                /*RUN PDCutText.   /*ทำรายงาน*/  Comment Jiraphon P. A60-0464*/
                Run PDCutTextMK.   /*ทำรายงานสาขา Add Jiraphon P. A60-0464*/
                RUN PDCutTextVat.  /*ทำรายงาน Vat Add Jiraphon P. A60-0464*/
                PAUSE 2 NO-MESSAGE.
        
                fiDetail = STRING(TIME) + " Please wait..Send To Policy on Web Report Tranfer...Time: " + STRING(TIME,"HH:MM:SS").
                DISP fiDetail WITH FRAME fr_main.
                
                RUN PDPolOnWeb_Main.    /*Add เข้ากล่อง Policy on-web*/
                PAUSE 2 NO-MESSAGE.
            END.
        END.

        RUN PDPauseTime.
        
        chk_send = NO.  /*เปลี่ยน Status เข้า Transfer Data ก่อน*/
        nv_chkdat = NO. /*เปลี่ยน status กลับหลังจาก create ลง กล่อง */
        
      /*--Jiraphon P.
        fiDetail = STRING(TIME) + " Please wait..Process Send Mail...Time: " + STRING(TIME,"HH:MM:SS").
        DISP fiDetail WITH FRAME fr_main.

        PAUSE 2 NO-MESSAGE.    
        RUN pdsendmail_Main.    /*ส่งเมล*/        
      --*/  

    END.
    IF LASTKEY = KEYCODE("F4") OR nv_leave = "F4"  THEN DO: 
       ENABLE burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
       DISP burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
       //APPLY  "CLOSE"  TO THIS-PROCEDURE.

       //RETURN NO-APPLY.
    END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fipath
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fipath C-Win
ON LEAVE OF fipath IN FRAME fr_main
DO:
  fipath = INPUT fipath.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fipath C-Win
ON RETURN OF fipath IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fistatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fistatus C-Win
ON LEAVE OF fistatus IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  fistatus1 = fistatus. 
  DISP fistatus fistatus1 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fistatus C-Win
ON RETURN OF fistatus IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fistatus1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fistatus1 C-Win
ON LEAVE OF fistatus1 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fistatus1 C-Win
ON RETURN OF fistatus1 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_timefr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timefr1 C-Win
ON LEAVE OF fi_timefr1 IN FRAME fr_main
DO:
  fi_timefr1 = INPUT fi_timefr1.
  DISP fi_timefr1 WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timefr1 C-Win
ON RETURN OF fi_timefr1 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_timefr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timefr2 C-Win
ON LEAVE OF fi_timefr2 IN FRAME fr_main
DO:
  fi_timefr2 = INPUT fi_timefr2.
  DISP fi_timefr2 WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timefr2 C-Win
ON RETURN OF fi_timefr2 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_timeto1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timeto1 C-Win
ON LEAVE OF fi_timeto1 IN FRAME fr_main
DO:
  fi_timeto1 = INPUT fi_timeto1.
  DISP fi_timeto1 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timeto1 C-Win
ON RETURN OF fi_timeto1 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_timeto2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timeto2 C-Win
ON LEAVE OF fi_timeto2 IN FRAME fr_main
DO:
  fi_timeto2 = INPUT fi_timeto2.
  DISP fi_timeto2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_timeto2 C-Win
ON RETURN OF fi_timeto2 IN FRAME fr_main
DO:
  fistatus = CAPS(INPUT fistatus).
  DISP fistatus WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typereport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typereport C-Win
ON VALUE-CHANGED OF ra_typereport IN FRAME fr_main
DO:
    ra_typereport = INPUT ra_typereport.
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

CLEAR  ALL     NO-PAUSE.
STATUS INPUT   OFF.
HIDE   MESSAGE NO-PAUSE.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  /********************  T I T L E   F O R  C - W I N  ****************/
  RUN  WUT\WUTWICEN (C-WIN:handle).  
  /*********************************************************************/
  
  RUN enable_UI.

  SESSION:DATA-ENTRY-RETURN = YES.

  fiStatus  = "MOTOR".
  fipath    = "D:\WebQue". 
  fi_timefr1 = 23.
  fi_timefr2 = 30.
  fi_timeto1 = 23.
  fi_timeto2 = 59.

  /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global */
  /*---จริง --*/
  nv_server = "Safety_NotesServer/Safety".        
  nv_tmp    = "Safety\uw\PolicyonWebReport.nsf".  

OUTPUT TO D:\AutoQ\NoteServer-Log.txt .
PUT TODAY FORMAT "99/99/9999" " TIME : " STRING(TIME,"HH:MM:SS") SKIP(1).
OUTPUT CLOSE.

  /*======= TEST =======
  nv_server = "".        
  nv_tmp    = "V:\Lotus\Safety\uw\PolicyonWebReport.nsf". 
  ---*/
  
  n_user   = USERID(LDBNAME(1)).
  DISPLAY fiStatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.

 
  APPLY "ENTRY" TO fistatus IN FRAME fr_main.

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
  DISPLAY ra_typereport fistatus fipath fistatus1 fiDetail fi_timefr1 fi_timefr2 
          fi_timeto1 fi_timeto2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_typereport fistatus burun buexit fipath fistatus1 fiDetail 
         fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 RECT-319 RECT-320 RECT-321 
         RECT-322 RECT-323 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckns1 C-Win 
PROCEDURE PDCheckns1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO "D:\AutoQ\LOG_AutoTransfer.txt" APPEND.
    PUT sic_bran.sqm001.prmts[1] FORMAT "X(30)" sic_bran.sqm001.Jobq# STRING(TODAY) FORMAT "X(10)" STRING(TIME,"HH:MM:SS") FORMAT "X(10)" SKIP.
OUTPUT CLOSE.
nv_vehreg = "". /*Add Jiraphon P. A64-0199*/
FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE
           sicuw.uwm100.policy = sic_bran.uwm100.policy NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:
    putchr1    = "พบข้อมูลกรมธรรม์ในระบบ Premium แล้ว" .
    putchr     = textchr  + "  " + TRIM(putchr1).
    nv_message = putchr1.
    nv_error = YES.
END.
ELSE DO:
    FIND LAST wk_uwm100 WHERE RECID(wk_uwm100) = nv_RecUwm100 NO-LOCK NO-ERROR.
    IF NOT AVAIL wk_uwm100 THEN DO:
        putchr1    = "Not Found Record on sic_bran.uwm100" .
        putchr     = textchr  + "  " + TRIM(putchr1).
        nv_message = putchr1.
        nv_error   = YES.
    END.
    ELSE DO:
        IF wk_uwm100.poltyp = "" THEN DO:
            putchr1    = "ไม่มีค่า Policy Type".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.branch = "" THEN DO:
            putchr1    = "ไม่มีค่า Branch".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.comdat = ? THEN DO:
            putchr1    = "ไม่มีค่า Comdate".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.expdat = ? THEN DO:
            putchr1    = "ไม่มีค่า Expiry Date".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.expdat < TODAY THEN DO:
            putchr1    = "Expiry Date ก่อนวันที่นำเข้า".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.expdat < wk_uwm100.comdat THEN DO:   /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
            ASSIGN
                putchr1    = "วันที่Expiry Date น้อยกว่าวันที่ Com Date"
                putchr     = textchr + "  " + TRIM(putchr1) 
                nv_message = putchr1 
                nv_error   = YES .
        END.                                             /*Add Kridtiya i. A64/0199 Date. 16/10/2021*/
        IF wk_uwm100.name1 = "" THEN DO:
            putchr1    = "ไม่มีค่า Name Of Insured".
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.prem_t = 0 THEN DO:
            putchr1    = "ไม่มีค่า Premium".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.tranty = "" THEN DO:
            putchr1    = "ไม่สามารถระบุประเภทงานได้".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.policy = "" THEN DO:
            putchr1    = "Policy No. is blank".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF LENGTH(wk_uwm100.policy) < 12 THEN DO:
            putchr1    = "Policy No. น้อยกว่า 12 หลัก".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.EndCnt <> 0 THEN DO:
            putchr1    = "Endorsement Count error".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.agent = "" OR wk_uwm100.acno1 = "" THEN DO:
            putchr1    = "Producer, Agent are blank".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF wk_uwm100.insref = "" THEN DO:
            putchr1    = "Insured Code is blank".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        IF TRIM(wk_uwm100.Addr1) + TRIM(wk_uwm100.Addr2) +
           TRIM(wk_uwm100.Addr3) + TRIM(wk_uwm100.Addr4) = "" THEN DO:
            putchr1    = "Address is blank".
            putchr     = textchr + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
        
        IF sic_bran.uwm100.trndat > TODAY THEN DO:
            putchr1    = "Transaction Date Over System Date".
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.

        FIND LAST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                  sic_bran.uwm120.policy = wk_uwm100.policy AND
                  sic_bran.uwm120.rencnt = wk_uwm100.rencnt AND
                  sic_bran.uwm120.endcnt = wk_uwm100.endcnt AND
                  sic_bran.uwm120.riskgp = 0                AND
                  sic_bran.uwm120.riskno = 1                AND
                  sic_bran.uwm120.bchyr  = nv_batchyr       AND
                  sic_bran.uwm120.bchno  = nv_batchno       AND
                  sic_bran.uwm120.bchcnt = nv_batcnt        NO-LOCK NO-ERROR.
        IF NOT AVAIL sic_bran.uwm120 THEN DO:
            putchr1    = "Not Found Record on sic_bran.uwm120".
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.

        FIND LAST sic_bran.uwm130 USE-INDEX uwm13001
            WHERE sic_bran.uwm130.policy = wk_uwm100.policy
              AND sic_bran.uwm130.rencnt = wk_uwm100.rencnt
              AND sic_bran.uwm130.endcnt = wk_uwm100.endcnt
              AND sic_bran.uwm130.riskgp = 0
              AND sic_bran.uwm130.riskno = 1
              AND sic_bran.uwm130.itemno = 1
              AND sic_bran.uwm130.bchyr  = nv_batchyr 
              AND sic_bran.uwm130.bchno  = nv_batchno 
              AND sic_bran.uwm130.bchcnt = nv_batcnt NO-LOCK NO-ERROR.
        IF NOT AVAIL sic_bran.uwm130 THEN DO:
            putchr1    = "Not Found Record on sic_bran.uwm130" .
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
         /*---Begin by Chaiyong W. A66-0221 06/10/2023*/
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm031 THEN DO:
            IF sicsyac.xmm031.dept = "G" OR sicsyac.xmm031.dept = "M"  THEN DO:
         /*End by Chaiyong W. A66-0221 06/10/2023---*/

            FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
                WHERE sic_bran.uwm301.policy  = wk_uwm100.policy
                  AND sic_bran.uwm301.rencnt  = wk_uwm100.rencnt
                  AND sic_bran.uwm301.endcnt  = wk_uwm100.endcnt
                  AND sic_bran.uwm301.riskgp  = 0
                  AND sic_bran.uwm301.riskno  = 1
                  AND sic_bran.uwm301.itemno  = 1
                  AND sic_bran.uwm301.bchno   = nv_batchno
                  AND sic_bran.uwm301.bchcnt  = nv_batcnt
                  AND sic_bran.uwm301.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
            IF NOT AVAIL sic_bran.uwm301 THEN DO:
                putchr1    = "Not Found Record on sic_bran.uwm301" .
                putchr     = textchr  + "  " + TRIM(putchr1).
                nv_message = putchr1.
                nv_error   = YES.
            END.
            ELSE DO:
                IF LENGTH(sic_bran.uwm301.vehreg) > 11 THEN DO:
                    putchr1    = "Warning : Vehicle Register More Than 11 Characters".    
                    putchr     = textchr  + "  " + TRIM(putchr1).
                    nv_message = putchr1.
                    nv_error   = YES.
                END.
                IF sic_bran.uwm301.vehreg = "" THEN DO:
                    putchr1    = "Vehicle Register is mandatory field.".
                    putchr     = textchr  + "  " + TRIM(putchr1).
                    nv_message = putchr1.
                    nv_error   = YES.
                END.
                IF sic_bran.uwm301.modcod = "" THEN DO:
                    putchr1    = "Redbook Code เป็นค่าว่าง ".
                    putchr     = textchr  + "  " + TRIM(putchr1).
                    nv_message = putchr1.
                    nv_error   = YES.
                END.
                /*Add Jiraphon P. A64-0199*/
                IF sic_bran.uwm301.vehreg <> "" THEN DO:
                    nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                    IF substring(nv_vehreg,1,1) = "/" OR substring(nv_vehreg,1,1) = "\" THEN DO:
                    END.
                    ELSE IF LENGTH(nv_vehreg) > 3 THEN DO:
                        nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 1)).  /*2 Position*/
                        IF  SUBSTR(nv_vehreg,1,1) >= "ก" AND  SUBSTR(nv_vehreg,1,1) <= "ฮ" AND
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
                                    nv_message = putchr1.
                                    nv_error   = YES.
                                END.
                            END.
                            ELSE DO:
                                putchr1    = "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg.
                                putchr     = textchr  + "  " + TRIM(putchr1).
                                nv_message = putchr1.
                                nv_error   = YES.
                            END.
                        END.
                    END.   /*substring(nv_vehreg,1,1) = "/"*/ 
                END.      /*sic_bran.uwm301.vehreg <> ""  */
                /*End Add Jiraphon P. A64-0199*/
            END.
       /*---Begin by Chaiyong W. A66-0221 06/10/2023*/
             END.
        END.
        /*End by Chaiyong W. A66-0221 06/10/2023---*/
        
        FIND LAST sic_bran.uwd132 USE-INDEX uwd13201
            WHERE sic_bran.uwd132.policy  = wk_uwm100.policy
              AND sic_bran.uwd132.rencnt  = wk_uwm100.rencnt
              AND sic_bran.uwd132.endcnt  = wk_uwm100.endcnt
              AND sic_bran.uwd132.riskgp  = 0
              AND sic_bran.uwd132.riskno  = 1
              AND sic_bran.uwd132.itemno  = 1
              AND sic_bran.uwd132.bchno   = nv_batchno
              AND sic_bran.uwd132.bchcnt  = nv_batcnt
              AND sic_bran.uwd132.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
        IF NOT AVAIL sic_bran.uwd132 THEN DO:
            putchr1    = "Not Found Record on sic_bran.uwd132" .
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.

    END. /*not avail wk_uwm100*/

    /* RUN PDChkAccount. comment Songkran p. 13/09/2022 --*/

    IF sic_bran.uwm100.docno1 <> "0000000" AND sic_bran.uwm100.docno1 <> "" THEN DO:
        FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
                   sicuw.uwm100.trty11 = sic_bran.uwm100.trty11 AND
                   sicuw.uwm100.docno1 = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            putchr1    = "Document No. ซ้ำกับ Policy : " + sicuw.uwm100.policy.
            putchr     = textchr  + "  " + TRIM(putchr1).
            nv_message = putchr1.
            nv_error   = YES.
        END.
    END.
    
    /*-- Check Vat --*/
    nv_trnvat = YES.

    
    IF SUBSTR(nv_policy,1,1) <> "R" AND 
       SUBSTR(nv_policy,1,1) <> "Q" THEN DO:

        RUN PDChkAccount. /*-- A65-0141 Songkran p. 13/09/2022 --*/

        IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
            nv_invtyp = TRIM(sic_bran.uwm100.trty13).
        END.
        ELSE nv_invtyp = "T".
        
        FIND FIRST stat.vat100 USE-INDEX vat10001 WHERE
                   stat.vat100.invtyp  = nv_invtyp AND
                   stat.vat100.invoice = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
        IF AVAIL stat.vat100 THEN DO:
            IF stat.vat100.policy   = sic_bran.uwm100.policy  AND
               stat.vat100.rencnt   = sic_bran.uwm100.rencnt  AND
               stat.vat100.endcnt   = sic_bran.uwm100.endcnt  /*AND
              (stat.vat100.program  = "wgwgen08"              OR 
               stat.vat100.program  = "wgwgen01.p")           */ THEN DO:  /* Comment Jiraphon P. A62-0286*/
                IF stat.vat100.cancel <> YES THEN DO:
                    ASSIGN
                        nv_error  = YES
                        nv_trnvat = NO
                        putchr1   = sic_bran.uwm100.policy + " พบข้อมูล Vat No.: " + 
                                    stat.vat100.invtyp + " " + stat.vat100.invoice
                        putchr     = textchr + "  " + TRIM(putchr1)
                        nv_message = putchr1.
                END.
            END.
            ELSE DO:
                ASSIGN
                    nv_error   = YES
                    nv_trnvat  = NO
                    putchr1    = sic_bran.uwm100.policy + " Vat No. ซ้ำกับ Policy :" + stat.vat100.policy
                    putchr     = textchr + "  " + TRIM(putchr1)
                    nv_message = putchr1.
            END.
        END.
        ELSE DO:
            FIND FIRST stat.vat100 USE-INDEX vat10009 WHERE
                       stat.vat100.poltyp = nv_poltyp AND
                       stat.vat100.policy = nv_policy AND
                       stat.vat100.rencnt = nv_rencnt AND
                       stat.vat100.endcnt = nv_endcnt NO-LOCK NO-ERROR.
            IF AVAIL stat.vat100 THEN DO:
                IF stat.vat100.invtyp <> "S" AND stat.vat100.invtyp <> "T" THEN DO:
                    loop_vat100:
                    REPEAT:
                        FIND NEXT stat.vat100 USE-INDEX vat10009 WHERE
                                  stat.vat100.poltyp = nv_poltyp AND
                                  stat.vat100.policy = nv_policy AND
                                  stat.vat100.rencnt = nv_rencnt AND
                                  stat.vat100.endcnt = nv_endcnt NO-LOCK NO-ERROR.
                        IF AVAIL stat.vat100 THEN DO:
                            IF stat.vat100.invtyp = "S" OR 
                               stat.vat100.invtyp = "T" THEN DO:
                                IF stat.vat100.cancel <> YES THEN DO:
                                    ASSIGN
                                        nv_error   = YES
                                        nv_trnvat  = NO
                                        putchr1    = sic_bran.uwm100.policy + " พบข้อมูล Vat No.: " + 
                                                     stat.vat100.invtyp + " " + stat.vat100.invoice
                                        putchr     = textchr + "  " + TRIM(putchr1)
                                        nv_message = putchr1.
                                END.
                                LEAVE loop_vat100.
                            END.
                        END.
                        ELSE LEAVE loop_vat100.
                    END. /*loop_vat100*/
                END.
                ELSE DO:
                    IF stat.vat100.cancel <> YES THEN DO:
                        ASSIGN
                            nv_error   = YES
                            nv_trnvat  = NO
                            putchr1    = sic_bran.uwm100.policy + " พบข้อมูล Vat No.: " + 
                                         stat.vat100.invtyp + " " + stat.vat100.invoice
                            putchr     = textchr + "  " + TRIM(putchr1)
                            nv_message = putchr1.
                    END.
                END.
            END.
        END.
    
        /*-- Check Vat102 --*/
        FIND FIRST stat.vat102 USE-INDEX vat10211 WHERE
                   stat.vat102.trnty1 = sic_bran.uwm100.trty11 AND
                   stat.vat102.refno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.vat102 THEN DO:
            IF stat.vat102.cancel = NO THEN DO:
                ASSIGN
                    nv_error   = YES
                    nv_trnvat  = NO
                    putchr1    = sic_bran.uwm100.policy + " มีการพิมพ์ใบกำกับภาษีแล้ว (VAT102) " + 
                                 stat.vat102.invtyp + " " + stat.vat102.invoice
                    putchr     = textchr + "  " + TRIM(putchr1)
                    nv_message = putchr1.
            END.
        END.
        FIND LAST stat.vat102 USE-INDEX vat10211 WHERE
                  stat.vat102.trnty1 = sic_bran.uwm100.trty11 AND
                  stat.vat102.refno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.vat102 THEN DO:
            IF stat.vat102.cancel = NO THEN DO:
                ASSIGN
                    nv_error   = YES
                    nv_trnvat  = NO
                    putchr1    = sic_bran.uwm100.policy + " มีการพิมพ์ใบกำกับภาษีแล้ว (VAT102) " + 
                                 stat.vat102.invtyp + " " + stat.vat102.invoice
                    putchr     = textchr + "  " + TRIM(putchr1)
                    nv_message = putchr1.
            END.
        END.
    END.
END. /*not avail sicuw.uwm100*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkAccount C-Win 
PROCEDURE PDChkAccount :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    nv_trnyes = YES
    putchr    = ""
    putchr1   = ""
    textchr   = STRING(TRIM(nv_policy),"x(16)") + " " +
                STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").
FIND FIRST sicsyac.acm001 USE-INDEX acm00101 WHERE
           sicsyac.acm001.trnty1 = sic_bran.uwm100.trty11 AND
           sicsyac.acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
IF AVAIL sicsyac.acm001 THEN DO:
    ASSIGN
        putchr1    = "Document No. already on Account Master file acm001"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

FIND FIRST sicsyac.acm002 USE-INDEX acm00201 WHERE
           sicsyac.acm002.trnty1 = sic_bran.uwm100.trty11 AND
           sicsyac.acm002.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
IF AVAIL acm002 THEN DO:
    ASSIGN
        putchr1    = "Document No. already on Account Master file acm002" + acm002.policy
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.prem_t <> 0 THEN DO:
    IF (sic_bran.uwm100.docno1 = "0000000000"  OR
        sic_bran.uwm100.docno1 = "0000000"     OR
        sic_bran.uwm100.docno1 = "0"           OR
        sic_bran.uwm100.docno1 = "" )          THEN DO:
        ASSIGN
            putchr1    = "Dr/Cr not print"
            putchr     = textchr  + "  " + TRIM(putchr1)
            nv_message = putchr1
            nv_error   = YES
            nv_trnyes  = No.
    END.
END.
IF sic_bran.uwm100.docno1 = "" THEN DO:
    ASSIGN
        putchr1    = "Document No. เป็นค่าว่าง Dr/Cr not print"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.
IF LENGTH(sic_bran.uwm100.docno1) <> 7 AND LENGTH(sic_bran.uwm100.docno1) <> 10 THEN DO:
    ASSIGN
        putchr1    = "Document No. ไม่ครบ 7 หลัก หรือ 10 หลัก Dr/Cr not print"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

ASSIGN
    nv_rprem = 0
    nv_rstp  = 0
    nv_rtax  = 0
    nv_rcom  = 0.

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
        putchr1    = "Premium Policy (uwm100) not equal Risk (sic_bran.uwm120) "
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.rstp_t <> nv_rstp THEN DO:
    ASSIGN
        putchr1    = "Stamp  Policy (uwm100) not equal Risk (sic_bran.uwm120)"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.rtax_t <> nv_rtax THEN DO:
    ASSIGN
        putchr1    = "Tax Policy (uwm100) not equal Risk (sic_bran.uwm120)"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF (sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t) <> nv_rcom THEN DO:
    ASSIGN
        putchr1    = "Commission Policy (uwm100) not equal Risk (sic_bran.uwm120)"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

nv_wprem  = 0.
FOR EACH sic_bran.uwd132 WHERE
         sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
         sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt NO-LOCK:
    nv_wprem  = nv_wprem  + sic_bran.uwd132.prem_c.
END.

IF sic_bran.uwm100.prem_t <> nv_wprem THEN DO:
    ASSIGN
        putchr1    = "Premium Policy (sic_bran.uwm100) not equal Insured Item (sic_bran.uwd132)"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.sch_p = NO OR sic_bran.uwm100.drn_p = NO THEN DO:
    ASSIGN
        putchr1    = "Policy or Debit Note is not print , Can't transfer to Account"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.prem_t <> 0 OR sic_bran.uwm100.com1_t <> 0 OR sic_bran.uwm100.com2_t <> 0 OR
   sic_bran.uwm100.pstp   <> 0 OR sic_bran.uwm100.pfee   <> 0 OR sic_bran.uwm100.ptax   <> 0 OR
   sic_bran.uwm100.rstp_t <> 0 OR sic_bran.uwm100.rfee_t <> 0 OR sic_bran.uwm100.rtax_t <> 0 THEN DO:
    
    IF LENGTH(sic_bran.uwm100.docno1) = 0  THEN DO:
        ASSIGN
            putchr1    = "ไมมีเลขที่ใบแจ้งหนี้หรือใบลดหนี้"
            putchr     = textchr  + "  " + TRIM(putchr1)
            nv_message = putchr1
            nv_error   = YES
            nv_trnyes  = No.
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
            putchr1    = "ไม่พบข้อมูล หน้าเบี้ย(uwd132) ติดต่อ Computer"
            putchr     = textchr  + "  " + TRIM(putchr1)
            nv_message = putchr1
            nv_error   = YES
            nv_trnyes  = No.
    END.
END.
/*--
/*-- Check Sticker No. --*/
IF (sic_bran.uwm100.poltyp = "V70"  OR
    sic_bran.uwm100.poltyp = "V72"  OR
    sic_bran.uwm100.poltyp = "V73"  OR
    sic_bran.uwm100.poltyp = "V74") THEN DO:
comment by Chaiyong W. A66-0221 06/10/2023*/
    FIND FIRST sic_bran.uwm130  WHERE
               sic_bran.uwm130.policy  = sic_bran.uwm100.policy  AND
               sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
               sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sic_bran.uwm130 THEN DO:
        ASSIGN
            putchr1    = "ไม่พบข้อมูล รายการคุ้มครอง(sic_bran.uwm130) ติดต่อ Computer"
            putchr     = textchr  + "  " + TRIM(putchr1)
            nv_message = putchr1
            nv_error   = YES
            nv_trnyes  = No.

    END.

//END. comment by Chaiyong W. A66-0221 06/10/2023*/
FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.
IF NOT AVAIL xmm600 THEN DO:
    ASSIGN
        putchr1    = "Not found Agent,Producer Can not Release to Account"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.
ELSE DO:
    FIND sicsyac.xmm022 USE-INDEX xmm02201 WHERE 
         sicsyac.xmm022.acccod = sicsyac.xmm600.acccod NO-LOCK NO-WAIT NO-ERROR.
    IF NOT AVAIL sicsyac.xmm022 THEN DO:
        FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
        IF xmm090.glref <> "0" THEN DO:
            ASSIGN
                putchr1    = "Policy Release cannot find GL Debtor Control A/C No. xmm022"
                putchr     = textchr  + "  " + TRIM(putchr1)
                nv_message = putchr1
                nv_error   = YES
                nv_trnyes  = No.
        END.
    END.

    FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm090 THEN DO:
        IF xmm090.glref <> "0" THEN DO:
            ASSIGN
                putchr1    = "Policy Release cannot find GL A/C Nos. on xmm202"
                putchr     = textchr  + "  " + TRIM(putchr1)
                nv_message = putchr1
                nv_error   = YES
                nv_trnyes  = No.
        END.
    END.

    /*--
    IF sicsyac.xmm600.acccod <> "AG" AND     /* direc */
       sicsyac.xmm600.acccod <> "BR" AND 
       sicsyac.xmm600.acccod <> "RD" AND     /* inward */
       sicsyac.xmm600.acccod <> "RF" AND 
       sicsyac.xmm600.acccod <> "RB" THEN DO:
        ASSIGN
            putchr1    = "Not AGENT/BROKER TYPE, Can't Release to Account"
            putchr     = textchr  + "  " + TRIM(putchr1)
            nv_message = putchr1
            nv_error   = YES
            nv_trnyes  = No.
    END. comment by Chaiyong W. A65-0185 24/08/2022*/
END.

IF sic_bran.uwm100.agent  = "" OR sic_bran.uwm100.agent = "." OR
   sic_bran.uwm100.acno1  = "" OR sic_bran.uwm100.acno1 = "." THEN DO:
    ASSIGN
        putchr1    = "Code Agent,Producer is Blank or point Can not Releas to Account"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

IF sic_bran.uwm100.acno1  = "B300100" OR
   sic_bran.uwm100.acno1  = "B3V0100" OR
   sic_bran.uwm100.acno1  = "B3K0100" OR
   sic_bran.uwm100.acno1  = "B3C0100" OR
   sic_bran.uwm100.acno1  = "B3V2100" THEN DO:

    ASSIGN
        putchr1    = "Code Producer is Sriprathom , Can not Releas to Account"
        putchr     = textchr  + "  " + TRIM(putchr1)
        nv_message = putchr1
        nv_error   = YES
        nv_trnyes  = No.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCutTextMK C-Win 
PROCEDURE PDCutTextMK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_docno    AS CHAR FORMAT "X(10)".
DEFINE VAR nv_NziBr     AS CHAR FORMAT "x(50)".
DEFINE VAR nv_invdat    AS CHAR FORMAT "x(10)".
DEFINE VAR nv_trndat    AS CHAR FORMAT "X(10)".
DEFINE VAR nv_chkfile   AS CHAR INIT "".     /*Jiraphon P. A60-0464*/
  
  
    FOR EACH wbran 
        BREAK BY wbran.path:
        
        n_file = wBran.Path.                                        
                                                                    
        IF FIRST-OF(wbran.path) THEN DO:

            OUTPUT STREAM ns1 TO VALUE(n_file) APPEND. 
               PUT STREAM ns1 "ACCOUNT NO. |" .
               PUT STREAM ns1 "ACCOUNT NAME |" .
               PUT STREAM ns1 "POLICY NO.  |" .
               PUT STREAM ns1 "POLICY TYPE |" . /*---add by Chaiyong W. A66-0221 06/10/2023*/
               PUT STREAM ns1 "NAME        |" .
               PUT STREAM ns1 "Com.DATE    |" .
               PUT STREAM ns1 "EXP.DATE    |" .
               PUT STREAM ns1 "PREMIUM     |" .
               PUT STREAM ns1 "STAMP       |" .
               PUT STREAM ns1 "TAX         |" .
               PUT STREAM ns1 "PREMIUM TOTAL    |" .
               PUT STREAM ns1 "COMMISSION  |" .   
               PUT STREAM ns1 "DOCUMENT NO.|" .         
               PUT STREAM ns1 "STATUS JOB  |" .
               PUT STREAM ns1 "REMARK       " SKIP.
            OUTPUT STREAM ns1 CLOSE.
        END.
    END.

    FOR EACH sic_bran.sqm001 USE-INDEX sqm00101 WHERE
             sic_bran.sqm001.Jobq# = "FAIL"     OR
             sic_bran.sqm001.Jobq# = "SUCCESS" 
        BREAK BY sic_bran.sqm001.prmts[1] :
        
        IF sic_bran.sqm001.Jobq# = "FAIL"  THEN ASSIGN sic_bran.sqm001.Jobq# = "NOT".
        ELSE IF sic_bran.sqm001.Jobq# = "SUCCESS"  THEN ASSIGN sic_bran.sqm001.Jobq# = "COMPLETE".

        fiDetail = "Please Wait..Process Text: " + sic_bran.sqm001.prmts[1].
        DISP fiDetail WITH FRAME fr_main.

        FIND FIRST sic_bran.uwm100 USE-INDEX uwm10001 WHERE
                   sic_bran.uwm100.policy = sic_bran.sqm001.prmts[1]        AND
                   sic_bran.uwm100.rencnt = INTE(sic_bran.sqm001.prmts[2])  AND
                   sic_bran.uwm100.endcnt = INTE(sic_bran.sqm001.prmts[3])  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm100 THEN DO:
            /*Add Jiraphon P. A60-0464*/
            FIND FIRST tbWebmail WHERE tbWebmail.WebBran = sic_bran.uwm100.branch    and
                                       tbWebmail.Webcomp = trim(sic_bran.sqm001.prmts[4])  NO-ERROR.
            IF NOT AVAIL tbWebmail THEN DO:
                CREATE tbWebmail.
                ASSIGN
                    tbWebmail.WebBran = sic_bran.uwm100.branch
                    tbWebmail.WebComp = trim(sic_bran.sqm001.prmts[4]).
            END.
            /*End Add Jiraphon P. A60-0464*/
            
            FIND FIRST wBran WHERE wBran.Branch = sic_bran.uwm100.branch NO-LOCK NO-ERROR.
            IF AVAIL wBran THEN DO:
                n_file = wBran.Path.
            END.
            ELSE DO: 
                IF sic_bran.uwm100.branch >= "91" AND sic_bran.uwm100.branch <= "98" THEN DO:
                    n_file = TRIM(fipath) + "\MK" + "91-98" + STRING(TODAY,"99999999") + ".csv".
                END.
                ELSE DO:
                    n_file = TRIM(fipath) + "\MK" + sic_bran.uwm100.branch + STRING(TODAY,"99999999") + ".csv".
                END.
                IF n_file <> SEARCH(n_file) THEN DO:     

                    CREATE wBran.
                    ASSIGN
                        wBran.Branch = sic_bran.uwm100.branch
                        wBran.Path   = n_file.
                        /*wBran.mail   = sic_bran.sqm001.prmts[6].*/
    
                    OUTPUT STREAM ns1 TO VALUE(n_file) APPEND. 
                       PUT STREAM ns1 "ACCOUNT NO. |" .
                       PUT STREAM ns1 "ACCOUNT NAME |" .
                       PUT STREAM ns1 "POLICY NO.  |" .
                       PUT STREAM ns1 "POLICY TYPE |" . /*---add by Chaiyong W. A66-0221 06/10/2023*/
                       PUT STREAM ns1 "NAME        |" .
                       PUT STREAM ns1 "Com.DATE    |" .
                       PUT STREAM ns1 "EXP.DATE    |" .
                       PUT STREAM ns1 "PREMIUM     |" .
                       PUT STREAM ns1 "STAMP       |" .
                       PUT STREAM ns1 "TAX         |" .
                       PUT STREAM ns1 "PREMIUM TOTAL    |" .
                       PUT STREAM ns1 "COMMISSION  |" .   
                       PUT STREAM ns1 "DOCUMENT NO.|" .         
                       PUT STREAM ns1 "STATUS JOB  |" .
                       PUT STREAM ns1 "REMARK       " SKIP.
                    OUTPUT STREAM ns1 CLOSE.
                END.       
            END.
            
            /*-- รองรับงานหลาย Risk --*/
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                     sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                     sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK
            BREAK BY uwm100.branch :
                /*--
                FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                           sic_bran.uwm301.policy = sic_bran.uwm120.policy AND
                           sic_bran.uwm301.rencnt = sic_bran.uwm120.rencnt AND
                           sic_bran.uwm301.endcnt = sic_bran.uwm120.endcnt AND
                           sic_bran.uwm301.riskgp = sic_bran.uwm120.riskgp AND
                           sic_bran.uwm301.riskno = sic_bran.uwm120.riskno NO-LOCK NO-ERROR.
                comment by Chaiyong W. A66-0221 06/10/2023*/

                nv_name = "".
                FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                           sicsyac.xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    nv_name = sicsyac.xmm600.NAME.
                END.

                nv_premtot = sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r + sic_bran.uwm120.rtax_r.

                OUTPUT STREAM ns1 TO VALUE(n_file) APPEND. 

                PUT STREAM ns1 sic_bran.uwm100.acno1        FORMAT "X(10)"  "|".
                PUT STREAM ns1 nv_name                      FORMAT "X(100)" "|".
                PUT STREAM ns1 sic_bran.uwm120.policy       FORMAT "X(16)"  "|".
                PUT STREAM ns1 sic_bran.uwm100.poltyp       FORMAT "X(5)"   "|" . /*---add by Chaiyong W. A66-0221 06/10/2023*/
                PUT STREAM ns1 sic_bran.uwm100.ntitle +
                               sic_bran.uwm100.name1        FORMAT "X(100)" "|".
                PUT STREAM ns1 STRING(sic_bran.uwm100.comdat,"99/99/9999") FORMAT "X(10)" "|".
                PUT STREAM ns1 STRING(sic_bran.uwm100.expdat,"99/99/9999") FORMAT "X(10)" "|".
                PUT STREAM ns1 sic_bran.uwm120.prem_r       FORMAT "->>>,>>>,>>>,>>9.99" "|".      
                PUT STREAM ns1 sic_bran.uwm120.rstp_r       FORMAT "->>>,>>>,>>>,>>9.99" "|".
                PUT STREAM ns1 sic_bran.uwm120.rtax_r       FORMAT "->>>,>>>,>>>,>>9.99" "|".
                PUT STREAM ns1 nv_premtot                   FORMAT "->>>,>>>,>>>,>>9.99" "|".
                PUT STREAM ns1 sic_bran.uwm120.com1_r       FORMAT "->>>,>>>,>>>,>>9.99" "|".             
                /*-- Check Release --*/
                ASSIGN
                    n_docno  = "".

                FIND FIRST sicsyac.acm001 USE-INDEX acm00101 WHERE
                           sicsyac.acm001.trnty1 = sic_bran.uwm100.trty11 AND
                           sicsyac.acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.acm001 THEN DO:
                    IF sicsyac.acm001.policy = sic_bran.uwm100.policy THEN DO:
                        ASSIGN
                            n_docno  = trim(string(sicsyac.acm001.docno,"9999999999")). 
                    END.
                END.
              
                PUT STREAM ns1 n_docno                       FORMAT "x(10)" "|".        
                PUT STREAM ns1 sic_bran.sqm001.Jobq#         FORMAT "X(10)" "|". 
                PUT STREAM ns1 sic_bran.sqm001.prmts[16]     FORMAT "X(100)" SKIP.
                
                OUTPUT STREAM ns1 CLOSE.        
            END.
        END.
       /* DELETE sic_bran.sqm001.*/
    END.
    RELEASE SQM001.

    fiDetail = "Process Text complete... ".
    DISP fiDetail WITH FRAME fr_main.             
               
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCutTextVat C-Win 
PROCEDURE PDCutTextVat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_invtyp    AS CHAR FORMAT "X(3)".
DEFINE VAR nv_invoice   AS CHAR FORMAT "X(10)".
DEFINE VAR nv_trndat    AS CHAR FORMAT "X(10)".

/*DEF VAR nv_today AS DATE INIT ?.-- A62-0005 --*/
DEF VAR nv_datfr AS DATE INIT ?.
DEF VAR nv_datto AS DATE INIT ?.

ASSIGN
    nv_datfr = ?
    nv_datto = ? .
    nv_today = TODAY.

IF day(nv_today + 1) = 1  THEN DO:
    ASSIGN
        nv_datfr = DATE("15/" + string(MONTH(nv_Today),"99") + "/" + STRING(YEAR(nv_today),"9999"))
        nv_datto = nv_today.
END.
ELSE IF day(nv_today + 1) = 16 THEN DO:
    ASSIGN
        nv_datfr  = DATE("1/" + string(MONTH(nv_Today),"99") + "/" + STRING(YEAR(TODAY),"9999"))
        nv_datto  = nv_today.
END.

IF nv_datfr <> ? AND nv_datto <> ? THEN DO:

    n_file1 = TRIM(fipath) + "\ReportVat_" + STRING(TODAY,"99999999") + ".xls".
    OUTPUT STREAM ns2 TO VALUE(n_file1) APPEND.                
       PUT STREAM ns2 "ACCOUNT NO.      ;"   .
       PUT STREAM ns2 "ACCOUNT NAME     ;"   .
       PUT STREAM ns2 "POLICY NO.       ;"   .
       PUT STREAM ns2 "POLICY TYPE      ;" . /*---add by Chaiyong W. A66-0221 06/10/2023*/
       PUT STREAM ns2 "VAT TYPE         ;"   .
       PUT STREAM ns2 "INVOICE NO       ;"   .
       PUT STREAM ns2 "TRANDATE         ;"   .      
       PUT STREAM ns2 "STATUS JOB       ;"   .
       PUT STREAM ns2 "REMARK"          SKIP.

    FOR EACH sic_bran.sqm001  WHERE sic_bran.sqm001.Jobq# = "NOT"     AND
                                    sic_bran.sqm001.Qdate >= nv_datfr AND
                                    sic_bran.sqm001.Qdate <= nv_datto NO-LOCK 
    BREAK BY sic_bran.sqm001.prmts[1] :

        FIND FIRST sic_bran.uwm100  WHERE
                   sic_bran.uwm100.policy = sic_bran.sqm001.prmts[1]        AND
                   sic_bran.uwm100.rencnt = INTE(sic_bran.sqm001.prmts[2])  AND
                   sic_bran.uwm100.endcnt = INTE(sic_bran.sqm001.prmts[3])  AND 
                   sic_bran.uwm100.releas = NO     NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm100 THEN DO:

            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                     sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                     sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK
            /*BREAK BY uwm100.branch*/ :  /* A62-0005 */
    
                /*--
                FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                           sic_bran.uwm301.policy = sic_bran.uwm120.policy AND
                           sic_bran.uwm301.rencnt = sic_bran.uwm120.rencnt AND
                           sic_bran.uwm301.endcnt = sic_bran.uwm120.endcnt AND
                           sic_bran.uwm301.riskgp = sic_bran.uwm120.riskgp AND
                           sic_bran.uwm301.riskno = sic_bran.uwm120.riskno NO-LOCK NO-ERROR.              
                IF AVAIL sic_bran.uwm301 THEN DO:
                comment by Chaiyong W. A66-0221 06/10/2023*/
                
                    nv_name = "".
                    FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                               sicsyac.xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicsyac.xmm600 THEN DO:
                        nv_name = sicsyac.xmm600.NAME.
                    END.
        
                    /*-- Vat --*/         
                    PUT STREAM ns2 sic_bran.uwm100.acno1        FORMAT "x(10)"  ";".
                    PUT STREAM ns2 nv_name                      FORMAT "X(100)" ";". 
                    PUT STREAM ns2 sic_bran.uwm100.policy       FORMAT "X(16)"  ";".           
                    PUT STREAM ns2 sic_bran.uwm100.poltyp       FORMAT "X(5)"   ";". /*---add by Chaiyong W. A66-0221 06/10/2023*/

        
                    ASSIGN
                        nv_invtyp   = ""
                        nv_invoice  = "".
                      
                    IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
                        nv_invtyp = TRIM(sic_bran.uwm100.trty13).
                    END.
                    ELSE nv_invtyp = "T".       
        
                    FIND LAST stat.vat100 USE-INDEX vat10009 WHERE
                              stat.vat100.poltyp = sic_bran.uwm100.poltyp AND
                              stat.vat100.policy = sic_bran.uwm100.policy AND
                              stat.vat100.rencnt = sic_bran.uwm100.rencnt AND
                              stat.vat100.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL stat.vat100 THEN DO:
        
                        IF stat.vat100.invtyp  = nv_invtyp AND
                           stat.vat100.invoice = sic_bran.uwm100.docno1 THEN DO:

                            ASSIGN
                                nv_invtyp   = stat.vat100.invtyp    
                                nv_invoice  = trim(string(stat.vat100.invoice,"9999999999")) .  
                        END.
                    END.
                    /*-- Vat --*/           
                    PUT STREAM ns2 nv_invtyp        FORMAT "X(3)"  ";".                
                    PUT STREAM ns2 nv_invoice       FORMAT "x(10)" ";". 
                    PUT STREAM ns2 STRING(sic_bran.uwm100.trndat)  FORMAT "X(10)" ";".                              
                    PUT STREAM ns2 sic_bran.sqm001.Jobq#           FORMAT "X(10)" ";". 
                    PUT STREAM ns2 sic_bran.sqm001.prmts[16]       FORMAT "X(100)" SKIP.   
                //END. comment by Chaiyong W. A66-0221 06/10/2023*/
            END.
        END.
    END.
    OUTPUT STREAM ns2 CLOSE.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDelsqm001 C-Win 
PROCEDURE PDDelsqm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND sic_bran.sqm001 WHERE sic_bran.sqm001.prmts[1] = sic_bran.uwm100.policy NO-ERROR.
IF AVAIL sic_bran.sqm001 THEN DO: 
    DELETE sic_bran.sqm001.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDlishbranch C-Win 
PROCEDURE PDlishbranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global 
DEFINE VAR nv_server    AS CHAR.
DEFINE VAR nv_tmp       AS CHAR.
-----*/
DEFINE VAR chNotesSession   AS COM-HANDLE.
DEFINE VAR chNotesDatabase  AS COM-HANDLE.
DEFINE VAR chDocument       AS COM-HANDLE.
DEFINE VAR chNotesView      AS COM-HANDLE.
DEFINE VAR chNavView        AS COM-HANDLE.
DEFINE VAR chItem           AS COM-HANDLE.
DEFINE VAR nv_file          AS CHAR.
DEFINE VAR nv_file1         AS CHAR.
DEFINE VAR chRichIT         AS COM-HANDLE.
DEFINE VAR chAttFile        AS COM-HANDLE.

DEFINE VAR chGetview        AS COM-HANDLE.
DEFINE VAR nv_view          AS CHAR INIT "parameter".
DEFINE VAR nv_NextBrn       AS CHAR INIT "".

DEFINE VAR chcolumn     AS COM-HANDLE.
/*DEFINE VAR nv_count     AS INT INIT 0.*/
     
    nv_branchNotes = "".
    /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global 
    /*--จริง --*/
    nv_server   = "Safety_NotesServer/Safety".
    nv_tmp      = "Safety\uw\PolicyonWebReport.nsf".
    -------------*/

OUTPUT TO D:\AutoQ\NoteServer-Log.txt APPEND.
PUT "PDlishbranch" SKIP
    "Note Server Name : " nv_server FORMAT "X(80)" SKIP
    "Noes File Name   : " nv_tmp    FORMAT "X(80)" SKIP(1).
OUTPUT CLOSE.

    
    CREATE "Notes.NotesSession" chNotesSession NO-ERROR.
    chNotesDatabase     = chNotesSession:GetDatabase(nv_server , nv_tmp).
    IF chNotesDatabase:Isopen() = NO THEN DO:
        nv_err = "PDlishbranch NOT CONNECT Lotus Notes".
        RUN PD_putlog.
    END.
    ELSE DO:

        ASSIGN
        chNotesView  = chNotesDatabase:GetView(nv_view)
        chNavView    = chNotesView:CreateViewNav
        chcolumn     = chNotesView:GetallDocumentsByKey("branch")
        chDocument    = chcolumn:GetfirstDocument NO-ERROR.

        /*nv_count = chcolumn:COUNT.*/
        REPEAT:
            IF VALID-HANDLE(chDocument) = YES THEN DO:
                nv_NextBrn = "".
                nv_NextBrn = chDocument:Getfirstitem("subt"):TEXT.
                nv_NextBrn = TRIM(nv_NextBrn).
                IF nv_NextBrn <> "" THEN DO:
                    IF nv_branchNotes  = "" THEN nv_branchNotes  = nv_NextBrn.
                    ELSE nv_branchNotes  = nv_branchNotes  + "|" + nv_NextBrn.
                END.
                chDocument = chcolumn:GetNextDocument(chDocument) NO-ERROR.
            END.
            ELSE LEAVE.          
        END.
    END.   
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDPauseTime C-Win 
PROCEDURE PDPauseTime :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO D:\AutoQ\Pausetime.TXT APPEND.
PUT
    "Branch :" nv_brandesc FORMAT "X(25)" " |"
    "DATE :" TODAY FORMAT "99/99/9999"    " |"
    "TIME :" STRING(TIME,"HH:MM:SS")      SKIP.
OUTPUT CLOSE.

loop_pause:
REPEAT:
    IF  STRING(TIME,"HH:MM:SS") >= chk_time_fr AND
        STRING(TIME,"HH:MM:SS") <= chk_time_to THEN DO:
        fiDetail = STRING(TIME) + " Please wait...Time PAUSE 500 ms : " + STRING(TIME,"HH:MM:SS").
        DISP fiDetail WITH FRAME fr_main.
    
        PAUSE 500 NO-MESSAGE.  /*หน่วงเวลา 9 นาที*/
    END.
    ELSE LEAVE loop_pause.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDPolOnWeb_Main C-Win 
PROCEDURE PDPolOnWeb_Main :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wBran WHERE wBran.Branch = "All" NO-ERROR NO-WAIT.
IF NOT AVAIL wBran THEN DO:
    CREATE wBran.
    ASSIGN
        wBran.Branch = "All"
        wBran.Path   = n_file1.
END.
RELEASE wBran.

FOR EACH wBran 
    BREAK BY wBran.path :

    nv_brandesc = "".
    nv_bran     = "".

    IF FIRST-OF(wBran.path) THEN DO:
        nv_Notesfile = SEARCH(wBran.path).

        FIND FIRST tbBranch WHERE tbBranch.tbBran = wBran.Branch NO-LOCK NO-ERROR.
        IF AVAIL tbBranch THEN DO:
            
            IF wBran.branch = "All" THEN DO:
                ASSIGN
                  nv_brandesc = "Other"
                  nv_bran     = "".
            END.
            ELSE IF wBran.branch >= "91" AND wBran.branch <= "98" THEN DO:
                ASSIGN
                  nv_brandesc = "สาขาเพชรบุรีตัดใหม่(NZI)"
                  nv_bran     = "91-98".
            END.
            ELSE DO:
                ASSIGN
                  nv_bran     = tbBranch.tbBran
                  nv_Brandesc = tbBranch.tbDesc.
            END.
        END.
        ELSE DO:
            
            FIND FIRST sicsyac.xmm023 WHERE xmm023.branch = wBran.Branch NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN DO:
                IF wBran.branch = "All" THEN DO:
                    ASSIGN
                      nv_brandesc = "Other"
                      nv_bran     = "".
                END.
                ELSE IF wBran.branch >= "91" AND wBran.branch <= "98" THEN DO:
                    ASSIGN
                      nv_brandesc = "สาขาเพชรบุรีตัดใหม่(NZI)"
                      nv_bran     = "91-98".
                END.
                ELSE DO:
                    ASSIGN
                        nv_brandesc = xmm023.bdes
                        nv_bran     = xmm023.branch.
                END.    
            END.
            ELSE DO:
                IF wBran.branch = "All" THEN DO:
                    ASSIGN
                      nv_brandesc = "Other"
                      nv_bran     = "".
                END.
            END.

            CREATE tbBranch.
                ASSIGN
                   tbBranch.tbBran = nv_bran
                   tbBranch.tbDesc = nv_brandesc .    

            RUN PDlishbranch.  
        END.
       
        IF nv_brandesc = "Other" AND nv_chkdat = NO  THEN NEXT.
        ELSE DO :
            RUN PDPolOnWeb_sub.
        END.
        PAUSE 4 NO-MESSAGE.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDPolOnWeb_sub C-Win 
PROCEDURE PDPolOnWeb_sub :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global 
DEFINE VAR nv_server    AS CHAR.
DEFINE VAR nv_tmp       AS CHAR.
----------*/
DEFINE VAR chNotesSession   AS COM-HANDLE.
DEFINE VAR chNotesDatabase  AS COM-HANDLE.
DEFINE VAR chDocument       AS COM-HANDLE.
DEFINE VAR chNotesView      AS COM-HANDLE.
DEFINE VAR chNavView        AS COM-HANDLE.
DEFINE VAR chItem           AS COM-HANDLE.
DEFINE VAR chRichIT         AS COM-HANDLE.
DEFINE VAR chAttFile        AS COM-HANDLE.
DEF VAR Notes-DocIDOC AS CHAR.
        /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global   
        /*--จริง */
        nv_server   = "Safety_NotesServer/Safety".                     
        nv_tmp      = "Safety\uw\PolicyonWebReport.nsf".      
        ---------------*/

OUTPUT TO D:\AutoQ\NoteServer-Log.txt APPEND.
PUT "PDPolOnWeb_sub" SKIP
    "Note Server Name : " nv_server FORMAT "X(80)" SKIP
    "Noes File Name   : " nv_tmp    FORMAT "X(80)" SKIP(1).
OUTPUT CLOSE.

        CREATE "Notes.NotesSession" chNotesSession NO-ERROR.
        chNotesDatabase     = chNotesSession:GetDatabase(nv_server , nv_tmp).
        
        IF chNotesDatabase:Isopen() = NO THEN DO:
            nv_err = "PDPolOnWeb_sub/NOT CONNECT DB Lotus Notes".
            RUN PD_putlog.
        END.
        ELSE DO:    
            IF LOOKUP(nv_brandesc,nv_BranchNotes,"|") > 0 THEN DO:

                IF VALID-HANDLE(chDocument) = NO THEN DO:
                    chdocument  =   chNotesDatabase:CreateDocument.
                    chdocument:SAVE(TRUE , TRUE).
                    chItem      =   chDocument:replaceItemValue("Form" , "Document").
                    chItem      =   chDocument:replaceItemValue("Y" , "2018").
                END.

                chItem  = chDocument:replaceItemValue("Created" , chNotesSession:Username).
                chItem  = chDocument:replaceItemValue("region" , nv_brandesc).
                chItem  = chDocument:replaceItemValue("Date" , TODAY).
                chItem  = chDocument:replaceItemValue("TimeCreated" , STRING(TIME,"HH:MM")).
                chItem  = chDocument:replaceItemValue("Subject" , "Policy on Web Report data Transfer").
                
                chRichIT  = chDocument:CreateRichTextitem("Body").
        
                IF nv_Notesfile <> "" AND nv_Notesfile <> ? THEN DO:
                    
                    chAttFile  = chRichIT:EmbedObject(1454,"",nv_Notesfile) NO-ERROR.
                END.
               
                chDocument:SAVE(TRUE , TRUE).
                Notes-DocIDOC = chDocument:NoteID.
                nv_NextID  = Notes-DocIDOC.

                OUTPUT TO D:\AutoQ\CREATE_SendMail.TXT APPEND.
                  PUT "DATE : " TODAY FORMAT "99/99/9999"   "|"
                      "TIME : " STRING(TIME,"HH:MM:SS")     "|" 
                      "FROM : WGWGEQ70.W (PDPolOnWeb_sub)"  "|"
                      "Addr : " ip_addr     FORMAT "X(30)"  "|"
                      "CC   : " ip_cc       FORMAT "X(30)"  "|"
                      "Subj : " ip_subject  FORMAT "X(90)"  SKIP.
                OUTPUT CLOSE.

                RUN pdsendmail_Main.    /*ส่งเมล*/   

            END.
            ELSE NEXT.                      
        END. 

        RELEASE OBJECT chdocument      NO-ERROR  .
        RELEASE OBJECT chItem          NO-ERROR  .
        RELEASE OBJECT chNotesSession  NO-ERROR  .
        RELEASE OBJECT chNotesDatabase NO-ERROR  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDQuery C-Win 
PROCEDURE PDQuery :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brQuery
    FOR EACH wsqm001 NO-LOCK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDRelease C-Win 
PROCEDURE PDRelease :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DO TRANSACTION:
    FIND FIRST sicsyac.acm002 USE-INDEX acm00201 
         WHERE sicsyac.acm002.trnty1 = sic_bran.uwm100.trty11 AND
               sicsyac.acm002.docno  = sic_bran.uwm100.docno1 NO-ERROR.
    IF NOT AVAIL acm002 THEN DO:

        RUN PD_acm002.

        IF gv_acm002OK THEN DO:
            FIND FIRST sicsyac.acm001 USE-INDEX acm00101
                 WHERE sicsyac.acm001.trnty1 = sic_bran.uwm100.trty11 AND
                       sicsyac.acm001.docno  = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
            IF NOT AVAIL acm001 THEN DO:
                RUN PD_acm001.

                IF gv_acm001OK THEN DO:

                    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE
                         sicuw.uwm100.policy = sic_bran.uwm100.policy AND
                         sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
                         sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        
                        ASSIGN
                            sicuw.uwm100.sch_p  = YES   /*sqm001.prmts[10] <> NO*/
                            sicuw.uwm100.drn_p  = YES   /*sqm001.prmts[10] <> NO*/
                            sicuw.uwm100.releas = YES
                            sicuw.uwm100.usridr = SUBSTRING(n_user,3,6)
                            sicuw.uwm100.reldat = TODAY
                            sicuw.uwm100.reltim = STRING(TIME,"hh:mm:ss")
                            sicuw.uwm100.trndat = TODAY.
                    END.
                    RELEASE sicuw.uwm100.
            
                END.

                RELEASE acm001.
            END.
        END.

        RELEASE acm002.
    END.

    /* เข้า OIC เฉพาะงาน พรบ. */
    IF  sic_bran.uwm100.poltyp  = "V72" OR  
        sic_bran.uwm100.poltyp  = "V73" OR
        sic_bran.uwm100.poltyp  = "V74" THEN DO:
    
        RUN PD_UZOICCOM .       
    
    END.
    ELSE DO: 
        IF sic_bran.uwm100.poltyp  = "V70" THEN DO:
            FIND FIRST sic_bran.uwd132  WHERE
                     sic_bran.uwd132.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt  AND 
                     sic_bran.uwd132.bencod  = "COMP" NO-LOCK NO-ERROR NO-WAIT. /* เฉพาะ 70 ที่มีงาน พรบ. */
            IF AVAILABLE uwd132 THEN 
                RUN PD_UZOICCOM .       
        END.
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDSendMail01 C-Win 
PROCEDURE PDSendMail01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*  ไม่มีการ call เรียก Procedure นี้  ----- A62-0005 -- Tantawan Ch. -----

DEF VAR nv_mail-n    AS CHAR INIT "mail\Iscenter.nsf".  /*   "mail\Iscenter.nsf". /*nsf*/         /*input  */   */
DEF VAR nv_mail-r    AS CHAR INIT "is@safety.co.th".    /*   "is@safety.co.th". /*Mail Reply*/  /*input  */     */
DEF VAR nv_mail      AS CHAR INIT "phornlym@gmail.com". /*   "chaiyong2530@gmail.com". /*Mail Send */           */
DEF VAR nv_cc        AS CHAR INIT "".                   /*    Mail CC*/                                   
DEF VAR nv_subject   AS CHAR INIT "Test system".        /*   "Policy". /*Subject mail*/                         */
DEF VAR nv_fpolicy   AS CHAR INIT "".                   /*   "D:\temp\ISP6084505.pdf".                          */

DEF VAR nv_mail-s    AS CHAR INIT "Safety_NotesServer/Safety". /*Server*//*fix*/
DEF VAR nv_mail-sh   AS CHAR INIT "Safety Insurance".
DEF VAR nv_path      AS CHAR INIT "".
DEF VAR nv_body      AS CHAR INIT "".
DEF VAR nv_namesend  AS CHAR INIT "".
DEF VAR nv_pclist    AS CHAR INIT "".
DEF VAR nv_ospclist  AS CHAR INIT "".
DEF VAR nv_nlnotes   AS logical init no.
DEF VAR nv_notes2    AS logical init no.
DEF VAR nv_WaitTotal AS INT INIT 0.
DEF VAR nv_waitcount AS INT INIT 0.

DEF VAR chSession    AS COM-HANDLE NO-UNDO.
DEF VAR chDBMail     AS COM-HANDLE NO-UNDO.
DEF VAR chDocMail    AS COM-HANDLE NO-UNDO.
DEF VAR chRichIT     AS COM-HANDLE NO-UNDO.
DEF VAR chAttFile    AS COM-HANDLE NO-UNDO.
                     
DEF VAR Mail-Server  AS CHAR NO-UNDO.
DEF VAR Mail-App     AS CHAR NO-UNDO.
DEF VAR nv_process   AS CHAR NO-UNDO.
DEF VAR nv_msgerr    AS CHAR NO-UNDO.
DEF VAR nv_phone     AS CHAR NO-UNDO.
DEF VAR nv_fsize     AS INT  NO-UNDO.
                     
DEF VAR nv_url       AS CHAR NO-UNDO.
DEF VAR nv_sms       AS CHAR NO-UNDO.
DEF VAR nv_msgsms    AS CHAR NO-UNDO.
DEF VAR nv_chksub    AS CHAR INIT "".
DEF VAR nv_csearch   AS CHAR INIT "".
DEF VAR nv_chktxt    AS CHAR INIT "".

/*--
FIND FIRST wBran WHERE wbran.mail = "Thamon Intaraprachak/AC/Safety" NO-ERROR NO-WAIT.
IF NOT AVAIL wBran THEN DO:
    CREATE wBran.
    ASSIGN
        wBran.Branch = "All"
        wBran.Path   = n_file1
        wBran.mail   = "Thamon Intaraprachak/AC/Safety".
END.
--*/

FOR EACH wBran NO-LOCK:

    nv_fpolicy = SEARCH(wBran.path).
    nv_mail    = wBran.mail.
    nv_subject = "สรุปข้อมูลกรมธรรม์ On Web Branch: " + wBran.branch + " ประจำวันที่ " + STRING(TODAY,"99/99/9999").

    ASSIGN
        nv_pclist   = TRIM(fipath) + "\ProcessList.txt"
        nv_ospclist = "WMIC /OUTPUT:" + nv_pclist + 
                      " Process Where (name='nlnotes.exe' or name='notes2.exe') get Name".
    
    IF SEARCH(nv_pclist) = ? THEN DO:
        OUTPUT TO VALUE(nv_pclist).
        OUTPUT CLOSE.
    END.
    
    OS-COMMAND SILENT VALUE(nv_ospclist).
    ASSIGN
        nv_WaitTotal  = 300000.
    
    DO WHILE nv_WaitCount <= nv_WaitTotal: /* 1/2 วินาที*/
        nv_WaitCount = nv_WaitCount + 1.
    END.
    
    INPUT FROM VALUE(nv_pclist).
    loop_notes:
    REPEAT:
        IMPORT nv_process.
    
        IF nv_process = "nlnotes.exe" THEN nv_nlnotes = YES.
        IF nv_process = "notes2.exe"  THEN nv_notes2  = YES.
    
        IF nv_nlnotes = YES OR
           nv_notes2  = YES THEN LEAVE loop_notes.   
    END.
    INPUT CLOSE.
    
    IF nv_nlnotes = NO AND
       nv_notes2  = NO THEN DO:    
    
        nv_msgerr = "1. Not Connect Lotus Notes !" + CHR(10)
                    + "Please Start Lotus Notes.".       
    END.
    ELSE DO:
        CREATE "Notes.NotesSession" chSession.
        /*chDBMail = chNotesSession:CurrentDatabase NO-ERROR.*/

        /*--*/
        chDBMail = chSession:GetDatabase(nv_mail-s,nv_mail-n) NO-ERROR.
    
        IF chDBMail:IsOpen = NO THEN DO:                             
            nv_msgerr = "2. Can not open Database " + CHR(10)         
                        + Mail-Server + CHR(10) + Mail-App.    
        END.  
        /*--*/                             
    END.
    
    IF nv_msgerr <> "" THEN DO:
        fiDetail = nv_msgerr.
        DISP fiDetail WITH FRAME fr_main.
        /*MESSAGE nv_msgerr VIEW-AS ALERT-BOX.*/
    END.
    ELSE DO:
        chDocMail = chDBMail:CreateDocument.
        ASSIGN
            chDocMail:FORM        = "MEMO"
            chDocMail:Sendto      = nv_mail
            chDocMail:Principal   = nv_mail-sh       
            chDocMail:InetSendTo  = nv_mail-r 
            chDocMail:ReplyTo     = nv_mail-r      
            chDocmail:Subject     = nv_subject.
        chRichIT  = chDocMail:CreateRichTextitem("Body").
    
        ASSIGN
           nv_csearch = nv_fpolicy /*"D:\WebQue\Test1.txt"*/
           nv_chksub  = "".
    
        nv_csearch = SEARCH(nv_csearch).
    
        IF nv_csearch <> "" AND nv_csearch <> ? THEN DO:
            chAttFile = chRichIT:EmbedObject(1454,"",nv_csearch) NO-ERROR.
        END.
    
        chRichIT:AddNewLine(1).
    
        chDocMail:SEND(FALSE).
        chDocMail:SAVE(TRUE,FALSE). 
    END.
    
    RELEASE OBJECT chSession NO-ERROR.
    RELEASE OBJECT chDBMail  NO-ERROR.
    RELEASE OBJECT chDocMail NO-ERROR.
    RELEASE OBJECT chRichIT  NO-ERROR.
    RELEASE OBJECT chAttFile NO-ERROR.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdsendmail_Main C-Win 
PROCEDURE pdsendmail_Main :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_mailBran = "".
nv_bran     = "".
nv_brandesc = "".

    IF wBran.Branch = "All" THEN DO:
        ASSIGN
            nv_bran     = "All"
            nv_brandesc  = "Other".
    END.

    FIND FIRST tbBranch WHERE tbBranch.tbBran = wBran.branch NO-LOCK NO-ERROR.
    IF AVAIL tbBranch THEN DO:
        
            IF wBran.branch  >= "91" AND wBran.branch <= "98" THEN DO:
                ASSIGN
                    nv_brandesc = "สาขาเพชรบุรีตัดใหม่(NZI)"
                    nv_bran     = "91-98".
            END.
            ELSE DO:

            ASSIGN
                nv_bran     = tbbranch.tbbran
                nv_brandesc = tbBranch.tbDesc.
            END.
    END.
    ELSE DO:
        FIND FIRST sicsyac.xmm023 WHERE xmm023.branch = wBran.branch NO-LOCK NO-ERROR.
        IF AVAIL xmm023 THEN DO:
            IF wBran.branch  >= "91" AND wBran.branch <= "98" THEN DO:
                ASSIGN
                    nv_brandesc = "สาขาเพชรบุรีตัดใหม่(NZI)"
                    nv_bran     = "91-98".
            END.
            ELSE DO:

                ASSIGN
                    nv_brandesc = xmm023.bdes
                    nv_bran     = xmm023.branch.
            END.
    
            CREATE tbBranch.
            ASSIGN
               tbBranch.tbBran = nv_bran
               tbBranch.tbDesc = nv_brandesc .

            RUN PDlishbranch.  
        END.    
    END.

    RUN PD_TOMail.       /*To Mail*/  
    RUN PD_CCmail.       /*CC mail*/

    IF wBran.branch = "All" THEN nv_mailBran = "All" .
    ELSE IF wBran.branch >= "91" AND wBran.branch <= "98" THEN nv_mailBran = "91-98".
    ELSE nv_mailBran = wBran.branch.

    IF nv_sendto <> "" THEN DO: 
        wBran.mail   = nv_sendto.
        IF nv_sendCC <> "" THEN wBran.ccmail = nv_sendCC.
    END.
    ELSE do:
        RUN PD_webmail.
        wBran.mail   = nv_TOEmail.  
        wBran.ccmail = nv_CCEmail.
    END.

    OUTPUT TO D:\AutoQ\Mail.TXT APPEND.
    PUT
        "FROM : WGWGEQ70.W (pdsendmail_Main)"    " |"
        "Addr : " wBran.mail    FORMAT "X(200)"  " |"
        "CC   : " wBran.ccmail  FORMAT "X(30)"   " |"
        "Subj : " nv_mailBran   FORMAT "X(90)"   " |"
        "DATE : " TODAY FORMAT "99/99/9999"      " |"
        "TIME : " STRING(TIME,"HH:MM:SS")      SKIP.
    OUTPUT CLOSE.

    RUN PDSendMail_sub.  /*ส่ง Mail*/
    PAUSE 4 NO-MESSAGE.  /*ห้ามปลดออก เพราะต้องการหน่วงเวลา ส่งเมล*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDSendMail_sub C-Win 
PROCEDURE PDSendMail_sub PRIVATE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_ExpFilename  AS CHAR INIT "".
DEFINE VAR nv_pathacno2    AS CHAR.
DEFINE VAR ip_addr         AS CHAR INIT "".     /*"Computer (Notes Team)" /*"Marine Group" */.*/
DEFINE VAR ip_cc           AS CHAR INIT "".     /*CC Address*/
DEFINE VAR ip_subject      AS CHAR INIT "".     /*"Send File". */
DEFINE VAR ip_body         AS CHAR INIT "".     /*"Marine Broker To Gateway Mail".*/   
DEFINE VAR ip_file         AS CHAR INIT "".     /*Path File Attach + File Attach*/
DEFINE VAR ip_bcc          AS CHAR INIT "".     /*BCC*/
DEFINE VAR chNotesSession  AS Com-Handle.       
/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global 
DEFINE VAR mail-file       AS CHAR.             /*check id*/
DEFINE VAR mail-server     AS CHAR.             /*Check server*/
-------------*/
DEFINE VAR chNotesDataBase AS Com-Handle.       
DEFINE VAR chnotesatttach  AS COM-HANDLE.       /*Attach file*/
DEFINE VAR chdocument      AS COM-HANDLE.
DEFINE VAR chNotesView     AS COM-HANDLE.
DEFINE VAR nv_filename     AS CHAR.

DEFINE VAR  n_i      AS INTEGER INIT 0.
DEFINE VAR  n_cnt    AS INTEGER INIT 0.
DEFINE VAR  n_cuttxt  AS CHAR.

        /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global   
           ใช้ชื่อตัวแปรเดียวกัน  เหมือน procedure อื่นๆ 
        /*--จริง */
        mail-server   =  "Safety_NotesServer/Safety".              
        mail-file     =  "Safety\uw\PolicyonWebReport.nsf". 
        -----------*/
OUTPUT TO D:\AutoQ\NoteServer-Log.txt APPEND.
PUT "PDSendMail_sub" SKIP
    "Note Server Name : " nv_server FORMAT "X(80)" SKIP
    "Noes File Name   : " nv_tmp    FORMAT "X(80)" SKIP(1).
OUTPUT CLOSE.

        CREATE "NOTES.NOTESSESSION":U chnotesSession NO-ERROR.
        /*chNotesDataBase = chnotessession:GetDatabase(mail-server , mail-file).---- A62-0005 ---*/
        chNotesDataBase = chnotessession:GetDatabase(nv_server , nv_tmp). /* A62-0005 */
        
        If chNotesDatabase:IsOpen()  = No Then Do:
            nv_err = "PDSendmail_sub/NOT CONNECT Lotus Notes".
            RUN PD_putlog.
        END.
        ELSE DO:  
           
           ASSIGN
                ip_addr      = wBran.mail  
                ip_cc        = wBran.CCmail 
                ip_bcc       = ""
                ip_subject   = "สรุปข้อมูลกรมธรรม์ On Web Branch: " +  nv_mailBran  + " ประจำวันที่ " + STRING(TODAY,"99/99/9999")
                ip_body      = ""
                ip_file      = nv_ExpFilename
                nv_filename  = "ReportMK" + nv_mailBran + string(TIME).  
            
           IF ip_addr <> "" THEN DO:

               FIND FIRST ctxbran.sqm001 WHERE
                          ctxbran.sqm001.jobq#   = "WSEND"     AND
                          ctxbran.sqm001.jobname = "ReportMK"  AND
                          ctxbran.sqm001.schdat  = TODAY       NO-ERROR NO-WAIT.
               IF NOT AVAIL ctxbran.sqm001 THEN DO:

                   CREATE ctxbran.sqm001.                  
                   ASSIGN
                       ctxbran.sqm001.progid      =   "WSEND"
                       ctxbran.sqm001.prmts[1]    =   "1"
                       ctxbran.sqm001.prmts[2]    =   ""           /*wBran.Path*/
                       ctxbran.sqm001.prmts[3]    =   ip_addr      /*ip_add*/
                       ctxbran.sqm001.prmts[4]    =   ip_cc        /*ip_cc*/
                       ctxbran.sqm001.prmts[5]    =   ""           
                       ctxbran.sqm001.prmts[6]    =   "Policy on Web Report Data Transfer"
                       ctxbran.sqm001.uname       =   ""
                       ctxbran.sqm001.prioty      =   3
                       ctxbran.sqm001.qname       =   "WSEND"
                       ctxbran.sqm001.dbnme       =   ""
                       ctxbran.sqm001.stsflg      =   ""
                       ctxbran.sqm001.prmts[7]    =   "ReportMK"
                       ctxbran.sqm001.prmts[8]    =   ip_subject
                       ctxbran.sqm001.prmts[9]    =   ""
                       ctxbran.sqm001.prmts[10]   =   nv_NextID     /*NotesID*/
                       ctxbran.sqm001.jobq#       =   "WSEND"
                       ctxbran.sqm001.jobname     =   nv_filename    /*"ReportMK+Branch+Time"*/
                       ctxbran.sqm001.schtim      =   STRING(MTIME)
                       ctxbran.sqm001.schdat      =   TODAY.    

                   OUTPUT TO D:\AutoQ\CREATE_SendMail.TXT APPEND.
                   PUT "DATE : " TODAY FORMAT "99/99/9999"   "|"
                       "TIME : " STRING(TIME,"HH:MM:SS")     "|"
                       "FROM : WGWGEQ70.W (PDSendMail_sub)"  "|"
                       "Addr : " ip_addr     FORMAT "X(30)"  "|"
                       "CC   : " ip_cc       FORMAT "X(30)"  "|"
                       "Subj : " ip_subject  FORMAT "X(90)"  SKIP.
                   OUTPUT CLOSE.

               END.                       
               RELEASE ctxbran.sqm001.

           END.    
        END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDStatusTrans C-Win 
PROCEDURE PDStatusTrans :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER nv_status AS CHAR.  /*FAIL/SUCCESS*/
DEFINE BUFFER bsqm001 FOR sic_bran.sqm001.

FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
           sicuw.uwm100.policy = sic_bran.uwm100.policy NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicuw.uwm100 THEN DO:
    nv_status = "FAIL".
END.

FIND bsqm001 WHERE RECID(bsqm001) = s_sqm001 NO-ERROR NO-WAIT.
IF AVAIL bsqm001 THEN DO:
    ASSIGN
        sic_bran.sqm001.jobq# = TRIM(nv_status)
        sic_bran.sqm001.prmts[16] = nv_message.     /*Add Jiraphon P. A60-0464*/
        /*sic_bran.sqm001.prmts[16] = putchr.   --Comment Jiraphon P. A60-0464*/

    IF nv_status = "SUCCESS" THEN DO:
        OUTPUT TO "D:\AutoQ\LOG_Success.txt" APPEND.
        PUT sic_bran.sqm001.prmts[1] FORMAT "X(30)" sic_bran.sqm001.Jobq# STRING(TODAY) FORMAT "X(10)" 
            STRING(TIME,"HH:MM:SS") FORMAT "X(10)" sic_bran.sqm001.prmts[16] SKIP.
        OUTPUT CLOSE.
    END.
    ELSE IF nv_status = "FAIL" THEN DO:
        OUTPUT TO "D:\AutoQ\LOG_Fail.txt" APPEND.
        PUT sic_bran.sqm001.prmts[1] FORMAT "X(30)" sic_bran.sqm001.jobq# STRING(TODAY) FORMAT "X(10)" 
            STRING(TIME,"HH:MM:SS") FORMAT "X(10)" sic_bran.sqm001.prmts[16] SKIP.
        OUTPUT CLOSE.
    END.
END.
RELEASE bsqm001.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDTransData C-Win 
PROCEDURE PDTransData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wmail:
    DELETE wmail.
END.
FOR EACH wBran:
    DELETE wBran.
END.
FOR EACH tbWebmail:
    DELETE tbWebmail.
END.
FOR EACH wsqm001:
    DELETE wsqm001.
END.
RUN PDQuery.
fiDetail = "Start Process Transfer.. ".
DISP fiDetail WITH FRAME fr_main.

PAUSE 2 NO-MESSAGE.

Loop_A:
REPEAT:

    PAUSE 1 NO-MESSAGE.
    IF LASTKEY = KEYCODE("F4") THEN DO: 
        ENABLE burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
        DISP burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
        nv_leave = "F4".
        LEAVE loop_A.
    END.
    /*-- Add Porntiwa T. --*/
    chk_export = STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999").

    IF (STRING(TIME,"HH:MM:SS") >= chk_time_fr  AND  
        STRING(TIME,"HH:MM:SS") <= chk_time_to) THEN DO:

        chk_send = YES.

        OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
        PUT 
           "DATE : " chk_export FORMAT "X(10)"       "|"
           STRING(TIME,"HH:MM:SS") " - Leave Loop A(1)" SKIP.
        OUTPUT CLOSE.

        /*-- Add Jiraphon P. --*/
        nv_today = TODAY.
        nv_tomor = ?.
        nv_tomor = nv_today + 1.
        
        IF day(nv_tomor) = 16 OR DAY(nv_tomor) = 1   THEN DO:  /*รายงาน Vat ส่งวันที่ 15 และ สิ้นเดือน*/
            nv_chkdat = YES.

            OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
            PUT "DATE : " chk_export FORMAT "X(10)" "|"
                STRING(TIME,"HH:MM:SS") " - Leave Loop A(1)" "|"
                "EXPORT Report Vat" FORMAT "X(20)"        SKIP.
            OUTPUT CLOSE.
            
        END. 
        /*-- End Jiraphon P. --*/        
    END.

    IF chk_send = YES THEN LEAVE Loop_A.
    /*-- End Add Porntiwa T. --*/

    fiDetail = STRING(TIME) + " Please Wait..Time: " + STRING(TIME,"HH:MM:SS").
    DISPLAY fiDetail WITH FRAME fr_main.

    DISABLE burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.
    DISP burun buexit fistatus fipath fi_timefr1 fi_timefr2 fi_timeto1 fi_timeto2 WITH FRAME fr_main.                          

    FIND FIRST sic_bran.sqm001 USE-INDEX sqm00101 WHERE
               sic_bran.sqm001.Jobq#  = fistatus  NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.sqm001 THEN DO:
        
        fiDetail = STRING(TIME) + " Process: " + sic_bran.sqm001.prmts[1].
        DISP fiDetail WITH FRAME fr_main. 

        /*-- Add Porntiwa T. --*/
        IF (STRING(TIME,"HH:MM:SS") >= chk_time_fr  AND  
            STRING(TIME,"HH:MM:SS") <= chk_time_to) THEN DO:
    
            chk_send = YES.

            OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
            PUT 
                "DATE : " chk_export FORMAT "X(10)"       "|"
                STRING(TIME,"HH:MM:SS") " - Leave Loop A(2)" SKIP.
            OUTPUT CLOSE.

            /*-- Add Jiraphon P. --*/
            nv_today = TODAY.
            nv_tomor = ?.
            nv_tomor = nv_today + 1.
            
            IF day(nv_tomor) = 16 OR DAY(nv_tomor) = 1   THEN DO:  /*รายงาน Vat ส่งวันที่ 15 และ สิ้นเดือน*/
                nv_chkdat = YES.

                OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
                PUT 
                   "DATE : " chk_export FORMAT "X(10)"       " | "
                   STRING(TIME,"HH:MM:SS") " - Leave Loop A(2)" " | "
                   "EXPORT Report Vat" FORMAT "X(20)"        SKIP.
                OUTPUT CLOSE.        
            END. 
            /*-- End Jiraphon P. --*/              
        END.
    
        IF chk_send = YES THEN LEAVE Loop_A.
        /*-- End Add Porntiwa T. --*/

        s_sqm001 = RECID(sic_bran.sqm001).

        /*-- Check Transfer Data --*/
        FIND FIRST sic_bran.uwm100 USE-INDEX uwm10001 
             WHERE sic_bran.uwm100.policy = sic_bran.sqm001.prmts[1]
               AND sic_bran.uwm100.rencnt = INTE(sic_bran.sqm001.prmts[2])
               AND sic_bran.uwm100.endcnt = INTE(sic_bran.sqm001.prmts[3]) 
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_bran.uwm100 THEN DO:
            
           /*Add F67-0001*/
           IF sic_bran.uwm100.polsta = "CA" THEN DO:
               nv_message = "".
               nv_message = "Polsta CA".
               RUN PDStatusTrans (INPUT "FAIL").
               NEXT.
           END.
           /*End F67-0001*/
           
           /*---add by songkran p. A65-0141 13/09/2022*/
           IF SUBSTR(sic_Bran.uwm100.policy,1,1) = "Q"  OR 
                SUBSTR(sic_Bran.uwm100.policy,1,1) = "R" THEN DO:
           
                 RUN pd_getcondition.
                  
                 FIND FIRST tautogw WHERE tautogw.acno = sic_Bran.uwm100.acno1 NO-LOCK NO-ERROR.
                 IF AVAILA tautogw THEN DO:
                     IF tautogw.condi <> "Transfer to Premium" AND 
                         tautogw.condi <> "Transfer to Premium with Create Inspection" THEN DO:
                         nv_message = "Policy type job Q,R " + tautogw.condi.
                         RUN PDStatusTrans (INPUT "FAIL").
                         LEAVE Loop_A.
                     END.
                 END.
           END.
           /*--- End add by songkran p. A65-0141 13/09/2022*/
           ASSIGN
               nv_batchyr = sic_bran.uwm100.bchyr
               nv_batchno = sic_bran.uwm100.bchNo 
               nv_batcnt  = sic_bran.uwm100.bchCnt
               nv_Policy  = sic_bran.uwm100.Policy
               nv_RenCnt  = sic_bran.uwm100.RenCnt
               nv_EndCnt  = sic_bran.uwm100.EndCnt
               nv_Insno   = sic_bran.uwm100.insref
               nv_poltyp  = sic_bran.uwm100.poltyp
               s_recid1   = RECID(sic_bran.uwm100).
           
           IF sic_bran.uwm100.branch  >= "91" AND sic_bran.uwm100.branch <= "98" THEN nv_bran = "91-98".
           ELSE nv_bran = sic_bran.uwm100.branch.                 
           
           FIND FIRST wBran WHERE wBran.Branch = sic_bran.uwm100.branch NO-ERROR.
           IF NOT AVAIL wBran THEN DO:
           
               CREATE wBran.
               ASSIGN
                   wBran.Branch = sic_bran.uwm100.branch
                   wBran.Company = trim(sic_bran.sqm001.prmts[4])
                   wBran.Path   = TRIM(fipath) + "\MK" + nv_bran + STRING(TODAY,"99999999") + ".csv".
           END.
           

           FIND FIRST tbWebmail WHERE tbWebmail.WebBran = sic_bran.uwm100.branch    and
                                      tbWebmail.Webcomp = trim(sic_bran.sqm001.prmts[4])  NO-ERROR.
           IF NOT AVAIL tbWebmail THEN DO:
               CREATE tbWebmail.
               ASSIGN
                   tbWebmail.WebBran = sic_bran.uwm100.branch
                   tbWebmail.WebComp = trim(sic_bran.sqm001.prmts[4]).
           END.
           
           OUTPUT TO D:\AutoQ\Policy.txt APPEND.
           PUT 
              "DATE : " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") " "  
               sic_bran.uwm100.policy + "/" + STRING(sic_bran.uwm100.RenCnt) + "/" + string(sic_bran.uwm100.endcnt)  FORMAT "X(25)" 
              "    QUEUE:" fistatus SKIP.
           OUTPUT CLOSE.                 

           /*-- Check btach --*/
           IF nv_batchyr <= 0  THEN DO:
              /*MESSAGE "Batch Year Error...!!" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
              RETURN NO-APPLY.
           END.
           IF nv_batchno = ""  THEN DO:
              /*MESSAGE "Batch No can't blank..!!" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
              RETURN NO-APPLY.
           END.
           ELSE DO:
              FIND LAST uzm701 USE-INDEX uzm70102
                  WHERE uzm701.bchyr = nv_batchyr AND 
                        uzm701.bchno = nv_batchno NO-LOCK NO-ERROR.
              IF NOT AVAIL uzm701 THEN DO:
                 /*MESSAGE "Not found Batch File Master on file uzm701" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
                 RETURN NO-APPLY.
              END.
              ELSE DO:
                IF uzm701.bchyr <> nv_batchyr THEN DO:
                   /*ESSAGE "Not found Batch File Master on file uzm701 (Year)" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
                   RETURN NO-APPLY.
                END.
              END.
           END.
           
           IF nv_batcnt <= 0  THEN DO:
              /*MESSAGE "Batch Count error..!!" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
              RETURN NO-APPLY.
           END.
           FIND LAST uzm701 USE-INDEX uzm70102
               WHERE uzm701.bchyr   =  nv_batchyr AND
                     uzm701.bchno   =  nv_batchno AND
                     uzm701.bchcnt  =  nv_batcnt NO-LOCK  NO-ERROR. /*A58-0251 Eakkapong ใส่ no-lock*/
           IF NOT AVAIL uzm701 THEN DO:
               /*MESSAGE "Batch No./Count " nv_batchno "/" nv_batcnt " not found" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/
               RETURN NO-APPLY.
           END.
           ELSE DO:
               /*--- เช็ค Batch status = Yes จึงจะให้ transfer batch no ได้ ---*/
               IF  uzm701.cnfflg = NO  THEN DO: 
                   /*MESSAGE "Batch Status Not Complete..!!" VIEW-AS ALERT-BOX.   --Comment Jiraphon P. A60-0464*/               
                   RETURN NO-APPLY.
               END.
               /*--- เช็ค trfflg = Yes แสดงว่ามีการ transfer แล้ว ---*/
               IF uzm701.trfflg = YES THEN DO:
                   /*MESSAGE "This Batch No. used transfer to Premium..!!" VIEW-AS ALERT-BOX.  --Comment Jiraphon P. A60-0464*/        
                   RETURN NO-APPLY.
               END.
           END.

           /*DO TRANSACTION:*/
           ASSIGN
               nv_error     = NO
               nv_timeend   = TIME
               nv_RecUwm100 = RECID(sic_bran.uwm100)
               nv_message   = ""
               putchr       = ""
               putchr1      = "".
           
           RUN PDCheckns1.
           /*---begin by Chaiyong W. A65-0185 21/07/2022*/
           nv_transfer = "".
           /*-- IF nv_error = NO THEN DO:  Comment  by songkran p. A65-0141 21/07/2022*/
            /*---add by songkran p. A65-0141 13/09/2022*/
           IF nv_error = NO AND SUBSTR(sic_Bran.uwm100.policy,1,1) <> "Q" AND 
                                SUBSTR(sic_Bran.uwm100.policy,1,1) <> "R" THEN DO: 
            /*---End add by songkran p. A65-0141 13/09/2022*/
               nv_message = "".
               RUN wgw\WGWVPTA1(INPUT RECID(sic_bran.uwm100),INPUT "WGWGEQ70",OUTPUT nv_message,OUTPUT nv_transfer).
               IF nv_message <> "" THEN DO:
                    ASSIGN
                        putchr  =  ""
                        putchr  = TRIM(textchr  + "  " +  nv_message).
                    nv_error = YES.
                END.
           END.
           /*End by Chaiyong W. A65-0185 21/07/2022-----*/
           
           fiDetail = STRING(TIME) + " " + sic_bran.uwm100.policy + ": " + nv_message.
           DISP fiDetail WITH FRAME fr_main.
           
           IF nv_error = NO THEN DO:
                
               /*---  add by songkran p. A65-0141 13/09/2022*/
               RUN PDTransData2. /*- Add  A65-0141 --*/
               IF sic_bran.uwm100.releas = YES  AND 
                   (SUBSTR(sic_Bran.uwm100.policy,1,1) = "Q" OR SUBSTR(sic_Bran.uwm100.policy,1,1) = "R") THEN DO:

                   FIND FIRST tautogw WHERE tautogw.acno = sic_Bran.uwm100.acno1  NO-LOCK NO-ERROR.
                   IF AVAILA tautogw THEN DO:
                       IF tautogw.condi = "Transfer to Premium with Create Inspection" THEN DO: //create ispno
                          n_user  = tautogw.email. // userid create isp box and email 
                          RUN wgw\wgwtinsp(INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt, 
                                           INPUT nv_Policy ,INPUT nv_RenCnt,INPUT nv_EndCnt,INPUT INTEGER(tautogw.ispbox)).

                          n_user = USERID(LDBNAME(1)).

                       END.
                   END.
                   EMPTY TEMP-TABLE  tautogw. 
                   RUN PDStatusTrans (INPUT "SUCCESS").
               END.
                /*--- End add by songkran p. A65-0141 13/09/2022*/
           END.  /*IF nv_error = NO*/
           ELSE DO:
               RUN PDStatusTrans (INPUT "FAIL").
           END.

           /*END.*/  /*DO*/
           
           /*-- Add Porntiwa T. --*/
           IF (STRING(TIME,"HH:MM:SS") >= chk_time_fr  AND  
               STRING(TIME,"HH:MM:SS") <= chk_time_to) THEN DO:
           
               chk_send = YES.
           
               OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
               PUT 
                   "DATE : " chk_export FORMAT "X(10)"       "|"
                   STRING(TIME,"HH:MM:SS") " - Leave Loop A(3)" SKIP.
               OUTPUT CLOSE.
           
               /*-- Add Jiraphon P. --*/
               nv_today = TODAY.
               nv_tomor = ?.
               nv_tomor = nv_today + 1.
               
               IF day(nv_tomor) = 16 OR DAY(nv_tomor) = 1   THEN DO:  /*รายงาน Vat ส่งวันที่ 15 และ สิ้นเดือน*/
                   nv_chkdat = YES.
           
                   OUTPUT TO VALUE ("D:\AutoQ\chk_Time.txt") APPEND.
                   PUT 
                      "DATE : " chk_export FORMAT "X(10)"       "|"
                      STRING(TIME,"HH:MM:SS") " - Leave Loop A(3)" "|"
                      "EXPORT Report Vat" FORMAT "X(20)"        SKIP.
                   OUTPUT CLOSE.                     
               END. 
               /*-- End Jiraphon P. --*/           
           END.
           IF chk_send = YES THEN LEAVE Loop_A.
                /*-- End Add Porntiwa T. --*/

        END. /*IF AVAIL sic_bran.uwm100*/

        /*RUN PDQuery.*/

        NEXT Loop_A.
    END.

    NEXT Loop_A.

END.  /*Loop_A*/

/*NEXT. */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDTransData2 C-Win 
PROCEDURE PDTransData2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DO TRANSACTION:
       RUN wgw\wgwgen09 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
               INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt,INPUT "WGWGEQ70"). /*---add  by chaiyong W. A65-0185 21/07/2022*/
       /*---Begin by Chaiyong W. A66-0221 06/10/2023*/
       RUN wgw\wgwgen101 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm101*/
                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen110 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm110*/
                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
       /*End by Chaiyong W. A66-0221 06/10/2023----*/

       RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
               INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
               INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       /*---Begin by Chaiyong W. A66-0221 06/10/2023*/
       RUN wgw\wgwgen200 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm200*/
                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen300 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm300*/
                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).

       /*End by Chaiyong W. A66-0221 06/10/2023----*/
       RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
               INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       /*---Begin by Chaiyong W. A66-0221 06/10/2023*/
       RUN wgw\wgwgen304 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm304*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen305 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm305*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen306 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm306*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       RUN wgw\wgwgen307 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm307*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       /*End by Chaiyong W. A66-0221 06/10/2023----*/


       RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       IF sic_bran.uwm100.poltyp = "V70" THEN /*---add by Chaiyong W. A66-0221 06/10/2023*/
       RUN wgw\wgwtalcm0 (INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_Endcnt).  /*uwm200 Add Jiraphon P. A60-0464*/
       RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       /*Add Jiraphon P. A63-0439*/
       RUN wgw\wgwgenrl (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,    /*Release ฝั่ง GW Tranfer uwm100+uwd100*/
                         INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
       /*End Add Jiraphon P. A63-0439*/
      
       /*---Begin by Chaiyong W. A65-0185 21/07/2022*/
       IF SUBSTR(sic_Bran.uwm100.policy,1,1) <> "Q" AND  
          SUBSTR(sic_Bran.uwm100.policy,1,1) <> "R" THEN DO:
           FIND FIRST sicuw.uwm100 WHERE sicuw.uwm100.policy = sic_bran.uwm100.policy AND
                                      sicuw.uwm100.rencnt = sic_Bran.uwm100.rencnt AND
                                      sicuw.uwm100.endcnt = sic_Bran.uwm100.endcnt NO-LOCK NO-ERROR.
           IF AVAIL sicuw.uwm100 THEN DO:
               nv_message = "".
               RUN wgw\WGWVPTA2(INPUT RECID(sicuw.uwm100),INPUT nv_transfer,INPUT "WGWGEQ70",OUTPUT nv_message).
               IF nv_message <> "" THEN DO:
                    ASSIGN
                        putchr  =  ""
                        putchr  = TRIM(textchr  + "  " +  nv_message).
                    nv_error = YES.
               END.
           END.
       END.

       /*End by Chaiyong W. A65-0185 21/07/2022-----*/
       IF sic_bran.uwm100.releas = YES THEN DO:
           RUN PDStatusTrans (INPUT "SUCCESS").
       END.
       ELSE RUN PDStatusTrans (INPUT "FAIL").

   END.  /*DO TRANSACTION*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDTrnVat C-Win 
PROCEDURE PDTrnVat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_brins      AS CHAR FORMAT "X(5)".    
DEFINE VAR nv_taxno      AS CHAR FORMAT "X(15)".   

IF sic_bran.uwm100.poltyp <> "M60" AND 
   sic_bran.uwm100.poltyp <> "M61" AND
   sic_bran.uwm100.poltyp <> "M62" AND
   sic_bran.uwm100.poltyp <> "M63" AND 
   sic_bran.uwm100.poltyp <> "M64" AND

   SUBSTR(sic_Bran.uwm100.policy,1,1) <> "Q" AND  
   SUBSTR(sic_Bran.uwm100.policy,1,1) <> "R" THEN DO:

    IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
          nv_invtyp = TRIM(sic_bran.uwm100.trty13).  
    END.
    ELSE IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "N" THEN 
         nv_invtyp = TRIM(sic_bran.uwm100.trty13).                             
    ELSE nv_invtyp = "T".

    FIND LAST sic_bran.xmm600 USE-INDEX xmm60001 WHERE
              sic_bran.xmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.xmm600 THEN DO:
        nv_brins = sic_bran.xmm600.anlyc5.
        nv_taxno = sic_bran.xmm600.icno.
    END.
    ELSE DO:
        nv_brins = "".
        nv_taxno = "".
    END.

    IF ( sic_bran.uwm100.docno1 <> "0000000" ) AND ( nv_invtyp <> "N" ) THEN DO:

        /*---- Tantawan Ch. A62-0005 ----*/
        FIND FIRST sicsyac.sym100 
            WHERE sicsyac.sym100.tabcod = "U083" AND 
                  sicsyac.sym100.itmcod = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.   
        IF AVAIL sym100 THEN nv_invbrn = TRIM(sicsyac.sym100.itmdes). 
        ELSE DO: 
            nv_invbrn = IF sic_bran.uwm100.branch <> "" THEN sic_bran.uwm100.branch ELSE "0". /* อิงตาม Policy Branch */
        END.
        /*-------------------------------*/

        FIND FIRST stat.vat100 USE-INDEX vat10001
             WHERE stat.vat100.invtyp  = nv_invtyp  
               AND stat.vat100.invoice = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
        IF NOT AVAILABLE stat.vat100 THEN DO:
            CREATE stat.VAT100.
            ASSIGN
                stat.vat100.invtyp   = TRIM(nv_invtyp) 
                stat.vat100.invoice  = Trim(STRING(sic_bran.uwm100.docno1,"9999999999"))
                stat.vat100.invdat   = sic_bran.uwm100.trndat  
                stat.vat100.poltyp   = sic_bran.uwm100.poltyp
                stat.vat100.policy   = sic_bran.uwm100.policy
                stat.vat100.rencnt   = sic_bran.uwm100.rencnt
                stat.vat100.endcnt   = sic_bran.uwm100.endcnt
                stat.vat100.branch   = sic_bran.uwm100.branch
                /*stat.vat100.invbrn   = SUBSTRING(USERID(LDBNAME(1)),6,2)  Jiraphon P. A60-0464 แก้ไขให้เข้าตาม Branch*/
                /*--- A62-0005 --
                stat.vat100.invbrn   = sic_bran.uwm100.branch             /*Jiraphon P. A60-0464 แก้ไขให้เข้าตาม Branch*/
                ----------------*/
                stat.vat100.invbrn   = nv_invbrn  /* A62-0005 */

                stat.vat100.acno     = sic_bran.uwm100.acno1
                stat.vat100.agent    = sic_bran.uwm100.agent
                stat.vat100.trnty1   = "M"
                stat.vat100.refno    = trim(STRING(sic_bran.uwm100.docno1,"9999999999"))
                stat.vat100.ratevat  = sic_bran.uwm100.gstrat
                                  
                stat.vat100.amount   = 0 /*sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t*/ /*อ้างอิงข้อ 14.01.22/23 ข้อมูลเป็น 0*/
                stat.vat100.discamt  = 0 
                stat.vat100.totamt   = sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t 
                /*stat.vat100.vatamt   = sic_bran.uwm100.rtax_t  comment Jiraphon P. A62-0286*/
                stat.vat100.vatamt   = sic_bran.uwm100.rtax_t + sic_bran.uwm100.ptax  /*Add Jiraphon P. A62-0286 editตามโปรแกรม trnvat*/
                stat.vat100.grandamt = sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t  + sic_bran.uwm100.rtax_t
                                 
                stat.vat100.pvrvjv   = ""
                stat.vat100.insref   = sic_bran.uwm100.insref
                stat.vat100.NAME     = TRIM(sic_bran.uwm100.ntitle) + TRIM(sic_bran.uwm100.name1) + 
                                       TRIM(sic_bran.uwm100.name2)  + TRIM(sic_bran.uwm100.name3)    
                stat.vat100.add1     = TRIM(sic_bran.uwm100.addr1)  + " " + TRIM(sic_bran.uwm100.addr2)
                stat.vat100.add2     = TRIM(sic_bran.uwm100.addr3)  + " " + TRIM(sic_bran.uwm100.addr4) + " " +
                                       TRIM(sic_bran.uwm100.postcd) /*เพิ่ม Postcd*/ 
                stat.vat100.desci    = "ค่าเบี้ยประกันตามกรมธรรม์เลขที่ " + sic_bran.uwm100.policy
                stat.vat100.descdis  = "หักส่วนลด"
                stat.vat100.entdat   = TODAY
                stat.vat100.enttime  = STRING(TIME,"hh:mm:ss")
                stat.vat100.usrid    = n_User
                stat.vat100.remark1  = ""
                stat.vat100.remark2  = ""
                stat.vat100.print    = YES
                stat.vat100.program  = sic_bran.uwm100.prog  /*"wgwgen08" Comment Jiraphon P. A62-0286*/
                stat.vat100.taxmont  = MONTH(sic_bran.uwm100.trndat)
                stat.vat100.taxyear  = YEAR(sic_bran.uwm100.trndat)
                stat.vat100.taxrepm  = NO
                stat.vat100.taxno    = nv_taxno + FILL(" ",19 - LENGTH(nv_taxno)) + nv_brins.

            
        END.
        RELEASE stat.vat100.
    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpRelease C-Win 
PROCEDURE PDUpRelease :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*nv_batdt =  "wgwgen08" + "|" + STRING(nv_batchyr,"9999") + STRING(nv_batchno) + STRING(nv_batcnt,"99") .  Comment Jiraphon P. A62-0286*/

FIND sic_bran.uwm100 USE-INDEX uwm10001  WHERE 
     sic_bran.uwm100.policy = nv_policy  AND
     sic_bran.uwm100.rencnt = nv_rencnt  AND
     sic_bran.uwm100.endcnt = nv_endcnt  AND
     sic_bran.uwm100.bchyr  = nv_batchyr AND
     sic_bran.uwm100.bchno  = nv_batchno AND
     sic_bran.uwm100.bchcnt = nv_batcnt  NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:
    nv_batdt =  sic_bran.uwm100.prog + "|" + STRING(nv_batchyr,"9999") + STRING(nv_batchno) + STRING(nv_batcnt,"99") .  /*Add Jiraphon P. A62-0286*/

    FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
         sicuw.uwm100.policy = sic_bran.uwm100.Policy AND
         sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
         sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.prog   = nv_batdt THEN DO:                                              
            FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm120 THEN DO:
                FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE sicuw.uwm130.policy = sicuw.uwm120.policy NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm130 THEN DO:
                    sic_bran.uwm100.releas = YES.

                END.
            END.
        END.
    END.
END.
/*RELEASE sic_bran.uwm100 NO-ERROR.*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_acm001 C-Win 
PROCEDURE PD_acm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
gv_acm001OK = NO.

CREATE sicsyac.acm001.
ASSIGN
  sicsyac.acm001.acno      = sicsyac.acm002.acno
  sicsyac.acm001.agent     = sicsyac.acm002.agent 
  sicsyac.acm001.curcod    = sicsyac.acm002.curcod
  sicsyac.acm001.branch    = sicsyac.acm002.branch
  sicsyac.acm001.trangp    = sicsyac.acm002.trangp
  sicsyac.acm001.trndat    = sicsyac.acm002.trndat
  sicsyac.acm001.ac_mth    = sicsyac.acm002.ac_mth
  sicsyac.acm001.ac_yr     = sicsyac.acm002.ac_yr
  sicsyac.acm001.trnty1    = sicsyac.acm002.trnty1
  sicsyac.acm001.trnty2    = sicsyac.acm002.trnty2
  sicsyac.acm001.docno     = sicsyac.acm002.docno
  sicsyac.acm001.insno     = sicsyac.acm002.insno
  sicsyac.acm001.instot    = sicsyac.acm002.instot
  sicsyac.acm001.clicod    = sicsyac.acm002.clicod
  sicsyac.acm001.acccod    = sicsyac.acm002.acccod
  sicsyac.acm001.prem      = sicsyac.acm002.prem
  sicsyac.acm001.comm      = sicsyac.acm002.comm
  sicsyac.acm001.fee       = sicsyac.acm002.fee
  sicsyac.acm001.stamp     = sicsyac.acm002.stamp
  sicsyac.acm001.tax       = sicsyac.acm002.tax
  sicsyac.acm001.netamt    = sicsyac.acm002.netamt
  sicsyac.acm001.netloc    = sicsyac.acm002.netloc
  sicsyac.acm001.bal       = sicsyac.acm002.bal
  sicsyac.acm001.baloc     = sicsyac.acm002.baloc
  sicsyac.acm001.ref       = sicsyac.acm002.ref
  sicsyac.acm001.cheque    = sicsyac.acm002.cheque
  sicsyac.acm001.comdat    = sicsyac.acm002.comdat
  sicsyac.acm001.poltyp    = sicsyac.acm002.poltyp
  sicsyac.acm001.policy    = sicsyac.acm002.policy
  sicsyac.acm001.recno     = sicsyac.acm002.recno
  sicsyac.acm001.cn_no     = sicsyac.acm002.cn_no
  sicsyac.acm001.vehreg    = sicsyac.acm002.vehreg
  sicsyac.acm001.disput    = sicsyac.acm002.disput
  sicsyac.acm001.erldat    = sicsyac.acm002.erldat
  sicsyac.acm001.insref    = sicsyac.acm002.insref
  sicsyac.acm001.mltyp1    = sicsyac.acm002.mltyp1
  sicsyac.acm001.mlno      = sicsyac.acm002.mlno
  sicsyac.acm001.cedno     = sicsyac.acm002.cedno
  sicsyac.acm001.cedent    = sicsyac.acm002.cedent
  sicsyac.acm001.cedref    = sicsyac.acm002.cedref
  sicsyac.acm001.thcess    = sicsyac.acm002.thcess
  sicsyac.acm001.bankno    = sicsyac.acm002.bankno
  sicsyac.acm001.cedco     = sicsyac.acm002.cedco
  sicsyac.acm001.usrid     = sicsyac.acm002.usrid
  sicsyac.acm001.entdat    = sicsyac.acm002.entdat
  sicsyac.acm001.enttim    = sicsyac.acm002.enttim
  sicsyac.acm001.ac1       = sicsyac.acm002.ac1
  sicsyac.acm001.ac2       = sicsyac.acm002.ac2.
ASSIGN
  sicsyac.acm001.ac3       = sicsyac.acm002.ac3
  sicsyac.acm001.ac4       = sicsyac.acm002.ac4
  sicsyac.acm001.ac5       = sicsyac.acm002.ac5
  sicsyac.acm001.ac6       = sicsyac.acm002.ac6
  sicsyac.acm001.ac7[ 1]   = sicsyac.acm002.ac7[ 1]
  sicsyac.acm001.ac7[ 2]   = sicsyac.acm002.ac7[ 2]
  sicsyac.acm001.ac7[ 3]   = sicsyac.acm002.ac7[ 3]
  sicsyac.acm001.ac7[ 4]   = sicsyac.acm002.ac7[ 4]
  sicsyac.acm001.ac7[ 5]   = sicsyac.acm002.ac7[ 5]
  sicsyac.acm001.ac7[ 6]   = sicsyac.acm002.ac7[ 6]
  sicsyac.acm001.ac7[ 7]   = sicsyac.acm002.ac7[ 7]
  sicsyac.acm001.ac7[ 8]   = sicsyac.acm002.ac7[ 8]
  sicsyac.acm001.ac7[ 9]   = sicsyac.acm002.ac7[ 9]
  sicsyac.acm001.ac7[10]   = sicsyac.acm002.ac7[10]
  sicsyac.acm001.ac7[11]   = sicsyac.acm002.ac7[11]
  sicsyac.acm001.ac7[12]   = sicsyac.acm002.ac7[12]
  sicsyac.acm001.ac7[13]   = sicsyac.acm002.ac7[13]
  sicsyac.acm001.ac7[14]   = sicsyac.acm002.ac7[14]
  sicsyac.acm001.amt1      = sicsyac.acm002.amt1
  sicsyac.acm001.amt2      = sicsyac.acm002.amt2
  sicsyac.acm001.amt3      = sicsyac.acm002.amt3
  sicsyac.acm001.amt4      = sicsyac.acm002.amt4
  sicsyac.acm001.amt5      = sicsyac.acm002.amt5
  sicsyac.acm001.amt6      = sicsyac.acm002.amt6
  sicsyac.acm001.amt7[ 1]  = sicsyac.acm002.amt7[ 1]
  sicsyac.acm001.amt7[ 2]  = sicsyac.acm002.amt7[ 2]
  sicsyac.acm001.amt7[ 3]  = sicsyac.acm002.amt7[ 3]
  sicsyac.acm001.amt7[ 4]  = sicsyac.acm002.amt7[ 4]
  sicsyac.acm001.amt7[ 5]  = sicsyac.acm002.amt7[ 5]
  sicsyac.acm001.amt7[ 6]  = sicsyac.acm002.amt7[ 6]
  sicsyac.acm001.amt7[ 7]  = sicsyac.acm002.amt7[ 7]
  sicsyac.acm001.amt7[ 8]  = sicsyac.acm002.amt7[ 8]
  sicsyac.acm001.amt7[ 9]  = sicsyac.acm002.amt7[ 9]
  sicsyac.acm001.amt7[10]  = sicsyac.acm002.amt7[10]
  sicsyac.acm001.amt7[11]  = sicsyac.acm002.amt7[11]
  sicsyac.acm001.amt7[12]  = sicsyac.acm002.amt7[12]
  sicsyac.acm001.amt7[13]  = sicsyac.acm002.amt7[13]
  sicsyac.acm001.amt7[14]  = sicsyac.acm002.amt7[14]
  sicsyac.acm001.amtl1     = sicsyac.acm002.amtl1
  sicsyac.acm001.amtl2     = sicsyac.acm002.amtl2
  sicsyac.acm001.amtl3     = sicsyac.acm002.amtl3
  sicsyac.acm001.amtl4     = sicsyac.acm002.amtl4
  sicsyac.acm001.amtl5     = sicsyac.acm002.amtl5
  sicsyac.acm001.amtl6     = sicsyac.acm002.amtl6
  sicsyac.acm001.amtl7[ 1] = sicsyac.acm002.amtl7[ 1]
  sicsyac.acm001.amtl7[ 2] = sicsyac.acm002.amtl7[ 2]
  sicsyac.acm001.amtl7[ 3] = sicsyac.acm002.amtl7[ 3]
  sicsyac.acm001.amtl7[ 4] = sicsyac.acm002.amtl7[ 4]
  sicsyac.acm001.amtl7[ 5] = sicsyac.acm002.amtl7[ 5]
  sicsyac.acm001.amtl7[ 6] = sicsyac.acm002.amtl7[ 6]
  sicsyac.acm001.amtl7[ 7] = sicsyac.acm002.amtl7[ 7]
  sicsyac.acm001.amtl7[ 8] = sicsyac.acm002.amtl7[ 8]
  sicsyac.acm001.amtl7[ 9] = sicsyac.acm002.amtl7[ 9]
  sicsyac.acm001.amtl7[10] = sicsyac.acm002.amtl7[10]
  sicsyac.acm001.amtl7[11] = sicsyac.acm002.amtl7[11]
  sicsyac.acm001.amtl7[12] = sicsyac.acm002.amtl7[12]
  sicsyac.acm001.amtl7[13] = sicsyac.acm002.amtl7[13]
  sicsyac.acm001.amtl7[14] = sicsyac.acm002.amtl7[14].
ASSIGN
  sicsyac.acm001.dept      = sicsyac.acm002.dept
  sicsyac.acm001.docaie    = sicsyac.acm002.docaie
  sicsyac.acm001.dname     = sicsyac.acm002.dname
  sicsyac.acm001.daddr1    = sicsyac.acm002.daddr1
  sicsyac.acm001.daddr2    = sicsyac.acm002.daddr2
  sicsyac.acm001.daddr3    = sicsyac.acm002.daddr3
  sicsyac.acm001.daddr4    = sicsyac.acm002.daddr4
  sicsyac.acm001.dpostc    = sicsyac.acm002.dpostc
  sicsyac.acm001.dpostc    = sicsyac.acm002.dpostc
  sicsyac.acm001.detal1    = sicsyac.acm002.detal1
  sicsyac.acm001.detal2    = sicsyac.acm002.detal2
  sicsyac.acm001.bankp     = NO             /*  5.1.additon (b) */
  sicsyac.acm001.dociln    = sicsyac.acm002.dociln
  sicsyac.acm001.cheqpr    = sicsyac.acm002.cheqpr
  sicsyac.acm001.prog      = sicsyac.acm002.prog
  sicsyac.acm001.fptr01    = sicsyac.acm002.fptr01
  sicsyac.acm001.bptr01    = sicsyac.acm002.bptr01
  sicsyac.acm001.latdat    = ?              /*  5.1.additon (b) */
  sicsyac.acm001.langug    = sicsyac.acm002.langug
  sicsyac.acm001.lattyp    = "".

ASSIGN
  sicsyac.acm001.rencnt    = sic_bran.uwm100.rencnt
  sicsyac.acm001.endcnt    = sic_bran.uwm100.endcnt.

gv_acm001OK = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_acm002 C-Win 
PROCEDURE PD_acm002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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

  sicsyac.acm002.trnty1 = IF sicsyac.acm002.netamt >= 0 THEN 
                          IF sic_bran.uwm100.dir_ri THEN "M" ELSE "O"                                          
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

    {WGW/WGW20097.i amt2 premgl}
    {WGW/WGW20097.i amt3 commgl}
    {WGW/WGW20097.i amt4 pstpgl}
    {WGW/WGW20097.i amt5 pfeegl}
    {WGW/WGW20097.i amt6 ptaxgl}
    {WGW/WGW20097.i amt7[1] rstpgl}
    {WGW/WGW20097.i amt7[2] rfeegl}
    {WGW/WGW20097.i amt7[3] rtaxgl}

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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_CCmail C-Win 
PROCEDURE PD_CCmail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR chNotesSession  AS Com-Handle.
DEFINE VAR chNavView       AS COM-HANDLE.
/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global 
DEFINE VAR nv_server       AS CHAR.
DEFINE VAR nv_tmp          AS CHAR.
---*/
DEFINE VAR chNotesDataBase AS Com-Handle.
DEFINE VAR chdocument      AS COM-HANDLE.
DEFINE VAR chItem          AS COM-HANDLE.
DEFINE VAR chNotesView     AS COM-HANDLE.
DEFINE VAR nv_ccmail         AS CHAR.

DEFINE VAR nv_i         AS INTEGER INIT 0.
DEFINE VAR nv_i1        AS INTEGER INIT 0.
DEFINE VAR nv_i2        AS INTEGER INIT 0.
DEFINE VAR nv_cnt       AS INTEGER INIT 0.
DEFINE VAR nv_cnt1      AS INTEGER INIT 0.
DEFINE VAR nv_cuttxt    AS CHAR.
DEFINE VAR nv_cuttxt1   AS CHAR.

nv_ccmail = "".
nv_sendCC =  "" .
EXTENT(nv_arrayCC) = ?.
    /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global   
    /*---จริง --*/
    nv_server = "Safety_NotesServer/Safety".        
    nv_tmp    = "Safety\uw\PolicyonWebReport.nsf".  
    -------*/

OUTPUT TO D:\AutoQ\NoteServer-Log.txt APPEND.
PUT "PD_CCmail" SKIP
    "Note Server Name : " nv_server FORMAT "X(80)" SKIP
    "Noes File Name   : " nv_tmp    FORMAT "X(80)" SKIP(1).
OUTPUT CLOSE.
    
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase = chNotesSession:GetDatabase (nv_server , nv_tmp).

IF chNotesDatabase:IsOpen() = NO THEN DO:
    nv_err = "PD_CCmail NOT CONNECT Lotus Notes".
    RUN PD_putlog.
END.
ELSE DO:
    HIDE MESSAGE NO-PAUSE.

    chNotesView = chNotesDatabase:GetView("Parameter Send Mail") NO-ERROR.
    chNavView   = chNotesView:CreateViewNav.
    chDocument  = chNotesView:GetDocumentByKey(nv_brandesc) NO-ERROR.

    IF VALID-HANDLE(chDocument) = NO THEN DO:
        /*MESSAGE "Not found Parameter" VIEW-AS ALERT-BOX.*/
        NEXT.
    END.
    ELSE DO:
        chitem    = chDocument:Getfirstitem("CCMail") NO-ERROR.
        nv_ccmail = chitem:TEXT.
    END.
END.

IF nv_ccmail <> "" THEN  DO:
    nv_cnt = NUM-ENTRIES(Nv_ccmail,";").
    
    EXTENT(nv_arrayCC) = nv_cnt.
    
    loop_A:
    REPEAT:
        ASSIGN
            nv_i    = nv_i + 1
            nv_i1   = 0.
    
        nv_cuttxt = ENTRY(nv_i,nv_ccmail,";").
        nv_cnt1   = NUM-ENTRIES(nv_cuttxt,"=") NO-ERROR.
    
        IF nv_cnt1 <> 0 THEN DO:
            loop_B:
            REPEAT:
                ASSIGN
                    nv_i1       = nv_i1 + 1
                    nv_cuttxt1  = ""
                    nv_i2       = 0.
    
                    nv_cuttxt1  = TRIM(ENTRY(nv_i1,nv_cuttxt,"=")) NO-ERROR.  
                    IF INDEX(nv_cuttxt1,"/") <> 0 THEN DO:
                        nv_i2   = INDEX(nv_cuttxt1,"/") - 1.
                        nv_cuttxt1  = SUBSTR(nv_cuttxt1,1,nv_i2).
                    END.
        
                IF nv_arrayCC[nv_i] = "" AND length(nv_cuttxt1) > 2 THEN nv_arrayCC[nv_i] = nv_cuttxt1.
                ELSE IF nv_arrayCC[nv_i] <> "" THEN nv_arrayCC[nv_i] = nv_arrayCC[nv_i] + "/" + nv_cuttxt1.
                    
                IF nv_i1 >= nv_cnt1 THEN LEAVE loop_B.
            END.
        END.
    
        IF nv_sendCC = "" THEN nv_sendCC =  nv_arrayCC[nv_i].
        ELSE nv_sendCC = nv_sendCC + ", " +  nv_arrayCC[nv_i].
    
        IF nv_i >= nv_cnt THEN LEAVE loop_A.
    
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_getcondition C-Win 
PROCEDURE pd_getcondition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 EMPTY TEMP-TABLE  tautogw.

 CREATE tautogw.
 ASSIGN
    tautogw.recpol  = RECID(sic_bran.uwm100)
    tautogw.company = sic_bran.sqm001.prmts[4]
    tautogw.acno    = sic_bran.uwm100.acno1
    tautogw.poljob  = SUBSTR(sic_Bran.uwm100.policy,1,1).

 RUN wgw\wgwcqratr(INPUT-OUTPUT TABLE tautogw).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_putlog C-Win 
PROCEDURE PD_putlog :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_NewInput = string(year(today),"9999")
             + string(month(today),"99")
             + string(day(today),"99")
             + substr(string(datetime(today, mtime)),12,12).
nv_NewInput  = replace(nv_NewInput,":","").
nv_NewInput  = replace(nv_NewInput,".","").

OUTPUT TO VALUE("D:\AutoQ\Log_ErrWGWGEQ70_" + fistatus + ".TXT") append.
PUT
    "Procedure:" nv_err FORMAT "X(30)"
    "Input:" nv_NewInput format "X(30)"
    today format "99/99/9999" "  "
    string(time,"HH:MM:SS")   "."
    substr(string(mtime,">>>>99999999"),10,3)   skip.
output close.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_TOMail C-Win 
PROCEDURE PD_TOMail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR chNotesSession  AS Com-Handle.
DEFINE VAR chNavView       AS COM-HANDLE.
/* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global   
DEFINE VAR nv_server       AS CHAR.
DEFINE VAR nv_tmp          AS CHAR.
----------*/
DEFINE VAR chNotesDataBase AS Com-Handle.
DEFINE VAR chdocument      AS COM-HANDLE.
DEFINE VAR chItem          AS COM-HANDLE.
DEFINE VAR chNotesView     AS COM-HANDLE.
DEFINE VAR nv_mail         AS CHAR.


DEFINE VAR nv_i         AS INTEGER INIT 0.
DEFINE VAR nv_i1        AS INTEGER INIT 0.
DEFINE VAR nv_i2        AS INTEGER INIT 0.
DEFINE VAR nv_cnt       AS INTEGER INIT 0.
DEFINE VAR nv_cnt1      AS INTEGER INIT 0.
DEFINE VAR nv_cuttxt    AS CHAR.
DEFINE VAR nv_cuttxt1   AS CHAR.

nv_mail = "".
nv_sendto =  "" .
EXTENT(nv_array) = ?.
    /* A62-0005 -- เปลี่ยนมาเป็นตัวแปร global   
    /*-- จริง --*/
    nv_server =  "Safety_NotesServer/Safety".        
    nv_tmp    =  "Safety\uw\PolicyonWebReport.nsf".  
    -------------*/
OUTPUT TO D:\AutoQ\NoteServer-Log.txt APPEND.
PUT "PD_TOMail" SKIP
    "Note Server Name : " nv_server FORMAT "X(80)" SKIP
    "Noes File Name   : " nv_tmp    FORMAT "X(80)" SKIP(1).
OUTPUT CLOSE.
    
    CREATE "Notes.NotesSession"  chNotesSession NO-ERROR.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server , nv_tmp).

IF chNotesDatabase:IsOpen() = NO THEN DO:
    nv_err = "PD_TOmail NOT CONNECT Lotus Notes".
    RUN PD_putlog.
END.
ELSE DO:
    HIDE MESSAGE NO-PAUSE.

    chNotesView = chNotesDatabase:GetView("Parameter Send Mail") NO-ERROR.
    chNavView   = chNotesView:CreateViewNav.
    chDocument  = chNotesView:GetDocumentByKey(nv_brandesc) NO-ERROR.

    IF VALID-HANDLE(chDocument) = NO THEN DO:
        /*MESSAGE "Not found Parameter" VIEW-AS ALERT-BOX.*/
        NEXT.
    END.
    ELSE DO:
        chitem  = chDocument:Getfirstitem("SendTo") NO-ERROR.
        nv_mail = chitem:TEXT.
    END.
END.

IF nv_mail <> "" THEN DO:
    nv_cnt = NUM-ENTRIES(Nv_mail,";").
    
    EXTENT(nv_array) = nv_cnt.
    
    loop_A:
    REPEAT:
        ASSIGN
            nv_i    = nv_i + 1
            nv_i1   = 0.
    
        nv_cuttxt = ENTRY(nv_i,nv_mail,";").
        nv_cnt1   = NUM-ENTRIES(nv_cuttxt,"=") NO-ERROR.
    
        IF nv_cnt1 <> 0 THEN DO:
            loop_B:
            REPEAT:
                ASSIGN
                    nv_i1       = nv_i1 + 1
                    nv_cuttxt1  = ""
                    nv_i2       = 0.
    
                    nv_cuttxt1  = TRIM(ENTRY(nv_i1,nv_cuttxt,"=")) NO-ERROR.  
                    IF INDEX(nv_cuttxt1,"/") <> 0 THEN DO:
                        nv_i2   = INDEX(nv_cuttxt1,"/") - 1.
                        nv_cuttxt1  = SUBSTR(nv_cuttxt1,1,nv_i2).
                    END.           
    
                IF nv_array[nv_i] = "" AND length(nv_cuttxt1) > 2 THEN nv_array[nv_i] = nv_cuttxt1.
                ELSE IF nv_array[nv_i] <> "" THEN nv_array[nv_i] = nv_array[nv_i] + "/" + nv_cuttxt1.
                    
                IF nv_i1 >= nv_cnt1 THEN LEAVE loop_B.
            END.
        END.
    
        IF nv_sendto = "" THEN nv_sendto =  nv_array[nv_i].
        ELSE nv_sendto = nv_sendto + ", " +  nv_array[nv_i].
    
        IF nv_i >= nv_cnt THEN LEAVE loop_A.
    
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_UZOICCOM C-Win 
PROCEDURE PD_UZOICCOM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR nv_jobvat_id AS CHARACTER FORMAT "X(12)" INIT "COMOICINT".      /* Printer Id */
/* A62-0005 --
DEFINE VAR gv_prgid     AS CHARACTER FORMAT "X(12)" INIT "WGWTRN70.W".     /* Printer Id */
*/
DEFINE VAR gv_prgid     AS CHARACTER FORMAT "X(12)" INIT "WGWGEQ70.W".     /* Printer Id */  /* A62-0005 */

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
         WHERE sicsyac.sqm001.jobno     = sic_bran.uwm100.policy 
         AND   sicsyac.sqm001.prmts[2]  = STRING(sic_bran.uwm100.rencnt,"999")
         AND   sicsyac.sqm001.prmts[3]  = STRING(sic_bran.uwm100.endcnt,"999")
         AND   sicsyac.sqm001.Jobq#     = nv_ptrid  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sqm001 THEN DO:
        loop_chk:
        REPEAT:
          nv_seq    = nv_seq + 1 . 
          nv_prioty = TIME.
          nv_time   = STRING(TIME,"HH:MM:SS") + STRING(nv_seq). /* suthida t. 24-06-56 12.00*/
        
          FIND FIRST sicsyac.sqm001 WHERE
                     sicsyac.sqm001.Jobq#  = nv_ptrid       AND 
                     sicsyac.sqm001.Prioty = nv_prioty      AND 
                     sicsyac.sqm001.Qdate  = sic_bran.uwm100.trndat  AND 
                     sicsyac.sqm001.Qtime  = nv_time        NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sqm001 THEN DO:
             PAUSE 1 NO-MESSAGE.        /* ห้ามปลดออก เพราะ ต้องการหน่วงเวลา */
             NEXT.
          END. 
          ELSE DO:

              DO TRANSACTION:
            
                CREATE sicsyac.sqm001.
                ASSIGN
                    sicsyac.sqm001.Jobq#     = nv_ptrid           /*Job Queue = Printer Id*/
                    sicsyac.sqm001.Prioty    = nv_prioty          /*Priority      */
                    sicsyac.sqm001.Qdate     = sic_bran.uwm100.trndat      /*Date          */
                    sicsyac.sqm001.Qtime     = nv_time                            
                    sicsyac.sqm001.progid    = gv_prgid           /*Progid        */
                    sicsyac.sqm001.Jobname   = nv_jobname         /*Jobname       */
                    sicsyac.sqm001.schtim    = nv_time            /*Scheduled Time*/
                    sicsyac.sqm001.schdat    = sic_bran.uwm100.trndat      /*Scheduled Date*/
                    sicsyac.sqm001.Qname     = sic_bran.uwm100.name1       /*Jobname       */
                    sicsyac.sqm001.Stsflg    = sic_bran.uwm100.polsta      /*Status        */
                    /* -------------------------------------------------- */
                    sicsyac.sqm001.Uname     = sic_bran.uwm100.usrid       /*User Name     */
                    sicsyac.sqm001.Dbnme     = nv_branch          /*Dbname        */
                    sicsyac.sqm001.Jobno     = sic_bran.uwm100.policy      /*Jobno         */
                    sicsyac.sqm001.prmts[1]  = sic_bran.uwm100.policy      /*Paratms       */
                    sicsyac.sqm001.prmts[2]  = STRING(sic_bran.uwm100.rencnt,"999")
                    sicsyac.sqm001.prmts[3]  = STRING(sic_bran.uwm100.endcnt,"999")
                    sicsyac.sqm001.prmts[4]  = sic_bran.uwm100.endno
                    sicsyac.sqm001.prmts[5]  = ""
                    sicsyac.sqm001.prmts[6]  = ""
                    sicsyac.sqm001.prmts[7]  = ""
                    sicsyac.sqm001.prmts[8]  = ""
                    sicsyac.sqm001.prmts[9]  = ""
                    
                    sicsyac.sqm001.prmts[10] = sic_bran.uwm100.acno1
                    sicsyac.sqm001.prmts[11] = sic_bran.uwm100.trty11
                    sicsyac.sqm001.prmts[12] = sic_bran.uwm100.docno1
                    /* VAT */
                    sicsyac.sqm001.prmts[13] = TRIM(STRING(sic_bran.uwm100.gstrat,">>>>>9.99"))
                    sicsyac.sqm001.prmts[14] = TRIM(STRING(sic_bran.uwm100.prem_t  ,">>>>>>>9.99-"))
                    sicsyac.sqm001.prmts[15] = TRIM(STRING(sic_bran.uwm100.rstp_t ,">>>>>9.99-"))
                    sicsyac.sqm001.prmts[16] = TRIM(STRING(sic_bran.uwm100.rtax_t   ,">>>>>9.99-")).
            
              END.               /* DO TRANSACTION: */
              RELEASE sicsyac.sqm001.  /*A63-0377*/
          END.

          IF nv_seq  >= 1000 THEN nv_seq  = 0.
          LEAVE loop_chk.
        
        END.                 /* loop_chk: */
    END.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_WebMail C-Win 
PROCEDURE PD_WebMail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_i         AS INTEGER INIT 0.
DEFINE VAR nv_i1        AS INTEGER INIT 0.
DEFINE VAR nv_i2        AS INTEGER INIT 0.
DEFINE VAR nv_cnt       AS INTEGER INIT 0.
DEFINE VAR nv_cnt1      AS INTEGER INIT 0.
DEFINE VAR nv_cuttxt    AS CHAR.
DEFINE VAR nv_cuttxt1   AS CHAR.
DEFINE VAR nv_bran1     AS CHAR.
DEFINE VAR nv_bran2     AS CHAR.

ASSIGN
    nv_CCEmail = ""
    nv_TOEmail = "" 
    nv_bran1   = ""
    nv_bran2   = "".

FOR EACH tbWebmail WHERE tbWebmail.Webbran = WBran.Branch NO-LOCK:
    FOR EACH ctxstat.company WHERE  ctxstat.Company.Compno =  tbWebmail.Webcomp   NO-LOCK:
        IF ctxstat.Company.Email <> "" THEN DO:
            IF nv_TOEmail = "" THEN nv_TOEmail =  ctxstat.Company.Email.
            ELSE nv_TOEmail = nv_TOEmail + "," + ctxstat.Company.Email.
    
        END.
        IF ctxstat.Company.Internet <> "" THEN DO:
            IF nv_CCEmail = "" THEN nv_CCEmail =  ctxstat.Company.Internet.
            ELSE nv_CCEmail = nv_CCEmail + "," + ctxstat.Company.Internet.
    
        END.
    END.
END.
IF nv_TOEmail <> "" THEN DO:

    nv_i        = 0  .
    nv_i1       = 0  .
    nv_i2       = 0  .
    nv_cnt      = 0  .
    nv_cnt1     = 0  .
    nv_cuttxt   = "" .
    nv_cuttxt1  = "" .

    loop_chk1:
    REPEAT:
        ASSIGN
           nv_i    = nv_i + 1. 
           nv_i1   = 0.
           nv_cnt = NUM-ENTRIES(nv_TOEmail,",").
           nv_cuttxt = ENTRY(nv_i,nv_TOEmail,",").
    
           loop_chk2:
           REPEAT:
               nv_i1 = nv_i1 + 1.
               nv_cnt1 = NUM-ENTRIES(nv_TOEmail,",").
               
               if lookup(ENTRY(nv_i1,nv_TOEmail,","),nv_cuttxt1,",") = 0 then do:
                   IF nv_cuttxt1 = "" THEN nv_cuttxt1 = ENTRY(nv_i1,nv_TOEmail,","). 
                   ELSE nv_cuttxt1 = nv_cuttxt1 + "," + ENTRY(nv_i1,nv_TOEmail,","). 
               END.          
               IF nv_i1 >= nv_cnt1   THEN LEAVE loop_chk2.
           END.
        IF nv_i >= nv_cnt THEN LEAVE loop_chk1.
    END.
    nv_TOEmail =  nv_cuttxt1.
END.

IF nv_CCEmail <> "" THEN DO:
    
    nv_i        = 0  .
    nv_i1       = 0  .
    nv_i2       = 0  .
    nv_cnt      = 0  .
    nv_cnt1     = 0  .
    nv_cuttxt   = "" .
    nv_cuttxt1  = "" .

    loop_chk1:
    REPEAT:
        ASSIGN
           nv_i    = nv_i + 1. 
           nv_i1   = 0.
           nv_cnt = NUM-ENTRIES(nv_CCEmail,",").
           nv_cuttxt = ENTRY(nv_i,nv_CCEmail,",").
    
           loop_chk2:
           REPEAT:
               nv_i1 = nv_i1 + 1.
               nv_cnt1 = NUM-ENTRIES(nv_CCEmail,",").
               
               if lookup(ENTRY(nv_i1,nv_CCEmail,","),nv_cuttxt1,",") = 0 then do:
                   IF nv_cuttxt1 = "" THEN nv_cuttxt1 = ENTRY(nv_i1,nv_CCEmail,","). 
                   ELSE nv_cuttxt1 = nv_cuttxt1 + "," + ENTRY(nv_i1,nv_CCEmail,","). 
               END.          
               IF nv_i1 >= nv_cnt1   THEN LEAVE loop_chk2.
           END.
        IF nv_i >= nv_cnt THEN LEAVE loop_chk1.
    END.
    nv_CCEmail =  nv_cuttxt1.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_xmm023 C-Win 
PROCEDURE PD_xmm023 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH TBBranch:
    DELETE TBBranch.
END.
FOR EACH sicsyac.xmm023 NO-LOCK:
        CREATE TBBranch.
        ASSIGN
            tbBran = xmm023.branch
            tbDesc = xmm023.bdes.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

