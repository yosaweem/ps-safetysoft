&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME WGWAYCL1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WGWAYCL1 
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

  Created: TANTAWAN C.  [A51-0140   :  09/09/2008]
  Modify by: Lukkana M.  Date: 22/06/2009
  Assign no: A52-0136 แก้ไขให้เอาเครื่องหมาย " ออก และแก้ไขเบี้ย    
            เนื่องจากมีค่าติดลบทำให้ค่าที่แสดงออกมาเป็น ?     
  
  Modify By : Lukkana M.  Date : 23/04/2010
  Assign No : A53-0161 เพิ่มเช็คข้อมูลตามกรมธรรม์ และปีที่คุ้มครอง   
              และหากไม่พบข้อมูลในระบบไม่ต้องoutput ข้อมูลนั้นออกมา 
  Modify by : Nipawadee R. Date: 07/07/2010  [A53-0211]
              Garuntee Report AYCL     
 Modify by : Nipawadee R. Date: 07/07/2010  [A53-0239]
              Garuntee Report AYCL (แก้ไขต่อเนื่อง)   
/**************************************************************************/                     
 Modify by : Nipawadee R. DATE 01/10/2010 [A53-0312]
            ปรับแก้ไขเนื่องจาก Text file เรียก Data ออกมาไม่ตรงกับ 
            GUA Report  สาเหตุมาจาก ระบุเงื่อนไขในการตรวจสอบ Filter 
            ไม่ถูกต้อง
  Modify by : Nipawadee R. Date 01/12/2010 [A53-0380]
             ปรับแก้ไขช่อง เบี้ยสุทธิ  และเบี้ยรวม โดยยึดข้อมูล
             จาก Text file 
             
  Modify By : Lukkana M. Date : 17/05/2012
  Assign No : A55-0175 ปรับformat text file เพื่อส่ง aycal ใหม่       
  
  Modify By : Lukkana M. Date : 05/07/2012
  Assign No : A55-0209     
  
  Modify By : Lukkana M. Date : 30/07/2012
  Assign No : A55-0244 
  modify by : kridtiya i.Date : 14/05/2013 เพิ่ม Group producer code:
  Assign No : A56-0119         เพื่อดึงข้อมูล
  modify by : Kridtiya i. A57-0062 date. 18/02/2014 add type aycal or bay to file report
  modify by : Kridtiya i. A57-0062 date. 10/03/2014 add user and password 
  Modify By : Porntiwa P. A59-0184 Date. 23/05/2016 ปรับ Logo บริษัทเป็นสีแดง และ เพิ่มลายเว็นต์ผู้มีอำนาจเป็นสีน้ำเงิน
  modify by : Kridtiya i. A59-0359 Date. 29/07/2016 add Insurance  Year No.,Taxation
  modify by : Sarinya  c. A59-0436 Date. 19/09/2016 งานประเภท 2.1,2.2 ให้ช่องทุนตรงกับ FI & Theft  
  Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 เพิ่ม รหัส producer ,agent ใหม่
  Modify by : Ranu I. A65-0115 11/05/2022 เพิ่มตัวเลือกการเรียกรายงาน Release , Not Release ,All
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.

DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.

DEF VAR   nv_User       AS CHAR NO-UNDO.
/*DEF VAR   nv_pwd    LIKE _password NO-UNDO.  Lukkana M. A55-0209 16/07/2012*/

DEF VAR   nv_pwd      LIKE _password NO-UNDO.  /* Kridtiya i. A57-0062    */
DEF VAR   nv_fptr     AS INT. /*A53-0239*/    
DEF VAR   nv_bptr     AS INT.  /*A53-0239*/       
DEF VAR   n_recid     AS RECID. /*A53-0239*/ 
DEF VAR   nv_time     AS CHAR.
DEF VAR   nv_progid   AS CHAR. /*A53-0239*/

/*- Nipawadee A53-0211 16/07/2010 -*/
DEF  VAR report-library         AS CHAR INIT "WGW\wprl\Wgwaycl1.prl".
DEF  VAR report-name            AS CHAR INIT "AYCL01".              
                                
DEF  VAR RB-DB-CONNECTION       AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS     AS CHAR INIT "". /*Can Override Filter*/
DEF  VAR RB-FILTER              AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE           AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION   AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME        AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT        AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE         AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES       AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE          AS INTE INIT 0.
DEF  VAR RB-END-PAGE            AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN        AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE        AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS      AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS      AS LOG INIT yes.
DEF  VAR RB-NO-WAIT             AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS    AS CHAR INIT "".

DEF  VAR guser          AS CHAR. 
DEF  VAR gpasswd        AS CHAR.
DEF  VAR n_destination  AS CHAR INIT "".
DEF  VAR n_printer      AS CHAR INIT "".
DEF  VAR n_filename     AS CHAR INIT "".
DEF  VAR n_print        AS LOGICAL INIT NO.
DEFINE STREAM ns1.
/*- Nipawadee A53-0211 16/07/2010 -*/

DEFINE TEMP-TABLE tgenerage
    /* Add by : A65-0115 */
   FIELD rectyp         AS CHAR  INIT ""
   FIELD rseqno         AS CHAR  INIT ""
   FIELD prodcode       AS CHAR  INIT ""
   FIELD brncode        AS CHAR  INIT ""
   FIELD contno         AS CHAR  INIT ""
   FIELD ntitle         AS CHAR  INIT ""
   FIELD fname          AS CHAR  INIT ""
   FIELD lname          AS CHAR  INIT ""
   FIELD addr1          AS CHAR  INIT ""
   FIELD addr2          AS CHAR  INIT ""
   FIELD addr3          AS CHAR  INIT ""
   FIELD postcd         AS CHAR  INIT ""
   FIELD ICNO           AS CHAR  INIT ""
   FIELD brand          AS CHAR  INIT ""
   FIELD model          AS CHAR  INIT ""
   FIELD CCOLOR         AS char  INIT ""
   FIELD vehreg         AS CHAR  INIT ""
   FIELD province       AS CHAR  INIT ""
   FIELD yrmanu         AS CHAR  INIT ""
   FIELD engine         AS CHAR  INIT ""
   FIELD cha_no         AS CHAR  INIT ""
   FIELD eng_no         AS CHAR  INIT ""
   FIELD engine_typ     AS CHAR  INIT ""
   FIELD covcod         AS CHAR  INIT ""
   FIELD prem_cus       AS CHAR  INIT ""
   FIELD yrins          AS CHAR  INIT ""
   FIELD notify         AS CHAR  INIT ""
   FIELD Serialno       AS CHAR  INIT ""
   FIELD policy         AS CHAR  INIT ""
   FIELD comdat         AS CHAR  INIT ""
   FIELD expdat         AS CHAR  INIT ""
   FIELD si             AS CHAR  INIT ""
   FIELD prem           AS CHAR  INIT ""
   FIELD premtot        AS CHAR  INIT "" .
/* end : A65-0115 */

    /* comment by : A65-0115 ...
/*1*/    FIELD  rectyp     AS CHAR  INIT ""  
/*2*/    FIELD  rseqno     AS CHAR  INIT ""  
/*3*/    FIELD  compno     AS CHAR  INIT ""  
/*4*/    FIELD  brncode    AS CHAR  INIT ""  
/*5*/    FIELD  prodcode   AS CHAR  INIT ""  
/*6*/    FIELD  contno     AS CHAR  INIT ""
         FIELD  finint     AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
/*7*/    FIELD  ntitle     AS CHAR  INIT ""  
/*8*/    FIELD  fname      AS CHAR  INIT ""  
/*9*/    FIELD  lname      AS CHAR  INIT "" 
         FIELD  addr1      AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/ 
         FIELD  addr2      AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
         FIELD  addr3      AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
         FIELD  postcd     AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
         FIELD  flag       AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
/*10*/   FIELD  brand      AS char  INIT ""  
/*11*/   FIELD  model      AS CHAR  INIT ""  
         FIELD  CCOLOR     AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
/*12*/   FIELD  vehreg     AS CHAR  INIT ""  
/*13*/   FIELD  province   AS CHAR  INIT ""  
/*14*/   FIELD  yrmanu     AS CHAR  INIT ""  
/*15*/   FIELD  engine     AS CHAR  INIT ""  
/*16*/   FIELD  cha_no     AS CHAR  INIT ""  
/*17*/   FIELD  eng_no     AS CHAR  INIT ""
         FIELD  acno1      AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
         FIELD  covcod     AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
/*18*/   FIELD  compins    AS CHAR  INIT ""  
/*19*/   FIELD  policy     AS CHAR  INIT ""  
/*20*/   FIELD  comdat     AS CHAR  INIT ""  
/*21*/   FIELD  expdat     AS CHAR  INIT ""  
/*22*/   FIELD  si         AS CHAR  INIT ""      
/*23*/   FIELD  prem       AS CHAR  INIT ""  
/*24*/   FIELD  premtot    AS CHAR  INIT ""
         FIELD  prem_cus   AS CHAR  INIT "" /*Lukkana M. A55-0175 17/05/2012*/
/*25*/   FIELD  yrins      AS CHAR  INIT ""  
/*26*/   FIELD  notify     AS CHAR  INIT ""  
/*27*/   FIELD  jobcode    AS CHAR  INIT ""  
/*28*/   FIELD  firstdat   AS CHAR  INIT "" 
         FIELD  insrayrno  AS CHAR  INIT ""   /*A59-0359*/
         FIELD  premtax    AS CHAR  INIT "".  /*A59-0359*/
     ...end : A65-0115.... */
/* -------------------------------------------------------------------- */

DEFINE STREAM ssrn.
DEFINE STREAM nfile.
/*DEFINE STREAM ndata. Nipawadee A53-0211 19/07/2010*/
DEFINE STREAM soutfile.
DEFINE STREAM outputdata.

DEFINE VAR nv_data      AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_notdata   AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.

DEF NEW SHARED VAR nv_bchyr    AS INT.
DEF NEW SHARED VAR nv_bchno    AS CHAR.
DEF NEW SHARED VAR nv_bchcnt   AS INT.
DEF NEW SHARED VAR nv_compcnt  AS INT.
DEF NEW SHARED VAR nv_ncompcnt AS INT.
DEF NEW SHARED VAR nv_outagent AS CHAR.  /*Lukkana M. A55-0209 11/07/2012*/
DEF NEW SHARED VAR nv_outagent2 AS CHAR.  /*Add Kridtiya i. A56-0119 14/05/2013*/
DEF VAR nv_bchprev AS CHAR.

/*----Nipawadee R. [A530211]----*/
/*แปลงวันที่*/
DEF VAR nv_comday   AS CHAR.    
DEF VAR nv_common   AS CHAR.    
DEF VAR nv_comyea   AS CHAR.    
DEF VAR nv_comyea1  AS INTE.    
DEF VAR nv_comdate1 AS CHAR.    
DEF VAR nv_comdate2 AS DATE.

/*----Nipawadee R. [A530211]----*/
/*แปลงเบี้ย*/
DEF VAR nv_prem1   AS INTE.                                                
DEF VAR nv_prem2   AS CHAR.                          
DEF VAR nv_prem3   AS DECI FORMAT ">>>>>>>>>>>>9.99".
DEF VAR nv_premto1 AS INTE.                                                
DEF VAR nv_premto2 AS CHAR.                          
DEF VAR nv_premto3 AS DECI FORMAT ">>>>>>>>>>>>9.99".
DEF VAR nv_premsi1   AS INTE.                                                
DEF VAR nv_premsi2   AS CHAR.                          
DEF VAR nv_premsi3   AS DECI FORMAT ">>>>>>>>>>>>9.99".

/*----Nipawadee R. [A530211]----*/
/*ยี่ห้อรถ*/
DEF VAR nvmoddes1   AS CHAR FORMAT "X(18)".
DEF VAR i_index     AS INTE.
DEF VAR nv_Covtext1 AS CHAR FORMAT "X(200)".

/*--Nipawadee R. [A530312]--*/
DEF VAR nv_progid2  AS CHAR.     
DEF VAR nv_useid    AS CHAR.     
DEF VAR nv_entdat   AS DATE.     
DEF VAR nv_enttime  AS CHAR.     
DEF VAR nv_codtime  AS CHAR.
DEF VAR outfile1    AS CHAR.  /*Lukkana M. A55-0175 07/06/2012*/
DEF VAR outfile2    AS CHAR.  /*Lukkana M. A55-0209 11/07/2012*/
DEF VAR nv_row1     AS INTE.  /*Lukkana M. A55-0209 11/07/2012*/
DEF VAR n_branchaycl AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR n_branchsty  AS CHAR FORMAT "x(35)" INIT "" .

DEF VAR nv_pic               AS CHAR INIT "".
DEF VAR nv_pstamp            AS CHAR INIT "".
DEF VAR nv_Signature         AS CHAR.

DEF VAR outfile      AS CHAR.
DEF VAR logAns       AS LOGI INIT No.
DEF VAR n_rseqno     AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
DEF VAR n_rseqno1    AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/
DEF VAR n_totpolno   AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
DEF VAR n_totpolno1  AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/
DEF VAR nv_premtaxs  AS CHAR .
DEFINE TEMP-TABLE workf_aycl
    FIELD         bchyr         AS INT 
    FIELD         bchno         AS CHAR 
    FIELD         bchcnt        AS INT 
    FIELD         rseqno        AS CHAR  INIT ""  
    FIELD         finint        AS CHAR  INIT "" 
    FIELD         addr1         AS CHAR  INIT "" 
    FIELD         addr2         AS CHAR  INIT "" 
    FIELD         addr3         AS CHAR  INIT "" 
    FIELD         postcd        AS CHAR  INIT "" 
    FIELD         flag          AS CHAR  INIT "" 
    FIELD         CCOLOR        AS CHAR  INIT "" 
    FIELD         acno1         AS CHAR  INIT "" 
    FIELD         covcod        AS CHAR  INIT "" 
    FIELD         prem_cus      AS CHAR  INIT "" .
DEF VAR np_finint     AS CHAR  INIT "" .
DEF VAR np_addr1      AS CHAR  INIT "" .
DEF VAR np_addr2      AS CHAR  INIT "" .
DEF VAR np_addr3      AS CHAR  INIT "" .
DEF VAR np_postcd     AS CHAR  INIT "" .
DEF VAR np_flag       AS CHAR  INIT "" .
DEF VAR np_CCOLOR     AS CHAR  INIT "" .
DEF VAR np_acno1      AS CHAR  INIT "" .
DEF VAR np_covcod     AS CHAR  INIT "" .
DEF VAR np_prem_cus   AS CHAR  INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_input

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES aycldeto2_fil

/* Definitions for BROWSE br_input                                      */
&Scoped-define FIELDS-IN-QUERY-br_input aycldeto2_fil.rseqno aycldeto2_fil.policy aycldeto2_fil.comdat aycldeto2_fil.expdat aycldeto2_fil.vehreg aycldeto2_fil.cha_no aycldeto2_fil.engine aycldeto2_fil.si aycldeto2_fil.prem aycldeto2_fil.premtot aycldeto2_fil.notify aycldeto2_fil.remark   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_input   
&Scoped-define SELF-NAME br_input
&Scoped-define QUERY-STRING-br_input FOR EACH aycldeto2_fil WHERE                             aycldeto2_fil.bchyr     =  nv_bchyr  AND                             aycldeto2_fil.bchno     =  nv_bchno  AND                             aycldeto2_fil.bchcnt    =  nv_bchcnt NO-LOCK     BY aycldeto2_fil.rseqno. /*Lukkana M. A53-0161 26/04/2010*/
&Scoped-define OPEN-QUERY-br_input OPEN QUERY br_input FOR EACH aycldeto2_fil WHERE                             aycldeto2_fil.bchyr     =  nv_bchyr  AND                             aycldeto2_fil.bchno     =  nv_bchno  AND                             aycldeto2_fil.bchcnt    =  nv_bchcnt NO-LOCK     BY aycldeto2_fil.rseqno. /*Lukkana M. A53-0161 26/04/2010*/.
&Scoped-define TABLES-IN-QUERY-br_input aycldeto2_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_input aycldeto2_fil


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_input}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_input ra_outfiletyp bu_findinput ~
bu_okconv fi_inputconv ra_typtitle ra_producer cbPrtList to_guaranexcel ~
to_guaranpdf to_textaycl fi_trndat fi_nbchno fi_branch fi_producer fi_agent ~
fi_bchprev fi_bchyr fi_bchcnt fi_filename bu_file fi_output3 buinp bu_exit ~
bu_hpbrn bu_hpacno1 bu_hpagent bu_out fi_outagent fi_outagentgrp ~
fi_outputconv RECT-370 RECT-373 RECT-374 RECT-376 RECT-372 RECT-377 ~
RECT-378 RECT-379 RECT-380 RECT-381 
&Scoped-Define DISPLAYED-OBJECTS ra_outfiletyp fi_inputconv ra_typtitle ~
ra_producer cbPrtList to_guaranexcel to_guaranpdf to_textaycl fi_trndat ~
fi_nbchno fi_branch fi_producer fi_agent fi_bchprev fi_bchyr fi_bchcnt ~
fi_filename fi_output3 fi_brndes fi_impcnt fi_proname fi_agtname ~
fi_completecnt fi_outagent fi_outagentgrp fi_outputconv 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WGWAYCL1 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buinp 
     LABEL "&INPUT" 
     SIZE 11.33 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 11.33 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY .95.

DEFINE BUTTON bu_findinput 
     LABEL "......" 
     SIZE 5.5 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_okconv 
     LABEL "CONVERT" 
     SIZE 11.33 BY 1.14.

DEFINE BUTTON bu_out 
     LABEL "&OUTPUT" 
     SIZE 11.33 BY 1.14
     FONT 6.

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchcnt AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bchprev AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputconv AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_nbchno AS CHARACTER FORMAT "X(16)":U 
      VIEW-AS TEXT 
     SIZE 23.17 BY .95
     FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_outagent AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outagentgrp AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputconv AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_outfiletyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Export Excel", 1,
"Match File Premium", 2,
"Match File", 3
     SIZE 23 BY 2.52
     BGCOLOR 3 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE ra_producer AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Output Group Producer Code :", 1,
"Output Producer Code :", 2
     SIZE 32.5 BY 2.38
     BGCOLOR 5 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_typtitle AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "AYCAL", 1,
"BAY", 2
     SIZE 21.5 BY .95
     BGCOLOR 3 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.33
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 15.24
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.5 BY 1.67
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.5 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.5 BY 1.67
     BGCOLOR 12 FGCOLOR 6 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 125 BY 3.24
     BGCOLOR 7 FGCOLOR 0 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.5 BY 1.86
     BGCOLOR 9 .

DEFINE VARIABLE to_guaranexcel AS LOGICAL INITIAL no 
     LABEL "Guarantee (Excel)" 
     VIEW-AS TOGGLE-BOX
     SIZE 22.5 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE to_guaranpdf AS LOGICAL INITIAL no 
     LABEL "Guarantee (Print)" 
     VIEW-AS TOGGLE-BOX
     SIZE 22.5 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE to_textaycl AS LOGICAL INITIAL no 
     LABEL "AYCAL Text File" 
     VIEW-AS TOGGLE-BOX
     SIZE 22.5 BY .81
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_input FOR 
      aycldeto2_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_input
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_input WGWAYCL1 _FREEFORM
  QUERY br_input DISPLAY
      aycldeto2_fil.rseqno      COLUMN-LABEL "Sequence"
 aycldeto2_fil.policy      COLUMN-LABEL "Policy" FORMAT "XX-XX-XX/XXXXXX"
 aycldeto2_fil.comdat      COLUMN-LABEL "Comdat"
 aycldeto2_fil.expdat      COLUMN-LABEL "Expdat"
 aycldeto2_fil.vehreg      COLUMN-LABEL "Veh.Reg."
 aycldeto2_fil.cha_no      COLUMN-LABEL "Chassis No."
 aycldeto2_fil.engine      COLUMN-LABEL "Engine"
 aycldeto2_fil.si          COLUMN-LABEL "Sum Insure"
 aycldeto2_fil.prem        COLUMN-LABEL "Premium"
 aycldeto2_fil.premtot     COLUMN-LABEL "Premium Total"
 aycldeto2_fil.notify      COLUMN-LABEL "Notify no."
 aycldeto2_fil.remark      COLUMN-LABEL "Comment" FORMAT "X(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 124 BY 4.52
         BGCOLOR 15 FONT 1 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_input AT ROW 17.91 COL 4
     ra_outfiletyp AT ROW 14.52 COL 5 NO-LABEL
     bu_findinput AT ROW 14.52 COL 107.67
     bu_okconv AT ROW 14.81 COL 114.67
     fi_inputconv AT ROW 14.52 COL 47 COLON-ALIGNED NO-LABEL
     ra_typtitle AT ROW 11.52 COL 5 NO-LABEL
     ra_producer AT ROW 11.52 COL 27.33 NO-LABEL
     cbPrtList AT ROW 8.76 COL 55.67 COLON-ALIGNED NO-LABEL
     to_guaranexcel AT ROW 9.67 COL 34.5
     to_guaranpdf AT ROW 10.57 COL 34.5
     to_textaycl AT ROW 8.76 COL 34.5
     fi_trndat AT ROW 2.48 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_nbchno AT ROW 23.19 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 2.48 COL 57.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.52 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 4.57 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchprev AT ROW 5.62 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 5.62 COL 69.67 COLON-ALIGNED NO-LABEL
     fi_bchcnt AT ROW 5.62 COL 92 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.67 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.67 COL 96.17
     fi_output3 AT ROW 7.71 COL 32.5 COLON-ALIGNED NO-LABEL
     buinp AT ROW 6 COL 107.5
     bu_exit AT ROW 9.57 COL 107.67
     fi_brndes AT ROW 2.48 COL 68.67 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 2.48 COL 66.5
     bu_hpacno1 AT ROW 3.52 COL 49.5
     bu_hpagent AT ROW 4.57 COL 49.5
     fi_impcnt AT ROW 23.19 COL 68.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_proname AT ROW 3.52 COL 55 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 4.57 COL 55 COLON-ALIGNED NO-LABEL
     bu_out AT ROW 7.76 COL 107.5
     fi_completecnt AT ROW 23.19 COL 107 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_outagent AT ROW 12.91 COL 58.5 COLON-ALIGNED NO-LABEL
     fi_outagentgrp AT ROW 11.52 COL 58.5 COLON-ALIGNED NO-LABEL
     fi_outputconv AT ROW 15.62 COL 47 COLON-ALIGNED NO-LABEL
     "      INPUT - OUTPUT TEXT FILE  'AYCAL'" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 1.14 COL 39
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 3.52 COL 15.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "File Input Match :" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 14.52 COL 29
          BGCOLOR 8 
     "File Output Match :" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 15.62 COL 29
          BGCOLOR 8 
     "Output Total Record :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 23.19 COL 106.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No. :" VIEW-AS TEXT
          SIZE 21 BY .95 AT ROW 5.62 COL 11.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 7.71 COL 14.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 23.19 COL 8.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code :" VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 4.57 COL 19
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Import Total Record :":60 VIEW-AS TEXT
          SIZE 23.83 BY .95 AT ROW 23.19 COL 67.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Branch :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 2.48 COL 50.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Count :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 5.62 COL 92.16 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Transaction Date :":35 VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 2.48 COL 14
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 5.62 COL 70 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 6.67 COL 9.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Report Type :" VIEW-AS TEXT
          SIZE 21 BY .95 AT ROW 8.76 COL 11.33
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-373 AT ROW 17.67 COL 1
     RECT-374 AT ROW 22.71 COL 1
     RECT-376 AT ROW 22.95 COL 5.5
     RECT-372 AT ROW 2.38 COL 1
     RECT-377 AT ROW 5.76 COL 106.5
     RECT-378 AT ROW 7.52 COL 106.5
     RECT-379 AT ROW 9.33 COL 106.5
     RECT-380 AT ROW 14.1 COL 2.83
     RECT-381 AT ROW 14.48 COL 113.5
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
  CREATE WINDOW WGWAYCL1 ASSIGN
         HIDDEN             = YES
         TITLE              = "<INPUT - OUTPUT TEXT FILE 'PIPE'>"
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
IF NOT WGWAYCL1:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WGWAYCL1
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_input 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 5.62 COL 70 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Batch Count :"
          SIZE 12.83 BY .95 AT ROW 5.62 COL 92.16 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Import Total Record :"
          SIZE 23.83 BY .95 AT ROW 23.19 COL 67.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Output Total Record :"
          SIZE 22.33 BY .95 AT ROW 23.19 COL 106.5 RIGHT-ALIGNED        */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWAYCL1)
THEN WGWAYCL1:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_input
/* Query rebuild information for BROWSE br_input
     _START_FREEFORM
OPEN QUERY br_input FOR EACH aycldeto2_fil WHERE
                            aycldeto2_fil.bchyr     =  nv_bchyr  AND
                            aycldeto2_fil.bchno     =  nv_bchno  AND
                            aycldeto2_fil.bchcnt    =  nv_bchcnt NO-LOCK
    BY aycldeto2_fil.rseqno. /*Lukkana M. A53-0161 26/04/2010*/
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_input */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WGWAYCL1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWAYCL1 WGWAYCL1
ON END-ERROR OF WGWAYCL1 /* <INPUT - OUTPUT TEXT FILE 'PIPE'> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWAYCL1 WGWAYCL1
ON WINDOW-CLOSE OF WGWAYCL1 /* <INPUT - OUTPUT TEXT FILE 'PIPE'> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buinp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buinp WGWAYCL1
ON CHOOSE OF buinp IN FRAME fr_main /* INPUT */
DO:
    DEF VAR n_cnt AS INTE.
    nv_bchyr = fi_bchyr.
    /*Lukkana M. A55-0209 12/07/2012*/
    IF INPUT fi_outagent <> "" THEN
        nv_outagent = "," + INPUT fi_outagent.
    ELSE nv_outagent = fi_outagent.
         /*Lukkana M. A55-0209 12/07/2012*/
    /*chk first */
    IF fi_branch = "" THEN DO:
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = "" THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = "" THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_trndat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_trndat.
        RETURN NO-APPLY.
    END.
    IF fi_bchprev <> ""  THEN DO:
        IF LENGTH(fi_bchprev) <> 16 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                "Please Check Batch No. Again             " view-as alert-box.
            APPLY "entry" TO fi_bchprev.
            RETURN NO-APPLY.
        END.
    END.
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    /*--
    IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END.
    Lukkana M. A55-0175 31/05/2012--*/
    ASSIGN
        fi_output3 = INPUT fi_output3.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
    END.

    MESSAGE COLOR YEL/RED 
        "      กด Yes เพื่อ Confirm Process Data    " SKIP
        " Input & Check Chassis AYCL " SKIP
        VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO
        TITLE "Warning Message" UPDATE choice AS LOGICAL.
    IF NOT choice THEN DO:
        MESSAGE COLOR YELLOW "ยกเลิกการProcess Data" VIEW-AS ALERT-BOX.  
        RETURN NO-APPLY.
    END.
    FOR EACH tgenerage:
        DELETE tgenerage.
    END.
    /**** INPUT & CHECK FILE DELIMITER ****/
    INPUT STREAM nfile FROM VALUE(fi_filename).
    REPEAT:
        CREATE tgenerage.
        IMPORT STREAM nfile DELIMITER "|" tgenerage.
        RELEASE tgenerage.
        n_cnt = n_cnt + 1. /*Lukkana M. A55-0175 31/05/2012*/
    END.
    INPUT STREAM nfile CLOSE.
    FIND FIRST tgenerage NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL tgenerage THEN DO:
        MESSAGE "ไม่พบข้อมูลที่จะทำการ Process " 
            VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        fi_impcnt = n_cnt - 2.
        DISP fi_impcnt WITH FRAME fr_main.
    END.
    /**** INPUT & CHECK FILE DELIMITER ****/
    /******** Running Batch No. *********/
    RUN wgw\wgwbch02 (             fi_trndat  ,
                                   fi_bchyr   ,
                                   fi_producer,
                                   fi_branch  ,
                                   fi_bchprev ,
                                   gv_prgid   ,
                                   "D"        ,   /* batch type D = Data */
                      INPUT-OUTPUT nv_bchno ,
                      INPUT-OUTPUT nv_bchcnt  ,
                                   /*fi_usrcnt  ). Lukkana M. A55-0175 31/05/2012*/
                                   fi_impcnt ).    /*Lukkana M. A55-0175 31/05/2012*/
    
    DISP nv_bchno @ fi_nbchno WITH FRAME fr_main.
    DISP nv_bchno @ fi_bchprev WITH FRAME fr_main.  /*Lukkana M. A55-0244 07/08/2012*/
    /******** Running Batch No. *********/
    /*RUN proc_screen. Lukkana M. A55-0209 06/07/2012*/
    FOR EACH workf_aycl.     /*A59-0359*/
        DELETE workf_aycl.   /*A59-0359*/
    END.                     /*A59-0359*/
    RUN pdcreate . 
    /*RUN wgw\wgwmatch .*/
    
    IF ra_typtitle = 1  THEN DO:  /*A65-0115*/
        /*Add kridtiya i. A56-0119*/
        IF ra_producer = 1  THEN DO: 
            ASSIGN nv_outagent2 = fi_outagentgrp.
            /*RUN wgw\wgwmatc1.*/  /*A59-0359*/
            RUN wgw\wgwmaty1.      /*A59-0359*/
        END.
        ELSE DO: 
            ASSIGN nv_outagent = fi_outagent . /*A65-0115*/
            RUN wgw\wgwmaty2.     /*A59-0359*/
        END.
        /*ELSE RUN wgw\wgwmatch.*/ /*A59-0359*/
    END.
    /*add : A65-0115*/
    ELSE DO:
        RUN wgw\wgwmaty3.
    END.
    /* end : A65-0115*/
    
    /*Add kridtiya i. A56-0119 */
    RUN proc_upuzm705.   /*--Lukkana M. A55-0175 28/05/2012--*/
    /*---
    FIND FIRST uzm705 USE-INDEX uzm70501 WHERE 
               uzm705.bchtyp = "D"          AND
               uzm705.branch = fi_branch    AND
               uzm705.acno   = fi_producer  AND
               uzm705.bchyr = nv_bchyr      AND
               uzm705.bchno = nv_bchno      AND
               uzm705.bchcnt = nv_bchcnt  NO-ERROR.
    IF AVAIL uzm705 THEN DO:
        ASSIGN
            uzm705.recout   = nv_compcnt
            uzm705.outdat   = TODAY
            uzm705.outusrid = gv_prgid.
    END.
    RELEASE uzm705.
    Lukkana M. A55-0175 28/05/2012--*/
    /*--Lukkana M. A55-0175 28/05/2012--*/
    fi_completecnt = nv_compcnt .
    DISP fi_completecnt WITH FRAME fr_main.
    /*--Lukkana M. A55-0175 28/05/2012--*/
    RUN proc_screen. /*Lukkana M. A55-0209 06/07/2012*/
    MESSAGE "Process Data & Matching Chassis Completed..." VIEW-AS ALERT-BOX INFORMATION.
    /***--- Disp Browse ---***/
    OPEN QUERY br_input FOR EACH aycldeto2_fil WHERE
                                 aycldeto2_fil.bchyr     =  nv_bchyr   AND
                                 aycldeto2_fil.bchno     =  nv_bchno   AND
                                 aycldeto2_fil.bchcnt    =  nv_bchcnt  NO-LOCK
                        BY aycldeto2_fil.rseqno .      /*Lukkana M. A53-0161 26/04/2010*/
        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit WGWAYCL1
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file WGWAYCL1
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE    "Choose Data File to Input ..."
 
        FILTERS  "Text Files (*.txt)"      "*.txt",
                 "CSV (Comma Delimiter)"   "*.csv",
                 "All files "   "*.*"
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
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         
         DISP fi_filename fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
    
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_findinput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_findinput WGWAYCL1
ON CHOOSE OF bu_findinput IN FRAME fr_main /* ...... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/
    SYSTEM-DIALOG GET-FILE cvData
        TITLE    "Choose Data File to Input ..."
        
        FILTERS  "Text Files (*.txt)"      "*.txt", 
                 /*"CSV (Comma Delimiter)"   "*.csv",*/
         "Text Files (*.csv)" "*.csv",
        "All files "   "*.*"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        ASSIGN 
            no_add =    STRING(MONTH(TODAY),"99")    + 
                        STRING(DAY(TODAY),"99")      + 
                        SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                        SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        ASSIGN  fi_inputconv  = cvData.
        IF ra_outfiletyp = 1 THEN
            ASSIGN fi_outputconv = IF index(fi_inputconv,".txt") <> 0 THEN SUBSTR(fi_inputconv,1,index(fi_inputconv,".txt") - 1 ) + "_exp.csv" 
                                   ELSE fi_inputconv +  "_exp.csv" .
        ELSE IF ra_outfiletyp = 2 THEN
            ASSIGN fi_outputconv = IF index(fi_inputconv,"_exp.csv") <> 0 THEN SUBSTR(fi_inputconv,1,index(fi_inputconv,"_exp.csv") - 1 ) + "_exp2.csv" 
                ELSE fi_inputconv +  "_exp2.csv" .
        ELSE DO:  
            ASSIGN fi_outputconv = IF index(fi_inputconv,".csv") <> 0 THEN SUBSTR(fi_inputconv,1,index(fi_inputconv,".csv") - 1 ) + "_mat.txt" 
                                   ELSE fi_inputconv +  "_mat.txt".

        END.

        DISP fi_inputconv fi_outputconv  WITH FRAME fr_main . 
        APPLY "Entry" TO fi_outputconv .
        RETURN NO-APPLY.
      END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 WGWAYCL1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent WGWAYCL1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn WGWAYCL1
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


&Scoped-define SELF-NAME bu_okconv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_okconv WGWAYCL1
ON CHOOSE OF bu_okconv IN FRAME fr_main /* CONVERT */
DO:
    DEF VAR n_cnt AS INTE.
    IF ra_outfiletyp = 1  THEN DO:        /*Export file text to excel */
        IF fi_inputconv = "" THEN DO:
            MESSAGE "Plese Input file ...!!!" VIEW-AS ALERT-BOX ERROR.
            APPLY "Entry" TO fi_inputconv.
        END.
        ELSE DO:
            FOR EACH tgenerage:
                DELETE tgenerage.
            END.
            INPUT STREAM nfile FROM VALUE(fi_inputconv).
            REPEAT:
                CREATE tgenerage.
                IMPORT STREAM nfile DELIMITER "|" tgenerage.
                RELEASE tgenerage.
                n_cnt = n_cnt + 1. 
            END.
            INPUT STREAM nfile CLOSE.
            FIND FIRST tgenerage NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL tgenerage THEN DO:
                MESSAGE "ไม่พบข้อมูลที่จะทำการ Process " VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
            END.
            ELSE DO:
                fi_impcnt = n_cnt - 2.
                DISP fi_impcnt WITH FRAME fr_main.
            END.
            RUN proc_outputexcel.
        END.
    END.
    ELSE IF   ra_outfiletyp = 2 THEN DO:  /*match file si ,premium ,netprm */
        DEF VAR nv_prem             AS DECI INIT 0.
        DEF VAR nv_rstp_t           AS DECI INIT 0.
        DEF VAR nv_rtax_t           AS DECI INIT 0.
        DEF VAR nv_si               AS CHAR.
        FOR EACH tgenerage.
            DELETE tgenerage.
        END.
        INPUT STREAM nfile FROM VALUE(fi_inputconv).
        REPEAT:
            CREATE tgenerage.
            IMPORT STREAM nfile DELIMITER "|" tgenerage.
            RELEASE tgenerage.
        END.
        INPUT STREAM nfile CLOSE.
        FIND FIRST tgenerage NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL tgenerage THEN DO:
            MESSAGE "ไม่พบข้อมูลที่จะทำการ Process " VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        FOR EACH certmp USE-INDEX certmp01
            WHERE Certmp.usrid = nv_useid  
            AND Certmp.entdat  = nv_entdat 
            AND Certmp.enttim  = nv_enttime      
            AND Certmp.Progid  = nv_progid2 : 
            DELETE certmp.
        END.
        FOR EACH tgenerage WHERE tgenerage.policy <> "" .
            ASSIGN nv_prem    = 0
                   nv_rstp_t  = 0
                   nv_rtax_t  = 0
                   nv_si      = "0.00"  .
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103                 WHERE
                sicuw.uwm301.policy             = trim(tgenerage.policy)    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:  
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001     WHERE 
                    sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                    sicuw.uwm100.endcnt = sicuw.uwm301.endcnt AND 
                    sicuw.uwm100.releas = YES                 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm100 THEN DO:
                    FOR EACH sicuw.uwm100 USE-INDEX uwm10091       WHERE 
                        sicuw.uwm100.releas = YES                  AND
                        sicuw.uwm100.policy = sicuw.uwm301.policy  NO-LOCK.
                        ASSIGN 
                            nv_prem   = nv_prem   + sicuw.uwm100.prem_t
                            nv_rstp_t = nv_rstp_t + sicuw.uwm100.rstp_t
                            nv_rtax_t = nv_rtax_t + sicuw.uwm100.rtax_t.
                    END.
                    ASSIGN                                             
                        tgenerage.prem    = STRING(nv_prem,">>>,>>>,>>9.99")
                        tgenerage.premtot = STRING(nv_prem + 
                                                   nv_rstp_t + 
                                                   nv_rtax_t,">>>,>>>,>>9.99").
                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001  WHERE 
                        sicuw.uwm130.policy = sicuw.uwm301.policy AND
                        sicuw.uwm130.rencnt = sicuw.uwm301.rencnt AND
                        sicuw.uwm130.endcnt = sicuw.uwm301.endcnt AND
                        sicuw.uwm130.riskgp = sicuw.uwm301.riskgp AND
                        sicuw.uwm130.riskno = sicuw.uwm301.riskno AND
                        sicuw.uwm130.itemno = sicuw.uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm130 THEN DO:
                        IF      sicuw.uwm301.covcod = "1"   THEN nv_si = string(sicuw.uwm130.uom6_v,">>>,>>>,>>9.99").
                        ELSE IF sicuw.uwm301.covcod = "2"   THEN nv_si = string(sicuw.uwm130.uom7_v,">>>,>>>,>>9.99").
                        /*ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = string(sicuw.uwm130.uom6_v,">>>,>>>,>>9.99").*/     /* comment by Sarinya A59-0436 */ 
                        ELSE IF sicuw.uwm301.covcod = "2.1" THEN nv_si = string(sicuw.uwm130.uom7_v,">>>,>>>,>>9.99").         /* add by Sarinya A59-0436 */     
                        ELSE IF sicuw.uwm301.covcod = "2.2" THEN nv_si = string(sicuw.uwm130.uom7_v,">>>,>>>,>>9.99").         /* add by Sarinya A59-0436 */     
                        ELSE DO: 
                            /*A57-0291*/
                            IF      sicuw.uwm130.uom6_v <> 0 THEN nv_si = string(sicuw.uwm130.uom6_v,">>>,>>>,>>9.99").
                            ELSE IF sicuw.uwm130.uom7_v <> 0 THEN nv_si = string(sicuw.uwm130.uom7_v,">>>,>>>,>>9.99").
                            ELSE nv_si = "0.00".  /*A57-0291*/
                        END.
                        tgenerage.si       = TRIM(STRING(nv_si)).
                    END.
                END.
            END. 
        END.
        FIND LAST tgenerage WHERE tgenerage.rectyp = "T" NO-LOCK NO-ERROR .  
        IF AVAIL tgenerage  THEN
            ASSIGN 
            tgenerage.rseqno    = IF tgenerage.rseqno   <> ""  THEN string(deci(tgenerage.rseqno),"99999")          ELSE tgenerage.rseqno  
            /* add by : A65-0115 */
            tgenerage.prodcode  = IF tgenerage.prodcode <> ""  THEN string(deci(tgenerage.prodcode),"99999")        ELSE tgenerage.prodcode   
            tgenerage.brncode   = IF tgenerage.brncode  <> ""  THEN string(deci(tgenerage.brncode),"9999999999999") ELSE tgenerage.brncode    
            tgenerage.contno    = IF tgenerage.contno   <> ""  THEN string(deci(tgenerage.contno ),"9999999999999") ELSE tgenerage.contno   .
            /* end : A65-0115 */ 
            /*comment by : Ranu I. A65-0115 ..
            tgenerage.compno   = IF tgenerage.compno   <> ""  THEN string(deci(tgenerage.compno),"99999")           ELSE tgenerage.compno    
            tgenerage.brncode  = IF tgenerage.brncode  <> ""  THEN string(deci(tgenerage.brncode),"9999999999999")  ELSE tgenerage.brncode   
            tgenerage.prodcode = IF tgenerage.prodcode <> ""  THEN string(deci(tgenerage.prodcode),"9999999999999") ELSE tgenerage.prodcode.
            ... end A65-0115 */
        RUN proc_outputexcel_2.
    END.
    ELSE DO:  /* match file send to aycal */
        FOR EACH tgenerage.
            DELETE tgenerage.
        END.
        INPUT STREAM nfile FROM VALUE(fi_inputconv).
        REPEAT:
            CREATE tgenerage.
            IMPORT STREAM nfile DELIMITER "|" tgenerage.
            RELEASE tgenerage.
        END.
        INPUT STREAM nfile CLOSE.

        FIND FIRST tgenerage NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL tgenerage THEN DO:
            MESSAGE "ไม่พบข้อมูลที่จะทำการ Process " VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF INDEX(fi_outputconv,".txt") = 0  THEN 
            fi_outputconv = fi_outputconv + ".txt".
        DISP fi_outputconv WITH FRAM fr_main.
        FOR EACH certmp USE-INDEX certmp01
            WHERE Certmp.usrid = nv_useid  
            AND Certmp.entdat  = nv_entdat 
            AND Certmp.enttim  = nv_enttime      
            AND Certmp.Progid  = nv_progid2 : 
            DELETE certmp.
        END.
        RUN  pdcreate_con. 
        /*pdf*/
        n_printer       = "pdfcreator".
        RB-PRINTER-NAME = n_printer.
        RUN pd_guaran_print.
        /*pdf*/
        FOR EACH certmp USE-INDEX certmp01
            WHERE Certmp.Progid  = nv_progid2    
            AND   Certmp.usrid   = nv_useid      
            AND   Certmp.entdat  = nv_entdat     
            AND   Certmp.enttim  = nv_enttime :
            DELETE certmp.
        END.
        FOR EACH tgenerage NO-LOCK .  
            ASSIGN 
                tgenerage.rseqno   = IF tgenerage.rseqno   <> ""  THEN string(DECI(tgenerage.rseqno),"99999")                   ELSE tgenerage.rseqno  
                tgenerage.si       = IF tgenerage.si       <> ""  THEN       TRIM(REPLACE(string((deci(tgenerage.si)),">>>>>>>>>>>>9.99"),".",""))   ELSE "000000000000000"      
                tgenerage.prem     = IF tgenerage.prem     <> ""  THEN     TRIM(REPLACE(string((deci(tgenerage.prem)),">>>>>>>>>>>>9.99"),".",""))   ELSE "000000000000000"      
                tgenerage.premtot  = IF tgenerage.premtot  <> ""  THEN  TRIM(REPLACE(string((deci(tgenerage.premtot)),">>>>>>>>>>>>9.99"),".",""))   ELSE "000000000000000"      
                tgenerage.prem_cus = IF tgenerage.prem_cus <> ""  THEN TRIM(REPLACE(string((deci(tgenerage.prem_cus)),">>>>>>>>>>>>9.99"),".",""))   ELSE "000000000000000"   .     
        END.
        FIND LAST tgenerage WHERE tgenerage.rectyp = "T" NO-LOCK NO-ERROR .  
        IF AVAIL tgenerage  THEN
            ASSIGN 
            tgenerage.rseqno   = IF tgenerage.rseqno   <> ""  THEN string(deci(tgenerage.rseqno),"99999")           ELSE tgenerage.rseqno    
             /* add by : A65-0115 */
            tgenerage.prodcode  = IF tgenerage.prodcode <> ""  THEN string(deci(tgenerage.prodcode),"99999")        ELSE tgenerage.prodcode   
            tgenerage.brncode   = IF tgenerage.brncode  <> ""  THEN string(deci(tgenerage.brncode),"9999999999999") ELSE tgenerage.brncode    
            tgenerage.contno    = IF tgenerage.contno   <> ""  THEN string(deci(tgenerage.contno ),"9999999999999") ELSE tgenerage.contno   .
            /* end : A65-0115 */ 
            /*comment by : Ranu I. A65-0115 ..
            tgenerage.compno   = IF tgenerage.compno   <> ""  THEN string(deci(tgenerage.compno),"99999")           ELSE tgenerage.compno    
            tgenerage.brncode  = IF tgenerage.brncode  <> ""  THEN string(deci(tgenerage.brncode),"9999999999999")  ELSE tgenerage.brncode   
            tgenerage.prodcode = IF tgenerage.prodcode <> ""  THEN string(deci(tgenerage.prodcode),"9999999999999") ELSE tgenerage.prodcode.
            ... end A65-0115 */
        RUN proc_output_txt.
    END.
    /*DEF VAR outfile      AS CHAR.
    DEF VAR logAns       AS LOGI INIT No.
    DEF VAR n_rseqno     AS INTE .   
    DEF VAR n_rseqno1    AS CHAR .   
    DEF VAR n_totpolno   AS INTE .   
    DEF VAR n_totpolno1  AS CHAR . 
    ASSIGN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    n_rseqno    = 0
    n_rseqno1   = "" 
    n_totpolno  = 0
    n_totpolno1 = "".*/
    MESSAGE "Export Data  Completed..." VIEW-AS ALERT-BOX INFORMATION.
    APPLY "Entry" TO fi_inputconv.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_out
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_out WGWAYCL1
ON CHOOSE OF bu_out IN FRAME fr_main /* OUTPUT */
DO:
    /*kridtiya i. A59-0359
    DEF VAR outfile      AS CHAR.
    DEF VAR logAns       AS LOGI INIT No.
    DEF VAR n_rseqno     AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_rseqno1    AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_totpolno   AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_totpolno1  AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/ A59-0359*/
    /** comment by Nipawadee R. 30/08/2010/ to A53-0239
    FOR EACH certmp WHERE certmp.progid  = "WGWAYCL1" .
        DELETE certmp.
    END.*/

    /*Lukkana M. A53-0161 22/04/2010*/
    ASSIGN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
        n_rseqno    = 0
        n_rseqno1   = "" 
        n_totpolno  = 0
        n_totpolno1 = ""
        nv_bchyr    = INPUT fi_bchyr         /*A59-0359*/
        nv_bchprev  = INPUT fi_bchprev       /*A59-0359*/
        nv_bchcnt   = INPUT fi_bchcnt   .    /*A59-0359*/
       
    /*Lukkana M. A53-0161 22/04/2010*/

    DISABLE ALL 
        EXCEPT fi_bchprev fi_bchyr fi_bchcnt
               br_input bu_out bu_exit 
    WITH FRAM fr_main.

    ENABLE fi_bchcnt 
           TO_textaycl to_guaranexcel to_guaranpdf WITH FRAME fr_main. /*Lukkana M. A55-0175 08/06/2012*/

    IF INPUT TO_guaranpdf = NO THEN DISABLE cbPrtList WITH FRAME fr_main.  /*Lukkana M. A55-0175 08/06/2012*/
    ELSE ENABLE cbPrtList WITH FRAME fr_main.  /*Lukkana M. A55-0175 08/06/2012*/

    nv_bchyr = fi_bchyr.
   
    FOR EACH certmp USE-INDEX certmp01
                    WHERE Certmp.usrid = nv_useid  
                    AND Certmp.entdat  = nv_entdat 
                    AND Certmp.enttim  = nv_enttime      
                    AND Certmp.Progid  = nv_progid2 : 
        DELETE certmp.

    END.

    IF INPUT fi_bchyr  <= 0   OR
       INPUT fi_bchprev = ""  OR
       INPUT fi_bchcnt <= 0   THEN DO:

        MESSAGE "กรุณาระบุข้อมูล Batch no. ที่ต้องการ...!" VIEW-AS ALERT-BOX WARNING.

    END.
    ELSE DO: 

        IF fi_bchprev <> ""  THEN DO:
            IF LENGTH(fi_bchprev) <> 16 THEN DO:
                 MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                         "Please Check Batch No. Again             " view-as alert-box.
                 APPLY "entry" TO fi_bchprev.
                 RETURN NO-APPLY.
            END.
        END. 
        IF fi_bchyr <= 0 THEN DO:
            MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
            APPLY "entry" to fi_bchyr.
            RETURN NO-APPLY.
        END.

        /*-- Lukkana M. A55-0175 07/06/2012
        IF fi_usrcnt <= 0  THEN DO:
            MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
            APPLY "entry" to fi_usrcnt.
            RETURN NO-APPLY.
        END.
        
        IF INPUT rs_type = 1 THEN DO: /*AYAL Text File*/

        outfile = "C:\TEMP\" + fi_bchprev + STRING(fi_bchcnt,"99") + ".txt" . 
        
        MESSAGE "OUTPUT TEXT File (AYCL) " UPDATE logAns
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm Output Text file".

         IF logAns THEN DO:

            OUTPUT TO VALUE(outfile).

            /**** Head ****/
            FIND FIRST ayclhead_fil WHERE 
                       ayclhead_fil.bchyr  = fi_bchyr AND
                       ayclhead_fil.bchno  = fi_bchprev AND
                       ayclhead_fil.bchcnt = fi_bchcnt AND
                       ayclhead_fil.rectyp = "H" NO-LOCK NO-ERROR.
            IF AVAIL ayclhead_fil THEN DO:
                
                /*EXPORT Lukkana M. A52-0136 22/06/2009*/
                PUT UNFORMATTED /*Lukkana M. A52-0136 22/06/2009*/
                    TRIM(ayclhead_fil.rectyp) + "|" +
                    TRIM(ayclhead_fil.fseqno) + "|" +
                    TRIM(ayclhead_fil.compno) + "|" +
                    TRIM(ayclhead_fil.compins) + "|" +
                    TRIM(ayclhead_fil.asofdat) + "" SKIP.
            END.                                          
            
            /**** Detail ****/
            FOR EACH aycldeto_fil WHERE
                     aycldeto_fil.bchyr  = fi_bchyr AND
                     aycldeto_fil.bchno  = fi_bchprev AND
                     aycldeto_fil.bchcnt = fi_bchcnt 
            NO-LOCK:

            n_rseqno    = INTE(aycldeto_fil.rseqno). /*Lukkana M. A53-0161 22/04/2010*/
            n_totpolno  = n_totpolno + 1.  /*Lukkana M. A53-0161 22/04/2010*/
            
            /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
            PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                TRIM(aycldeto_fil.rectyp)   + "|" +
                TRIM(aycldeto_fil.rseqno)   + "|" +
                TRIM(aycldeto_fil.compno)   + "|" +
                TRIM(aycldeto_fil.brncode)  + "|" +
                TRIM(aycldeto_fil.prodcode) + "|" +
                TRIM(aycldeto_fil.contno)   + "|" +
                TRIM(aycldeto_fil.finint)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.ntitle)   + "|" +
                TRIM(aycldeto_fil.fname)    + "|" +
                TRIM(aycldeto_fil.lname)    + "|" +
                TRIM(aycldeto_fil.addr1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.addr2)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.addr3)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.postcd)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.flag)     + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.brand)    + "|" +
                TRIM(aycldeto_fil.model)    + "|" +
                TRIM(aycldeto_fil.ccolor)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.vehreg)   + "|" +
                TRIM(aycldeto_fil.province) + "|" +
                TRIM(aycldeto_fil.yrmanu)   + "|" +
                TRIM(aycldeto_fil.engine)   + "|" +
                TRIM(aycldeto_fil.cha_no)   + "|" +
                TRIM(aycldeto_fil.eng_no)   + "|" +
                TRIM(aycldeto_fil.acno1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.covcod)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.compins)  + "|" +
                TRIM(aycldeto_fil.policy)   + "|" +
                TRIM(aycldeto_fil.comdat)   + "|" +
                TRIM(aycldeto_fil.expdat)   + "|" +
                TRIM(aycldeto_fil.si)       + "|" +
                TRIM(aycldeto_fil.prem)     + "|" +
                TRIM(aycldeto_fil.premtot)  + "|" +
                TRIM(aycldeto_fil.prem_cus) + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.yrins)    + "|" +
                TRIM(aycldeto_fil.notify)   + "|" +
                TRIM(aycldeto_fil.jobcode)  + "|" +
                TRIM(aycldeto_fil.firstdat)  SKIP.
            END.

            /**** Total ****/
            FIND FIRST ayclhead_fil WHERE 
                       ayclhead_fil.bchyr  = fi_bchyr AND
                       ayclhead_fil.bchno  = fi_bchprev AND
                       ayclhead_fil.bchcnt = fi_bchcnt AND
                       ayclhead_fil.rectyp = "T" NO-LOCK NO-ERROR.
            IF AVAIL ayclhead_fil THEN DO:
                n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
                n_totpolno1 =  STRING(n_totpolno,"99999").
            
                /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
                PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                    TRIM(ayclhead_fil.rectyp)   + "|" +
                    /*----
                    TRIM(ayclhead_fil.lseqno)   + "|" + 
                    TRIM(ayclhead_fil.totpolno) + "|" +
                    Lukkana M. A53-0161 22/04/2010--*/
                    TRIM(n_rseqno1)             + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                    TRIM(n_totpolno1)           + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                    TRIM(ayclhead_fil.totpremt) + "|" +
                    TRIM(ayclhead_fil.chkdigit) + "" SKIP.
            END.

            OUTPUT CLOSE.

            MESSAGE "OUTPUT TEXT FILE Completed ..." SKIP
                    "To file : " outfile VIEW-AS ALERT-BOX INFORMATION.
         END. /*if 1. */

        END. 
        ELSE IF INPUT rs_type = 2 THEN DO:  /*Guarantee  Nipawadee 16/07/2010  A53-0211*/

            RUN wgw\wgwe01   (INPUT-OUTPUT n_destination,
                              INPUT-OUTPUT n_printer,
                              INPUT-OUTPUT n_filename,
                              INPUT-OUTPUT n_print).

            RUN pd_create-certmp. /*Create ค่าลง table certmp*/

            MESSAGE n_printer VIEW-AS ALERT-BOX.
            RB-PRINTER-NAME  =  n_printer.

            IF n_filename <> "" THEN DO: /*File*/
                RUN pd_guaran_file.
                RETURN NO-APPLY.
            END.
            ELSE IF n_printer <> "" OR n_destination <> "" THEN DO:  /*Printer*/
                RUN pd_guaran_print.
            END.

        END.
        Lukkana M. A55-0175 07/06/2012--*/
        
        /*--Lukkana M. A55-0175 07/06/2012--*/

        IF INPUT TO_textaycl    <> YES  AND 
           INPUT TO_guaranexcel <> YES  AND 
           INPUT TO_guaranpdf   <> YES  THEN DO:

           MESSAGE "กรุณาระบุประเภท" SKIP 
                   "Output Report Type ที่ต้องการ...!" VIEW-AS ALERT-BOX WARNING.
        END.

        /*RUN pd_create-certmp.    /*Create ค่าลง table certmp*/*/ /*add kridtiya i. A59-359*/
        RUN pd_create-certmp2.                                     /*add kridtiya i. A59-359*/
        
        ASSIGN  outfile  = ""
                outfile1 = "".
        
        IF INPUT TO_textaycl = YES THEN DO: /*AYAL Text File*/

            outfile = "C:\TEMP\" + INPUT fi_bchprev + STRING(fi_bchcnt,"99") + ".txt" . 
            
            /*MESSAGE "OUTPUT TEXT File (AYCL) " UPDATE logAns
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "Confirm Output Text file".
    
            IF logAns THEN DO:*/
        
                OUTPUT TO VALUE(outfile) NO-ECHO.
        
                /**** Head ****/
                /*comment by kridtiya i. .............A59-0359...

                FIND FIRST ayclhead_fil WHERE 
                           ayclhead_fil.bchyr  = INPUT fi_bchyr AND
                           ayclhead_fil.bchno  = INPUT fi_bchprev AND
                           ayclhead_fil.bchcnt = INPUT fi_bchcnt AND
                           ayclhead_fil.rectyp = "H" NO-LOCK NO-ERROR.
                IF AVAIL ayclhead_fil THEN DO:
                    
                    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
                    PUT UNFORMATTED /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(ayclhead_fil.rectyp) + "|" +
                        TRIM(ayclhead_fil.fseqno) + "|" +
                        TRIM(ayclhead_fil.compno) + "|" +
                        TRIM(ayclhead_fil.compins) + "|" +
                        TRIM(ayclhead_fil.asofdat) + "" SKIP.
                END.                                          
                
                /**** Detail ****/
                FOR EACH aycldeto_fil WHERE
                         aycldeto_fil.bchyr  = INPUT fi_bchyr   AND
                         aycldeto_fil.bchno  = INPUT fi_bchprev AND
                         aycldeto_fil.bchcnt = INPUT fi_bchcnt  NO-LOCK:

                    n_rseqno    = INTE(aycldeto_fil.rseqno). /*Lukkana M. A53-0161 22/04/2010*/
                    n_totpolno  = n_totpolno + 1.  /*Lukkana M. A53-0161 22/04/2010*/
                
                    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
                    PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(aycldeto_fil.rectyp)   + "|" +
                        TRIM(aycldeto_fil.rseqno)   + "|" +
                        TRIM(aycldeto_fil.compno)   + "|" +
                        TRIM(aycldeto_fil.brncode)  + "|" +
                        TRIM(aycldeto_fil.prodcode) + "|" +
                        TRIM(aycldeto_fil.contno)   + "|" +
                        TRIM(aycldeto_fil.finint)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.ntitle)   + "|" +
                        TRIM(aycldeto_fil.fname)    + "|" +
                        TRIM(aycldeto_fil.lname)    + "|" +
                        TRIM(aycldeto_fil.addr1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.addr2)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.addr3)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.postcd)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.flag)     + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.brand)    + "|" +
                        TRIM(aycldeto_fil.model)    + "|" +
                        TRIM(aycldeto_fil.ccolor)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.vehreg)   + "|" +
                        TRIM(aycldeto_fil.province) + "|" +
                        TRIM(aycldeto_fil.yrmanu)   + "|" +
                        TRIM(aycldeto_fil.engine)   + "|" +
                        TRIM(aycldeto_fil.cha_no)   + "|" +
                        TRIM(aycldeto_fil.eng_no)   + "|" +
                        TRIM(aycldeto_fil.acno1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.covcod)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.compins)  + "|" +
                        TRIM(aycldeto_fil.policy)   + "|" +
                        TRIM(aycldeto_fil.comdat)   + "|" +
                        TRIM(aycldeto_fil.expdat)   + "|" +
                        TRIM(aycldeto_fil.si)       + "|" +
                        TRIM(aycldeto_fil.prem)     + "|" +
                        TRIM(aycldeto_fil.premtot)  + "|" +
                        TRIM(aycldeto_fil.prem_cus) + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.yrins)    + "|" +
                        TRIM(aycldeto_fil.notify)   + "|" +
                        TRIM(aycldeto_fil.jobcode)  + "|" +
                        TRIM(aycldeto_fil.firstdat)  SKIP.
                END. /*FOR EACH aycldeto_fil*/
        
                /**** Total ****/
                FIND FIRST ayclhead_fil WHERE 
                           ayclhead_fil.bchyr  = INPUT fi_bchyr   AND
                           ayclhead_fil.bchno  = INPUT fi_bchprev AND
                           ayclhead_fil.bchcnt = INPUT fi_bchcnt  AND
                           ayclhead_fil.rectyp = "T"        NO-LOCK NO-ERROR.
                IF AVAIL ayclhead_fil THEN DO:
                    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
                    n_totpolno1 =  STRING(n_totpolno,"99999").
                
                    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
                    PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(ayclhead_fil.rectyp)   + "|" +
                        /*----
                        TRIM(ayclhead_fil.lseqno)   + "|" + 
                        TRIM(ayclhead_fil.totpolno) + "|" +
                        Lukkana M. A53-0161 22/04/2010--*/
                        TRIM(n_rseqno1)             + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                        TRIM(n_totpolno1)           + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                        TRIM(ayclhead_fil.totpremt) + "|" +
                        TRIM(ayclhead_fil.chkdigit) + "" SKIP.
                END. /*FIND FIRST ayclhead_fil*/
                END..comment by kridtiya i. .............A59-0359...*/
                RUN proc_outputfile.   /*A59-0359.*/
                OUTPUT CLOSE.
                /*add kridtiya i. A58-0121 excel*/
                outfile = "C:\TEMP\" + INPUT fi_bchprev + STRING(fi_bchcnt,"99") + "_excel.csv" . 
                OUTPUT TO VALUE(outfile) NO-ECHO.
                RUN proc_outputfile02. 
                OUTPUT CLOSE.
                /*add kridtiya i. A58-0121 excel*/
                /*--
                MESSAGE "OUTPUT TEXT FILE Completed ..." SKIP
                        "To file : " outfile VIEW-AS ALERT-BOX INFORMATION. --*/
            /*
            END. /*if 1. */
            */
        END. 
        IF INPUT TO_guaranexcel = YES THEN DO:  /*Guarantee  EXCEL*/
            RUN pd_guaran_file.
        END.
        IF INPUT TO_guaranpdf = YES THEN DO:  /*Guarantee PDF*/
            n_printer   = cbPrtList.
            RB-PRINTER-NAME = n_printer.
            RUN pd_guaran_print.
        END.

        IF outfile <> "" AND outfile1 <> "" THEN DO: /*เลือกทั้ง 2 ไฟล์*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "AYCAL Text File     :" outfile  SKIP
                    "Guarantee Excel     :" outfile1 SKIP 
                    "File Data not match :" outfile2 VIEW-AS ALERT-BOX INFORMATION.
        END.
        ELSE IF outfile <> "" AND outfile1 = "" THEN DO: /*เลือกเฉพาะ AYCAL Text file*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "AYCAL Text File :" outfile  VIEW-AS ALERT-BOX INFORMATION.
        END.
        ELSE IF outfile = "" AND outfile1 <> "" THEN DO: /*เลือกเฉพาะ Guarantee excel*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "Guarantee Excel     :" outfile1 SKIP 
                    "File Data not match :" outfile2 VIEW-AS ALERT-BOX INFORMATION.
        END.
        /*--Lukkana M. A55-0175 07/06/2012--*/
        
    END.

    /*--Add by Nipawadee R. to A53-0312---*/
    FOR EACH certmp USE-INDEX certmp01
                   WHERE Certmp.Progid  = nv_progid2    
                   AND   Certmp.usrid   = nv_useid      
                   AND   Certmp.entdat  = nv_entdat     
                   AND   Certmp.enttim  = nv_enttime :
    DELETE certmp.
    END. 
END.
/*End add by Nipawadee R. To A53-0312*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbPrtList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbPrtList WGWAYCL1
ON VALUE-CHANGED OF cbPrtList IN FRAME fr_main
DO:
  cbPrtList = INPUT cbPrtList .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent WGWAYCL1
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.

    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
             sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             MESSAGE "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX.
             Apply "Entry" To  fi_agent.
        END.
        ELSE DO:
            ASSIGN
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent).
        END.
    END.
    
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchcnt WGWAYCL1
ON LEAVE OF fi_bchcnt IN FRAME fr_main
DO:
    fi_bchcnt = INPUT fi_bchcnt.

    IF fi_bchcnt <= 0 THEN DO:
       MESSAGE "Batch Count Error...!!!".
       APPLY "entry" TO fi_bchcnt.
       RETURN NO-APPLY.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchprev WGWAYCL1
ON LEAVE OF fi_bchprev IN FRAME fr_main
DO:
    fi_bchprev = caps(INPUT fi_bchprev).
    
    IF fi_bchprev <> " "  THEN DO:
        IF LENGTH(fi_bchprev) <> 16 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_bchprev.
             
        END.
    END. 
    
    DISPLAY fi_bchprev WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr WGWAYCL1
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
    fi_bchyr = INPUT fi_bchyr.

    IF fi_bchyr <= 0 THEN DO:
       MESSAGE "Batch Year Error...!!!".
       APPLY "entry" TO fi_bchyr.
       RETURN NO-APPLY.
    END.

    nv_bchyr = fi_bchyr.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch WGWAYCL1
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    IF  Input fi_branch  =  ""  Then do:
         Message "กรุณาระบุ Branch Code ." View-as alert-box.
         Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
             sicsyac.xmm023.branch   =  Input  fi_branch NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" View-as alert-box.
            Apply "Entry"  To  fi_branch.
        END.
        
        fi_branch  =  CAPS(Input fi_branch) .
        fi_brndes  =  sicsyac.xmm023.bdes.
    End. 
    
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputconv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputconv WGWAYCL1
ON LEAVE OF fi_inputconv IN FRAME fr_main
DO:
  fi_inputconv  = INPUT fi_inputconv .
  DISP fi_inputconv WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outagent WGWAYCL1
ON LEAVE OF fi_outagent IN FRAME fr_main
DO:
  fi_outagent = INPUT fi_outagent.
  DISP fi_outagent WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outagentgrp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outagentgrp WGWAYCL1
ON LEAVE OF fi_outagentgrp IN FRAME fr_main
DO:
  fi_outagentgrp = INPUT fi_outagentgrp.
  DISP fi_outagentgrp WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputconv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputconv WGWAYCL1
ON LEAVE OF fi_outputconv IN FRAME fr_main
DO:
  fi_outputconv = INPUT fi_outputconv .
  DISP fi_outputconv WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer WGWAYCL1
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.

    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
             sicsyac.xmm600.acno  =  Input fi_producer  NO-LOCK NO-ERROR NO-WAIT.
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" View-as alert-box.
             Apply "Entry" To  fi_producer.
         END.
         ELSE DO:
             ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer).
         END.
    END.
    
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat WGWAYCL1
ON LEAVE OF fi_trndat IN FRAME fr_main
DO:
  fi_trndat  =  Input  fi_trndat.
  Disp  fi_trndat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_outfiletyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_outfiletyp WGWAYCL1
ON VALUE-CHANGED OF ra_outfiletyp IN FRAME fr_main
DO:
  ra_outfiletyp = INPUT ra_outfiletyp.
  DISP ra_outfiletyp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_producer WGWAYCL1
ON VALUE-CHANGED OF ra_producer IN FRAME fr_main
DO:
    ra_producer = INPUT ra_producer.
    DISP ra_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typtitle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typtitle WGWAYCL1
ON VALUE-CHANGED OF ra_typtitle IN FRAME fr_main
DO:
    ra_typtitle = INPUT ra_typtitle.
    DISP ra_typtitle WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_guaranexcel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_guaranexcel WGWAYCL1
ON VALUE-CHANGED OF to_guaranexcel IN FRAME fr_main /* Guarantee (Excel) */
DO:
  TO_guaranexcel =  INPUT TO_guaranexcel.
  DISP TO_guaranexcel WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_guaranpdf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_guaranpdf WGWAYCL1
ON VALUE-CHANGED OF to_guaranpdf IN FRAME fr_main /* Guarantee (Print) */
DO:
  TO_guaranpdf = INPUT TO_guaranpdf.
  DISP TO_guaranpdf WITH FRAME fr_main.

  IF TO_guaranpdf = YES THEN ENABLE cbPrtList WITH FRAME fr_main.
  ELSE DISABLE cbPrtList WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_textaycl
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_textaycl WGWAYCL1
ON VALUE-CHANGED OF to_textaycl IN FRAME fr_main /* AYCAL Text File */
DO:
  TO_textaycl = INPUT TO_textaycl.
  DISP TO_textaycl WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_input
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WGWAYCL1 


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
  gv_prgid = "WGWAYCL1".
  gv_prog  = "INPUT - OUTPUT TEXT FILE 'AYCAL'".
  fi_trndat = TODAY.
  DISP fi_trndat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (wgwaycl1:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
  fi_producer = ""
  fi_agent    = ""
  fi_bchyr  = YEAR(TODAY)
  ra_outfiletyp  = 1
  /*A53-0239*/    
     nv_progid2  = "wgwaycl1" 
     nv_useid    =  n_user
     nv_entdat   =  TODAY
     nv_enttime  =  STRING(TIME,"HH:MM:SS").
  /*A53-0239*/
  DISP ra_outfiletyp fi_producer fi_agent fi_bchyr WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (wgwaycl1:handle).  
  SESSION:DATA-ENTRY-RETURN  = Yes.

  APPLY "ENTRY" TO fi_trndat . /*Lukkana M. A52-0136 24/06/2009*/

  /*Lukkana M. A55-0175 07/06/2012*/
  ASSIGN
      TO_textaycl    = YES
      TO_guaranexcel = YES
      TO_guaranpdf   = YES .

  RUN pdGetPrtList.
  ENABLE cbPrtList WITH FRAME fr_main.
  DISP TO_textaycl TO_guaranexcel TO_guaranpdf  WITH FRAME fr_main.
  /*Lukkana M. A55-0175 07/06/2012*/

  /*Lukkana M. A55-0209 11/07/2012*/
  ASSIGN 
      fi_branch   = "M"
      fi_producer = "A0M0061"
      fi_agent    = "B300303"
      /*fi_outagent = "A0M0018,A0M0019,A0M0061,A0M1011"*/                                                                /*A63-00472*/
     /* fi_outagent = "A0M0018,A0M0019,A0M0061,A0M1011,B3MLAY0101,B3MLAY0102,B3MLAY0103,B3MLAY0104,B3MLAY0105,B3MLAY0106"  /*A63-00472*/*//*A65-0115*/
      fi_outagent = "B3MLAY0101,B3MLAY0102,B3MLAY0103,B3MLAY0104,B3MLAY0105,B3MLAY0106,B3MLAY0107,B3MLAY0108,A0MF29TLT0,B3M4410273" /*A65-0115*/
      ra_producer = 1
      /*fi_outagentgrp = "A0M0061"*/ /*A63-00472*/
      fi_outagentgrp = "B3MLAY0100"  /*A63-00472*/
      nv_outagent  = fi_outagent  
      ra_typtitle = 1                 /*A57-0062*/
      nv_outagent2 = fi_outagentgrp.
  DISP fi_branch fi_producer fi_agent fi_outagent  fi_outagentgrp ra_producer ra_typtitle  WITH FRAME fr_main.   /*A57-0062 add ra_typtitle*/
  /*Lukkana M. A55-0209 11/07/2012*/

  DISABLE fi_bchcnt WITH FRAME fr_main.

    fi_bchcnt = 1.
    DISP fi_bchcnt WITH FRAME fr_main.


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pdcreate WGWAYCL1 
PROCEDURE 00-pdcreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /* comment by : Ranu I. A65-0115 ..
    FOR EACH tgenerage WHERE rectyp <> "" NO-LOCK:

        IF tgenerage.rectyp = "H" THEN DO:
            
            /******** HEADER ********/
            /*/*A59-0359*/
            CREATE ayclhead_fil.
            ASSIGN
                ayclhead_fil.bchyr    =  nv_bchyr
                ayclhead_fil.bchno    =  nv_bchno
                ayclhead_fil.bchcnt   =  nv_bchcnt
                ayclhead_fil.rectyp   =  tgenerage.rectyp
                ayclhead_fil.fseqno   =  tgenerage.rseqno
                ayclhead_fil.compno   =  tgenerage.compno
                ayclhead_fil.compins  =  tgenerage.brncode
                ayclhead_fil.asofdat  =  tgenerage.prodcode.
            /*A59-0359*/*/
            /*A59-0359*/
            CREATE ayclhead2_fil.
            ASSIGN
                ayclhead2_fil.bchyr     =  nv_bchyr
                ayclhead2_fil.bchno     =  nv_bchno
                ayclhead2_fil.bchcnt    =  nv_bchcnt
                ayclhead2_fil.rectyp    =  tgenerage.rectyp
                ayclhead2_fil.fseqno    =  tgenerage.rseqno
                ayclhead2_fil.compno    =  tgenerage.prodcode  
                ayclhead2_fil.compins   =  tgenerage.brncode   
                ayclhead2_fil.asofdat   =  tgenerage.contno   
                ayclhead2_fil.developno =  tgenerage.ntitle  .
                /*
                ayclhead2_fil.compno    =  tgenerage.compno
                ayclhead2_fil.compins   =  tgenerage.brncode
                ayclhead2_fil.asofdat   =  tgenerage.prodcode
                ayclhead2_fil.developno =  tgenerage.contno */.  
            /*A59-0359*/

        END.
        ELSE IF tgenerage.rectyp = "T" THEN DO:
            
            /******** TOTAL ********/
            /*Comment by Kridtiya i. A59-0359...
            CREATE ayclhead_fil.
            ASSIGN
                ayclhead_fil.bchyr     =   nv_bchyr
                ayclhead_fil.bchno     =   nv_bchno
                ayclhead_fil.bchcnt    =   nv_bchcnt
                ayclhead_fil.rectyp    =   tgenerage.rectyp
                ayclhead_fil.lseqno    =   tgenerage.rseqno
                ayclhead_fil.totpolno  =   tgenerage.compno
                ayclhead_fil.totpremt  =   tgenerage.brncode
                ayclhead_fil.chkdigit  =   tgenerage.prodcode.    
            end comment by Kridtiya i. A59-0359*/
            /*A58-0121*/
            CREATE ayclhead2_fil.
            ASSIGN
                ayclhead2_fil.bchyr     =   nv_bchyr
                ayclhead2_fil.bchno     =   nv_bchno
                ayclhead2_fil.bchcnt    =   nv_bchcnt
                ayclhead2_fil.rectyp    =   tgenerage.rectyp
                ayclhead2_fil.lseqno    =   tgenerage.rseqno
                ayclhead2_fil.totpolno  =   tgenerage.compno
                ayclhead2_fil.totpremt  =   tgenerage.brncode
                ayclhead2_fil.chkdigit  =   tgenerage.prodcode 
                ayclhead2_fil.developno =   tgenerage.contno  . 
            /*A58-0121*/
        END.
        ELSE DO:  /* tgenerage.rectyp = "D" or Other */
            /*comment by kridtiya i. A59-0359...
            CREATE aycldeti_fil.
            ASSIGN
                 aycldeti_fil.bchyr     =  nv_bchyr 
                 aycldeti_fil.bchno     =  nv_bchno 
                 aycldeti_fil.bchcnt    =  nv_bchcnt
                 aycldeti_fil.rectyp    =  tgenerage.rectyp   
                 aycldeti_fil.rseqno    =  tgenerage.rseqno   
                 aycldeti_fil.compno    =  tgenerage.compno   
                 aycldeti_fil.brncode   =  tgenerage.brncode  
                 aycldeti_fil.prodcode  =  tgenerage.prodcode 
                 aycldeti_fil.contno    =  tgenerage.contno
                 aycldeti_fil.finint    =  tgenerage.finint /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.ntitle    =  tgenerage.ntitle   
                 aycldeti_fil.fname     =  tgenerage.fname    
                 aycldeti_fil.lname     =  tgenerage.lname 
                 aycldeti_fil.addr1     =  tgenerage.addr1  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.addr2     =  tgenerage.addr2  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.addr3     =  tgenerage.addr3  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.postcd    =  tgenerage.postcd /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.flag      =  tgenerage.flag   /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.brand     =  tgenerage.brand    
                 aycldeti_fil.model     =  tgenerage.model
                 aycldeti_fil.ccolor    =  tgenerage.ccolor /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.vehreg    =  tgenerage.vehreg   
                 aycldeti_fil.province  =  tgenerage.province 
                 aycldeti_fil.yrmanu    =  tgenerage.yrmanu   
                 aycldeti_fil.engine    =  tgenerage.engine   
                 aycldeti_fil.cha_no    =  tgenerage.cha_no   
                 aycldeti_fil.eng_no    =  tgenerage.eng_no
                 aycldeti_fil.acno1     =  tgenerage.acno1  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.covcod    =  tgenerage.covcod /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.compins   =  tgenerage.compins  
                 aycldeti_fil.policy    =  tgenerage.policy   
                 aycldeti_fil.comdat    =  tgenerage.comdat   
                 aycldeti_fil.expdat    =  tgenerage.expdat   
                 aycldeti_fil.si        =  tgenerage.si       
                 aycldeti_fil.prem      =  tgenerage.prem     
                 aycldeti_fil.premtot   =  tgenerage.premtot 
                 aycldeti_fil.prem_cus  =  tgenerage.prem_cus /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeti_fil.yrins     =  tgenerage.yrins    
                 aycldeti_fil.notify    =  tgenerage.notify   
                 aycldeti_fil.jobcode   =  tgenerage.jobcode  
                 aycldeti_fil.firstdat  =  tgenerage.firstdat .
            CREATE aycldeto_fil.
            ASSIGN
                 aycldeto_fil.bchyr     =  nv_bchyr 
                 aycldeto_fil.bchno     =  nv_bchno 
                 aycldeto_fil.bchcnt    =  nv_bchcnt
                 aycldeto_fil.rectyp    =  tgenerage.rectyp   
                 aycldeto_fil.rseqno    =  tgenerage.rseqno   
                 aycldeto_fil.compno    =  tgenerage.compno   
                 aycldeto_fil.brncode   =  tgenerage.brncode  
                 aycldeto_fil.prodcode  =  tgenerage.prodcode 
                 aycldeto_fil.contno    =  tgenerage.contno 
                 aycldeto_fil.finint    =  tgenerage.finint /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.ntitle    =  tgenerage.ntitle   
                 aycldeto_fil.fname     =  tgenerage.fname    
                 aycldeto_fil.lname     =  tgenerage.lname
                 aycldeto_fil.addr1     =  tgenerage.addr1  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.addr2     =  tgenerage.addr2  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.addr3     =  tgenerage.addr3  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.postcd    =  tgenerage.postcd /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.flag      =  tgenerage.flag   /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.brand     =  tgenerage.brand    
                 aycldeto_fil.model     =  tgenerage.model 
                 aycldeto_fil.ccolor    =  tgenerage.ccolor /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.vehreg    =  tgenerage.vehreg   
                 aycldeto_fil.province  =  tgenerage.province 
                 aycldeto_fil.yrmanu    =  tgenerage.yrmanu   
                 aycldeto_fil.engine    =  tgenerage.engine   
                 aycldeto_fil.cha_no    =  tgenerage.cha_no   
                 aycldeto_fil.eng_no    =  tgenerage.eng_no
                 aycldeto_fil.acno1     =  tgenerage.acno1  /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.covcod    =  tgenerage.covcod /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.compins   =  tgenerage.compins  
                 aycldeto_fil.policy    =  tgenerage.policy   
                 aycldeto_fil.comdat    =  tgenerage.comdat   
                 aycldeto_fil.expdat    =  tgenerage.expdat   
                 aycldeto_fil.si        =  tgenerage.si       
                 aycldeto_fil.prem      =  tgenerage.prem     
                 aycldeto_fil.premtot   =  tgenerage.premtot
                 aycldeto_fil.prem_cus  =  tgenerage.prem_cus /*Lukkana M. A55-0175 17/05/2012*/
                 aycldeto_fil.yrins     =  tgenerage.yrins    
                 aycldeto_fil.notify    =  tgenerage.notify   
                 aycldeto_fil.jobcode   =  tgenerage.jobcode  
                 aycldeto_fil.firstdat  =  tgenerage.firstdat .
               END..Comment BY Kridtiya i. A59-0359 ....*/
            /*Add kridtiya i. A59-0359 */
            CREATE aycldeti2_fil.
            ASSIGN
                aycldeti2_fil.bchyr     =  nv_bchyr 
                aycldeti2_fil.bchno     =  nv_bchno 
                aycldeti2_fil.bchcnt    =  nv_bchcnt
                aycldeti2_fil.rectyp    =  tgenerage.rectyp   
                aycldeti2_fil.rseqno    =  tgenerage.rseqno   
                aycldeti2_fil.compno    =  tgenerage.compno   
                aycldeti2_fil.brncode   =  tgenerage.brncode  
                aycldeti2_fil.prodcode  =  tgenerage.prodcode 
                aycldeti2_fil.contno    =  tgenerage.contno
                /*aycldeti2_fil.finint    =  tgenerage.finint */
                aycldeti2_fil.ntitle    =  tgenerage.ntitle   
                aycldeti2_fil.fname     =  tgenerage.fname    
                aycldeti2_fil.lname     =  tgenerage.lname 
                /*aycldeti2_fil.addr1     =  tgenerage.addr1 
                aycldeti2_fil.addr2     =  tgenerage.addr2 
                aycldeti2_fil.addr3     =  tgenerage.addr3 
                aycldeti2_fil.postcd    =  tgenerage.postcd
                aycldeti2_fil.flag      =  tgenerage.flag  */
                aycldeti2_fil.brand     =  tgenerage.brand    
                aycldeti2_fil.model     =  tgenerage.model
                /*aycldeti2_fil.ccolor    =  tgenerage.ccolor */
                aycldeti2_fil.vehreg    =  tgenerage.vehreg   
                aycldeti2_fil.province  =  tgenerage.province 
                aycldeti2_fil.yrmanu    =  tgenerage.yrmanu   
                aycldeti2_fil.engine    =  tgenerage.engine   
                aycldeti2_fil.cha_no    =  tgenerage.cha_no   
                aycldeti2_fil.eng_no    =  tgenerage.eng_no
                /*aycldeti2_fil.acno1     =  tgenerage.acno1  
                aycldeti2_fil.covcod    =  tgenerage.covcod */
                aycldeti2_fil.compins   =  tgenerage.compins  
                aycldeti2_fil.policy    =  tgenerage.policy   
                aycldeti2_fil.comdat    =  tgenerage.comdat   
                aycldeti2_fil.expdat    =  tgenerage.expdat   
                aycldeti2_fil.si        =  tgenerage.si       
                aycldeti2_fil.prem      =  tgenerage.prem     
                aycldeti2_fil.premtot   =  tgenerage.premtot 
                /*aycldeti2_fil.prem_cus  =  tgenerage.prem_cus */
                aycldeti2_fil.yrins     =  tgenerage.yrins    
                aycldeti2_fil.notify    =  tgenerage.notify   
                aycldeti2_fil.jobcode   =  tgenerage.jobcode  
                aycldeti2_fil.firstdat  =  tgenerage.firstdat 
                aycldeti2_fil.insrayrno =  tgenerage.insrayrno    
                aycldeti2_fil.premtax   =  tgenerage.premtax   .  
            CREATE aycldeto2_fil.
            ASSIGN
                aycldeto2_fil.bchyr     =  nv_bchyr 
                aycldeto2_fil.bchno     =  nv_bchno 
                aycldeto2_fil.bchcnt    =  nv_bchcnt
                aycldeto2_fil.rectyp    =  tgenerage.rectyp   
                aycldeto2_fil.rseqno    =  tgenerage.rseqno   
                aycldeto2_fil.compno    =  tgenerage.compno   
                aycldeto2_fil.brncode   =  tgenerage.brncode  
                aycldeto2_fil.prodcode  =  tgenerage.prodcode 
                aycldeto2_fil.contno    =  tgenerage.contno 
                /*aycldeto2_fil.finint    =  tgenerage.finint */
                aycldeto2_fil.ntitle    =  tgenerage.ntitle   
                aycldeto2_fil.fname     =  tgenerage.fname    
                aycldeto2_fil.lname     =  tgenerage.lname
                /*aycldeto2_fil.addr1   =  tgenerage.addr1  
                aycldeto2_fil.addr2     =  tgenerage.addr2  
                aycldeto2_fil.addr3     =  tgenerage.addr3  
                aycldeto2_fil.postcd    =  tgenerage.postcd 
                aycldeto2_fil.flag      =  tgenerage.flag */ 
                aycldeto2_fil.brand     =  tgenerage.brand    
                aycldeto2_fil.model     =  tgenerage.model 
                /*aycldeto2_fil.ccolor    =  tgenerage.ccolor */
                aycldeto2_fil.vehreg    =  tgenerage.vehreg   
                aycldeto2_fil.province  =  tgenerage.province 
                aycldeto2_fil.yrmanu    =  tgenerage.yrmanu   
                aycldeto2_fil.engine    =  tgenerage.engine   
                aycldeto2_fil.cha_no    =  tgenerage.cha_no   
                aycldeto2_fil.eng_no    =  tgenerage.eng_no
                /*aycldeto2_fil.acno1   =  tgenerage.acno1  
                aycldeto2_fil.covcod    =  tgenerage.covcod */
                aycldeto2_fil.compins   =  tgenerage.compins  
                aycldeto2_fil.policy    =  tgenerage.policy   
                aycldeto2_fil.comdat    =  tgenerage.comdat   
                aycldeto2_fil.expdat    =  tgenerage.expdat   
                aycldeto2_fil.si        =  tgenerage.si       
                aycldeto2_fil.prem      =  tgenerage.prem     
                aycldeto2_fil.premtot   =  tgenerage.premtot
                /*aycldeto2_fil.prem_cus  =  tgenerage.prem_cus */
                aycldeto2_fil.yrins     =  tgenerage.yrins    
                aycldeto2_fil.notify    =  tgenerage.notify   
                aycldeto2_fil.jobcode   =  tgenerage.jobcode  
                aycldeto2_fil.firstdat  =  tgenerage.firstdat  
                aycldeto2_fil.insrayrno =  tgenerage.insrayrno    
                aycldeto2_fil.premtax   =  tgenerage.premtax   . 
            CREATE workf_aycl.
            ASSIGN 
                workf_aycl.bchyr    =  nv_bchyr     
                workf_aycl.bchno    =  nv_bchno     
                workf_aycl.bchcnt   =  nv_bchcnt    
                workf_aycl.rseqno   =  tgenerage.rseqno      
                workf_aycl.finint   =  tgenerage.finint  
                workf_aycl.addr1    =  tgenerage.addr1      
                workf_aycl.addr2    =  tgenerage.addr2      
                workf_aycl.addr3    =  tgenerage.addr3      
                workf_aycl.postcd   =  tgenerage.postcd     
                workf_aycl.flag     =  tgenerage.flag     
                workf_aycl.CCOLOR   =  tgenerage.ccolor  
                workf_aycl.acno1    =  tgenerage.acno1   
                workf_aycl.covcod   =  tgenerage.covcod  
                workf_aycl.prem_cus =  tgenerage.prem_cus. 
             /*end.. Add by Kridtiya i. A59-0359*/
        END. /* tgenerage.rectyp = "D" or Other */
    END.
    
    /*RELEASE aycldeti_fil.   /*A59-0359*/ 
    RELEASE aycldeto_fil. */  /*A59-0359*/  
    RELEASE aycldeti2_fil.    /*A59-0359*/ 
    RELEASE aycldeto2_fil.    /*A59-0359*/ 
... end : A65-0115...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_outputexcel WGWAYCL1 
PROCEDURE 00-proc_outputexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A65-0115 ....
If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".csv"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".csv"  .
DISP fi_outputconv WITH FRAM fr_main.
OUTPUT TO VALUE(fi_outputconv).
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "H" .
    EXPORT DELIMITER "|" 
       tgenerage.rectyp     
       tgenerage.rseqno     
       tgenerage.compno     
       tgenerage.brncode    
       tgenerage.prodcode   
       tgenerage.contno .   /*A59-0359*/
END.
FOR EACH tgenerage NO-LOCK  
     WHERE tgenerage.rectyp  <> "H"  AND 
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .  
    EXPORT DELIMITER "|" 
        tgenerage.rectyp     
        tgenerage.rseqno     
        tgenerage.compno     
        tgenerage.brncode    
        tgenerage.prodcode   
        tgenerage.contno     
        tgenerage.finint     
        tgenerage.ntitle     
        tgenerage.fname      
        tgenerage.lname      
        tgenerage.addr1      
        tgenerage.addr2      
        tgenerage.addr3      
        tgenerage.postcd     
        tgenerage.flag       
        tgenerage.brand      
        tgenerage.model      
        tgenerage.CCOLOR     
        tgenerage.vehreg     
        tgenerage.province   
        tgenerage.yrmanu     
        tgenerage.engine     
        tgenerage.cha_no     
        tgenerage.eng_no     
        tgenerage.acno1      
        tgenerage.covcod     
        tgenerage.compins    
        tgenerage.policy     
        tgenerage.comdat     
        tgenerage.expdat     
        string(deci(tgenerage.si) / 100 ,">>>,>>>,>>9.99")      
        string(deci(tgenerage.prem) / 100 ,">>>,>>>,>>9.99")            
        string(deci(tgenerage.premtot) / 100 ,">>>,>>>,>>9.99")        
        STRING(deci(tgenerage.prem_cus) / 100  ,">>>,>>>,>>9.99")     
        tgenerage.yrins      
        tgenerage.notify     
        tgenerage.jobcode    
        tgenerage.firstdat   
        tgenerage.insrayrno                                            /*A590359*/     
        STRING(deci(tgenerage.premtax) / 100  ,">>>,>>>,>>9.99")    .  /*A590359*/   
END.
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "T" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp       
        tgenerage.rseqno       
        tgenerage.compno       
        tgenerage.brncode      
        tgenerage.prodcode     
        tgenerage.contno  .   
END.
...end : A65-0115 ..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_outputexcel_2 WGWAYCL1 
PROCEDURE 00-proc_outputexcel_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A65-0115....
If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".csv"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".csv"  .
DISP fi_outputconv WITH FRAM fr_main.
OUTPUT TO VALUE(fi_outputconv).
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "H" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp     
        tgenerage.rseqno     
        tgenerage.compno     
        tgenerage.brncode    
        tgenerage.prodcode   
        tgenerage.contno  .
END.
FOR EACH tgenerage NO-LOCK  
     WHERE tgenerage.rectyp  <> "H"  AND 
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .  
    EXPORT DELIMITER "|" 
        tgenerage.rectyp     
        tgenerage.rseqno     
        tgenerage.compno     
        tgenerage.brncode    
        tgenerage.prodcode   
        tgenerage.contno     
        tgenerage.finint     
        tgenerage.ntitle     
        tgenerage.fname      
        tgenerage.lname      
        tgenerage.addr1      
        tgenerage.addr2      
        tgenerage.addr3      
        tgenerage.postcd     
        tgenerage.flag       
        tgenerage.brand      
        tgenerage.model      
        tgenerage.CCOLOR     
        tgenerage.vehreg     
        tgenerage.province   
        tgenerage.yrmanu     
        tgenerage.engine     
        tgenerage.cha_no     
        tgenerage.eng_no     
        tgenerage.acno1      
        tgenerage.covcod     
        tgenerage.compins    
        tgenerage.policy     
        tgenerage.comdat     
        tgenerage.expdat     
        string(deci(tgenerage.si),">>>,>>>,>>9.99")      
        string(deci(tgenerage.prem),">>>,>>>,>>9.99")            
        string(deci(tgenerage.premtot),">>>,>>>,>>9.99")        
        STRING(deci(tgenerage.prem_cus),">>>,>>>,>>9.99")     
        tgenerage.yrins      
        tgenerage.notify     
        tgenerage.jobcode    
        tgenerage.firstdat   
        tgenerage.insrayrno                                  /*A59-0359*/   
        STRING(deci(tgenerage.premtax),">>>,>>>,>>9.99")  .  /*A59-0359*/ 
END.
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "T" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp     
        tgenerage.rseqno     
        tgenerage.compno     
        tgenerage.brncode    
        tgenerage.prodcode   
        tgenerage.contno  .
END.
... END : A65-0115 ...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_outputfile WGWAYCL1 
PROCEDURE 00-proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0115..
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "H" NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
    PUT UNFORMATTED 
        TRIM(ayclhead2_fil.rectyp)    + "|" +
        TRIM(ayclhead2_fil.fseqno)    + "|" +
        TRIM(ayclhead2_fil.compno)    + "|" +
        TRIM(ayclhead2_fil.compins)   + "|" +
        TRIM(ayclhead2_fil.asofdat)   + "|" +
        TRIM(ayclhead2_fil.developno) + "" SKIP.  
END.
/**** Detail ****/
FOR EACH aycldeto2_fil NO-LOCK WHERE
    aycldeto2_fil.bchyr  = nv_bchyr    AND
    aycldeto2_fil.bchno  = nv_bchprev  AND
    aycldeto2_fil.bchcnt = nv_bchcnt   
    BREAK BY aycldeto2_fil.rseqno :
    ASSIGN 
        nv_premtaxs = "" 
        nv_premtaxs = string(deci(aycldeto2_fil.premtax),"999999999")
        n_rseqno    = INTE(aycldeto2_fil.rseqno)
        n_totpolno  = n_totpolno + 1
        /*A59-0359*/
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    FIND LAST workf_aycl WHERE 
        workf_aycl.bchyr    =  aycldeto2_fil.bchyr  AND  
        workf_aycl.bchno    =  aycldeto2_fil.bchno  AND
        workf_aycl.bchcnt   =  aycldeto2_fil.bchcnt AND
        workf_aycl.rseqno   =  aycldeto2_fil.rseqno NO-LOCK NO-ERROR .
    IF AVAIL workf_aycl THEN
        ASSIGN 
        np_finint    =  workf_aycl.finint   
        np_addr1     =  workf_aycl.addr1     
        np_addr2     =  workf_aycl.addr2     
        np_addr3     =  workf_aycl.addr3     
        np_postcd    =  workf_aycl.postcd    
        np_flag      =  workf_aycl.flag     
        np_CCOLOR    =  workf_aycl.CCOLOR   
        np_acno1     =  workf_aycl.acno1    
        np_covcod    =  workf_aycl.covcod   
        np_prem_cus  =  workf_aycl.prem_cus .
    ELSE ASSIGN 
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .

    /*A59-0359*/
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
    PUT UNFORMATTED  
        TRIM(aycldeto2_fil.rectyp)   + "|" +
        TRIM(aycldeto2_fil.rseqno)   + "|" +
        TRIM(aycldeto2_fil.compno)   + "|" +
        TRIM(aycldeto2_fil.brncode)  + "|" +
        TRIM(aycldeto2_fil.prodcode) + "|" +
        TRIM(aycldeto2_fil.contno)   + "|" +
        TRIM(np_finint)              + "|" + 
        TRIM(aycldeto2_fil.ntitle)   + "|" +
        TRIM(aycldeto2_fil.fname)    + "|" +
        TRIM(aycldeto2_fil.lname)    + "|" +
        TRIM(np_addr1)               + "|" + 
        TRIM(np_addr2)               + "|" + 
        TRIM(np_addr3)               + "|" + 
        TRIM(np_postcd)              + "|" + 
        TRIM(np_flag)                + "|" + 
        TRIM(aycldeto2_fil.brand)    + "|" +
        TRIM(aycldeto2_fil.model)    + "|" +
        TRIM(np_CCOLOR)              + "|" + 
        TRIM(aycldeto2_fil.vehreg)   + "|" +
        TRIM(aycldeto2_fil.province) + "|" +
        TRIM(aycldeto2_fil.yrmanu)   + "|" +
        TRIM(aycldeto2_fil.engine)   + "|" +
        TRIM(aycldeto2_fil.cha_no)   + "|" +
        TRIM(aycldeto2_fil.eng_no)   + "|" +
        TRIM(np_acno1)               + "|" + 
        TRIM(np_covcod)              + "|" + 
        TRIM(aycldeto2_fil.compins)  + "|" +
        TRIM(aycldeto2_fil.policy)   + "|" +
        TRIM(aycldeto2_fil.comdat)   + "|" +
        TRIM(aycldeto2_fil.expdat)   + "|" +
        TRIM(aycldeto2_fil.si)       + "|" +
        TRIM(aycldeto2_fil.prem)     + "|" +
        TRIM(aycldeto2_fil.premtot)  + "|" +
        TRIM(np_prem_cus)            + "|" + 
        TRIM(aycldeto2_fil.yrins)    + "|" +
        TRIM(aycldeto2_fil.notify)   + "|" +
        TRIM(aycldeto2_fil.jobcode)  + "|" +
        TRIM(aycldeto2_fil.firstdat)  + "|" +
        TRIM(aycldeto2_fil.insrayrno) + "|" +
        TRIM(nv_premtaxs)   SKIP.  
END.  /*FOR EACH aycldeto2_fil*/
/**** Total ****/
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "T"         NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
    n_totpolno1 =  STRING(n_totpolno,"99999").
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
    PUT UNFORMATTED  
        TRIM(ayclhead2_fil.rectyp)      + "|" +
        TRIM(n_rseqno1)                 + "|" +  
        TRIM(n_totpolno1)               + "|" +  
        TRIM(ayclhead2_fil.totpremt)    + "|" +
        TRIM(ayclhead2_fil.chkdigit)    + "|" +
        trim(ayclhead2_fil.developno)   + ""  SKIP.
    END.   /*FIND FIRST ayclhead2_fil*/
    ....end A65-0115..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_outputfile02 WGWAYCL1 
PROCEDURE 00-proc_outputfile02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0115...
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "H" NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
    PUT UNFORMATTED 
        TRIM(ayclhead2_fil.rectyp)    + "|" +
        TRIM(ayclhead2_fil.fseqno)    + "|" +
        TRIM(ayclhead2_fil.compno)    + "|" +
        TRIM(ayclhead2_fil.compins)   + "|" +
        TRIM(ayclhead2_fil.asofdat)   + "|" +
        TRIM(ayclhead2_fil.developno) + "" SKIP.  
END.
/**** Detail ****/
FOR EACH aycldeto2_fil NO-LOCK WHERE
    aycldeto2_fil.bchyr  = nv_bchyr    AND
    aycldeto2_fil.bchno  = nv_bchprev  AND
    aycldeto2_fil.bchcnt = nv_bchcnt   
    BREAK BY aycldeto2_fil.rseqno :
    ASSIGN 
        n_rseqno    = INTE(aycldeto2_fil.rseqno) 
        n_totpolno  = n_totpolno + 1
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    FIND LAST workf_aycl WHERE 
        workf_aycl.bchyr    =  aycldeto2_fil.bchyr  AND  
        workf_aycl.bchno    =  aycldeto2_fil.bchno  AND
        workf_aycl.bchcnt   =  aycldeto2_fil.bchcnt AND
        workf_aycl.rseqno   =  aycldeto2_fil.rseqno NO-LOCK NO-ERROR .
    IF AVAIL workf_aycl THEN
        ASSIGN 
        np_finint    =  workf_aycl.finint   
        np_addr1     =  workf_aycl.addr1     
        np_addr2     =  workf_aycl.addr2     
        np_addr3     =  workf_aycl.addr3     
        np_postcd    =  workf_aycl.postcd    
        np_flag      =  workf_aycl.flag     
        np_CCOLOR    =  workf_aycl.CCOLOR   
        np_acno1     =  workf_aycl.acno1    
        np_covcod    =  workf_aycl.covcod   
        np_prem_cus  =  workf_aycl.prem_cus .
    ELSE ASSIGN 
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
    PUT UNFORMATTED  
        TRIM(aycldeto2_fil.rectyp)   + "|" +
        TRIM(aycldeto2_fil.rseqno)   + "|" +
        TRIM(aycldeto2_fil.compno)   + "|" +
        TRIM(aycldeto2_fil.brncode)  + "|" +
        TRIM(aycldeto2_fil.prodcode) + "|" +
        TRIM(aycldeto2_fil.contno)   + "|" +
        TRIM(np_finint)              + "|" + 
        TRIM(aycldeto2_fil.ntitle)   + "|" +
        TRIM(aycldeto2_fil.fname)    + "|" +
        TRIM(aycldeto2_fil.lname)    + "|" +
        TRIM(np_addr1)               + "|" + 
        TRIM(np_addr2)               + "|" + 
        TRIM(np_addr3)               + "|" + 
        TRIM(np_postcd)              + "|" + 
        TRIM(np_flag)                + "|" + 
        TRIM(aycldeto2_fil.brand)    + "|" +
        TRIM(aycldeto2_fil.model)    + "|" +
        TRIM(np_CCOLOR)              + "|" + 
        TRIM(aycldeto2_fil.vehreg)   + "|" +
        TRIM(aycldeto2_fil.province) + "|" +
        TRIM(aycldeto2_fil.yrmanu)   + "|" +
        TRIM(aycldeto2_fil.engine)   + "|" +
        TRIM(aycldeto2_fil.cha_no)   + "|" +
        TRIM(aycldeto2_fil.eng_no)   + "|" +
        TRIM(np_acno1)               + "|" + 
        TRIM(np_covcod)              + "|" + 
        TRIM(aycldeto2_fil.compins)  + "|" +
        TRIM(aycldeto2_fil.policy)   + "|" +
        TRIM(aycldeto2_fil.comdat)   + "|" +
        TRIM(aycldeto2_fil.expdat)   + "|" +
        TRIM(aycldeto2_fil.si)       + "|" +
        TRIM(aycldeto2_fil.prem)     + "|" +
        TRIM(aycldeto2_fil.premtot)  + "|" +
        TRIM(np_prem_cus)            + "|" + 
        TRIM(aycldeto2_fil.yrins)    + "|" +
        TRIM(aycldeto2_fil.notify)   + "|" +
        TRIM(aycldeto2_fil.jobcode)  + "|" +
        TRIM(aycldeto2_fil.firstdat)  + "|" +
        TRIM(aycldeto2_fil.insrayrno) + "|" +
        TRIM(aycldeto2_fil.premtax)   + "|" +
        trim(aycldeto2_fil.remark)  SKIP.  
END.  /*FOR EACH aycldeto2_fil*/
/**** Total ****/
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "T"         NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
    n_totpolno1 =  STRING(n_totpolno,"99999").
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
    PUT UNFORMATTED  
        TRIM(ayclhead2_fil.rectyp)      + "|" +
        TRIM(n_rseqno1)                 + "|" +  
        TRIM(n_totpolno1)               + "|" +  
        TRIM(ayclhead2_fil.totpremt)    + "|" +
        TRIM(ayclhead2_fil.chkdigit)    + "|" +
        trim(ayclhead2_fil.developno)   + ""  SKIP.
    END.   /*FIND FIRST ayclhead2_fil*/
    ... end : A65-0115..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_output_txt WGWAYCL1 
PROCEDURE 00-proc_output_txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0115 ....
If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".txt"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".txt"  .
 
OUTPUT TO VALUE(fi_outputconv) NO-ECHO.
FIND LAST  tgenerage WHERE   tgenerage.rectyp  = "H" NO-LOCK NO-ERROR.
IF AVAIL tgenerage THEN DO:
    PUT UNFORMATTED
        tgenerage.rectyp     + "|" + 
        tgenerage.rseqno     + "|" + 
        tgenerage.compno     + "|" + 
        tgenerage.brncode    + "|" + 
        tgenerage.prodcode   + "|" + 
        tgenerage.contno     +  ""     SKIP. 
END.                         
FOR EACH tgenerage NO-LOCK   
     WHERE tgenerage.rectyp  <> "H"  AND
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .     
    PUT UNFORMATTED 
        tgenerage.rectyp                     + "|" + 
        tgenerage.rseqno                     + "|" +
        tgenerage.compno                     + "|" +
        tgenerage.brncode                    + "|" +
        tgenerage.prodcode                   + "|" +
        tgenerage.contno                     + "|" +
        tgenerage.finint                     + "|" +
        tgenerage.ntitle                     + "|" +
        tgenerage.fname                      + "|" +
        tgenerage.lname                      + "|" +
        tgenerage.addr1                      + "|" +
        tgenerage.addr2                      + "|" +
        tgenerage.addr3                      + "|" +
        tgenerage.postcd                     + "|" +
        tgenerage.flag                       + "|" +
        tgenerage.brand                      + "|" +
        tgenerage.model                      + "|" +
        tgenerage.CCOLOR                     + "|" +
        tgenerage.vehreg                     + "|" +
        tgenerage.province                   + "|" +
        tgenerage.yrmanu                     + "|" +
        tgenerage.engine                     + "|" +
        tgenerage.cha_no                     + "|" +
        tgenerage.eng_no                     + "|" +
        tgenerage.acno1                      + "|" +
        tgenerage.covcod                     + "|" +
        tgenerage.compins                    + "|" +
        tgenerage.policy                     + "|" +
        tgenerage.comdat                     + "|" +
        tgenerage.expdat                     + "|" +
        tgenerage.si                         + "|" +
        tgenerage.prem                       + "|" +
        tgenerage.premtot                    + "|" +
        tgenerage.prem_cus                   + "|" +
        tgenerage.yrins                      + "|" +
        tgenerage.notify                     + "|" +
        tgenerage.jobcode                    + "|" +
        tgenerage.firstdat                   + "|" +     
        tgenerage.insrayrno                  + "|" +    /*A59-0359*/   
        tgenerage.premtax                               /*A59-0359*/  
        SKIP. 
END.
FIND LAST  tgenerage  WHERE tgenerage.rectyp  = "T" NO-LOCK NO-ERROR .
IF AVAIL tgenerage THEN DO:
    PUT UNFORMATTED 
        tgenerage.rectyp   + "|" +  
        tgenerage.rseqno   + "|" +  
        tgenerage.compno   + "|" +  
        tgenerage.brncode  + "|" +  
        tgenerage.prodcode + "|" +  
        tgenerage.contno   + ""    SKIP. /*A59-0359*/    
END.
... end : A65-0115 ...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WGWAYCL1  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWAYCL1)
  THEN DELETE WIDGET WGWAYCL1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WGWAYCL1  _DEFAULT-ENABLE
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
  DISPLAY ra_outfiletyp fi_inputconv ra_typtitle ra_producer cbPrtList 
          to_guaranexcel to_guaranpdf to_textaycl fi_trndat fi_nbchno fi_branch 
          fi_producer fi_agent fi_bchprev fi_bchyr fi_bchcnt fi_filename 
          fi_output3 fi_brndes fi_impcnt fi_proname fi_agtname fi_completecnt 
          fi_outagent fi_outagentgrp fi_outputconv 
      WITH FRAME fr_main IN WINDOW WGWAYCL1.
  ENABLE br_input ra_outfiletyp bu_findinput bu_okconv fi_inputconv ra_typtitle 
         ra_producer cbPrtList to_guaranexcel to_guaranpdf to_textaycl 
         fi_trndat fi_nbchno fi_branch fi_producer fi_agent fi_bchprev fi_bchyr 
         fi_bchcnt fi_filename bu_file fi_output3 buinp bu_exit bu_hpbrn 
         bu_hpacno1 bu_hpagent bu_out fi_outagent fi_outagentgrp fi_outputconv 
         RECT-370 RECT-373 RECT-374 RECT-376 RECT-372 RECT-377 RECT-378 
         RECT-379 RECT-380 RECT-381 
      WITH FRAME fr_main IN WINDOW WGWAYCL1.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WGWAYCL1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdcreate WGWAYCL1 
PROCEDURE pdcreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by :A65-0115      
------------------------------------------------------------------------------*/
DEF VAR nv_compno AS CHAR .
    FOR EACH tgenerage WHERE rectyp <> "" NO-LOCK:

        IF tgenerage.rectyp = "H" THEN DO:
            /******** HEADER ********/
            CREATE ayclhead2_fil.
            ASSIGN
                ayclhead2_fil.bchyr     =  nv_bchyr
                ayclhead2_fil.bchno     =  nv_bchno
                ayclhead2_fil.bchcnt    =  nv_bchcnt
                ayclhead2_fil.rectyp    =  tgenerage.rectyp
                ayclhead2_fil.fseqno    =  tgenerage.rseqno
                ayclhead2_fil.compno    =  tgenerage.prodcode  
                ayclhead2_fil.compins   =  tgenerage.brncode   
                ayclhead2_fil.asofdat   =  tgenerage.contno   
                ayclhead2_fil.developno =  tgenerage.ntitle  .

            ASSIGN nv_compno = tgenerage.prodcode.

        END.
        ELSE IF tgenerage.rectyp = "T" THEN DO:
            /* Footer */
            CREATE ayclhead2_fil.
            ASSIGN
                ayclhead2_fil.bchyr     =   nv_bchyr
                ayclhead2_fil.bchno     =   nv_bchno
                ayclhead2_fil.bchcnt    =   nv_bchcnt
                ayclhead2_fil.rectyp    =  tgenerage.rectyp
                ayclhead2_fil.fseqno    =  tgenerage.rseqno
                ayclhead2_fil.compno    =  tgenerage.prodcode  
                ayclhead2_fil.compins   =  tgenerage.brncode   
                ayclhead2_fil.asofdat   =  tgenerage.contno   
                ayclhead2_fil.developno =  tgenerage.ntitle  . 
           
        END.
        ELSE DO:  
            CREATE aycldeti2_fil.
            ASSIGN
                aycldeti2_fil.bchyr     =  nv_bchyr 
                aycldeti2_fil.bchno     =  nv_bchno 
                aycldeti2_fil.bchcnt    =  nv_bchcnt
                aycldeti2_fil.rectyp    =  tgenerage.rectyp   
                aycldeti2_fil.rseqno    =  tgenerage.rseqno
                aycldeti2_fil.compno    =  nv_compno
                aycldeti2_fil.prodcode  =  tgenerage.prodcode 
                aycldeti2_fil.brncode   =  tgenerage.brncode  
                aycldeti2_fil.contno    =  tgenerage.contno
                aycldeti2_fil.ntitle    =  tgenerage.ntitle   
                aycldeti2_fil.fname     =  tgenerage.fname    
                aycldeti2_fil.lname     =  tgenerage.lname 
                aycldeti2_fil.textchar1 =  tgenerage.icno           /* ranu */
                /*aycldeto2_fil.addr1   =  tgenerage.addr1 
                aycldeti2_fil.addr2     =  tgenerage.addr2 
                aycldeti2_fil.addr3     =  tgenerage.addr3 
                aycldeti2_fil.postcd    =  tgenerage.postcd
                aycldeti2_fil.flag      =  tgenerage.flag  */
                aycldeti2_fil.brand     =  tgenerage.brand    
                aycldeti2_fil.model     =  tgenerage.model
                /*aycldeti2_fil.ccolor    =  tgenerage.ccolor */
                aycldeti2_fil.vehreg    =  tgenerage.vehreg   
                aycldeti2_fil.province  =  tgenerage.province 
                aycldeti2_fil.yrmanu    =  tgenerage.yrmanu   
                aycldeti2_fil.engine    =  tgenerage.engine   
                aycldeti2_fil.cha_no    =  tgenerage.cha_no   
                aycldeti2_fil.eng_no    =  tgenerage.eng_no
                aycldeti2_fil.textchar2 =  tgenerage.engine_typ     /*ranu */
                aycldeti2_fil.textchar3 =  tgenerage.Serialno     /*ranu */
                /*aycldeti2_fil.acno1     =  tgenerage.acno1  
                aycldeti2_fil.covcod    =  tgenerage.covcod 
                aycldeti2_fil.compins   =  tgenerage.compins */ 
                aycldeti2_fil.policy    =  tgenerage.policy   
                aycldeti2_fil.comdat    =  tgenerage.comdat   
                aycldeti2_fil.expdat    =  tgenerage.expdat   
                aycldeti2_fil.si        =  tgenerage.si       
                aycldeti2_fil.prem      =  tgenerage.prem     
                aycldeti2_fil.premtot   =  tgenerage.premtot 
                /*aycldeti2_fil.prem_cus  =  tgenerage.prem_cus */
                aycldeti2_fil.yrins     =  tgenerage.yrins    
                aycldeti2_fil.notify    =  tgenerage.notify 
                /*aycldeti2_fil.jobcode   =  tgenerage.jobcode  
                aycldeti2_fil.firstdat  =  tgenerage.firstdat 
                aycldeti2_fil.insrayrno =  tgenerage.insrayrno    
                aycldeti2_fil.premtax   =  tgenerage.premtax */  .  
            CREATE aycldeto2_fil.
            ASSIGN
                aycldeto2_fil.bchyr     =  nv_bchyr 
                aycldeto2_fil.bchno     =  nv_bchno 
                aycldeto2_fil.bchcnt    =  nv_bchcnt
                aycldeto2_fil.rectyp    =  tgenerage.rectyp   
                aycldeto2_fil.rseqno    =  tgenerage.rseqno   
                aycldeto2_fil.compno    =  nv_compno  
                aycldeto2_fil.prodcode  =  tgenerage.prodcode
                aycldeto2_fil.brncode   =  tgenerage.brncode 
                aycldeto2_fil.contno    =  tgenerage.contno 
                /*aycldeto2_fil.finint    =  tgenerage.finint */
                aycldeto2_fil.ntitle    =  tgenerage.ntitle   
                aycldeto2_fil.fname     =  tgenerage.fname    
                aycldeto2_fil.lname     =  tgenerage.lname
                aycldeto2_fil.textchar1 =  tgenerage.icno     /* ranu */
                /*aycldeto2_fil.addr1   =  tgenerage.addr1  
                aycldeto2_fil.addr2     =  tgenerage.addr2  
                aycldeto2_fil.addr3     =  tgenerage.addr3  
                aycldeto2_fil.postcd    =  tgenerage.postcd 
                aycldeto2_fil.flag      =  tgenerage.flag */
                aycldeto2_fil.brand     =  tgenerage.brand    
                aycldeto2_fil.model     =  tgenerage.model 
                /*aycldeto2_fil.ccolor    =  tgenerage.ccolor */
                aycldeto2_fil.vehreg    =  tgenerage.vehreg   
                aycldeto2_fil.province  =  tgenerage.province 
                aycldeto2_fil.yrmanu    =  tgenerage.yrmanu   
                aycldeto2_fil.engine    =  tgenerage.engine   
                aycldeto2_fil.cha_no    =  tgenerage.cha_no   
                aycldeto2_fil.eng_no    =  tgenerage.eng_no
                aycldeto2_fil.textchar2 =  tgenerage.engine_typ     /*ranu */
                aycldeto2_fil.textchar3 =  tgenerage.Serialno     /*ranu */
                /*aycldeto2_fil.acno1   =  tgenerage.acno1  
                aycldeto2_fil.covcod    =  tgenerage.covcod 
                aycldeto2_fil.compins   =  tgenerage.compins*/  
                aycldeto2_fil.policy    =  tgenerage.policy   
                aycldeto2_fil.comdat    =  tgenerage.comdat   
                aycldeto2_fil.expdat    =  tgenerage.expdat   
                aycldeto2_fil.si        =  tgenerage.si       
                aycldeto2_fil.prem      =  tgenerage.prem     
                aycldeto2_fil.premtot   =  tgenerage.premtot
                /*aycldeto2_fil.prem_cus  =  tgenerage.prem_cus */
                aycldeto2_fil.yrins     =  tgenerage.yrins    
                aycldeto2_fil.notify    =  tgenerage.notify   
                /*aycldeto2_fil.jobcode   =  tgenerage.jobcode 
                aycldeto2_fil.firstdat  =  tgenerage.firstdat 
                aycldeto2_fil.insrayrno =  tgenerage.insrayrno    
                aycldeto2_fil.premtax   =  tgenerage.premtax*/   . 
            CREATE workf_aycl.
            ASSIGN 
                workf_aycl.bchyr    =  nv_bchyr     
                workf_aycl.bchno    =  nv_bchno     
                workf_aycl.bchcnt   =  nv_bchcnt    
                workf_aycl.rseqno   =  tgenerage.rseqno      
                /*workf_aycl.finint   =  tgenerage.finint  ranu */ 
                workf_aycl.addr1    =  tgenerage.addr1      
                workf_aycl.addr2    =  tgenerage.addr2      
                workf_aycl.addr3    =  tgenerage.addr3      
                workf_aycl.postcd   =  tgenerage.postcd     
                /*workf_aycl.flag     =  tgenerage.flag*/    
                workf_aycl.CCOLOR   =  tgenerage.ccolor  
                /*workf_aycl.acno1    =  tgenerage.acno1  ranu */ 
                workf_aycl.covcod   =  tgenerage.covcod  
                workf_aycl.prem_cus =  tgenerage.prem_cus. 
             /*end.. Add by Kridtiya i. A59-0359*/
        END. /* tgenerage.rectyp = "D" or Other */
    END.
    
    RELEASE aycldeti2_fil.    /*A59-0359*/ 
    RELEASE aycldeto2_fil.    /*A59-0359*/ 
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdcreate_con WGWAYCL1 
PROCEDURE pdcreate_con :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* DEF VAR nv_name AS CHAR.      */
/*  DEF VAR nv_comd AS INTE.     */
/*  DEF VAR nv_comm AS INTE.     */
/*  DEF VAR nv_comy AS INTE.     */
/*                               */
/*  DEF VAR nv_expd AS INTE.     */
/*  DEF VAR nv_expm AS INTE.     */
/*  DEF VAR nv_expy    AS INTE.  */
/*  DEF VAR nv_com_dat AS DATE.  */
/*  DEF VAR nv_exp_dat AS DATE.  */
/*  DEF VAR nv_com_dat1 AS CHAR. */
/*  DEF VAR nv_exp_dat1 AS CHAR. */
/*  DEF VAR n_si        AS INTE. */
/*  DEF VAR n_si1       AS CHAR. */
/*  DEF VAR n_si2       AS DECI. */
/*  DEF VAR n_prem      AS INTE. */
/*  DEF VAR n_prem1     AS CHAR. */
/*  DEF VAR n_prem2     AS DECI. */
/*  DEF VAR n_pretot    AS INTE. */
/*  DEF VAR n_pretot1   AS CHAR. */
/*  DEF VAR n_pretot2   AS DECI. */
 
FOR EACH tgenerage  WHERE
    /*aycldeto_fil.bchyr  = INPUT fi_bchyr   AND  
    aycldeto_fil.bchno  = INPUT fi_bchprev AND  
    aycldeto_fil.bchcnt = INPUT fi_bchcnt  AND */ 
    (tgenerage.rectyp <> "H"       AND         
     tgenerage.rectyp <> "T" )     NO-LOCK    
    BREAK BY tgenerage.rseqno:
    
    FIND LAST sicuw.uwm100 WHERE 
        sicuw.uwm100.policy = tgenerage.policy   AND
        sicuw.uwm100.releas = YES  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        CREATE certmp.     
        ASSIGN      
            certmp.YearReg  = int(tgenerage.rseqno)   
            certmp.polno    = tgenerage.policy
            certmp.Branch   = tgenerage.prodcode 
            certmp.rencnt   = sicuw.uwm100.rencnt 
            certmp.endcnt   = sicuw.uwm100.endcnt 
            certmp.Agent    = sicuw.uwm100.acno1 
            certmp.institle = sicuw.uwm100.ntitle 
            certmp.ComDate  = sicuw.uwm100.comdat 
            certmp.ExpDat   = sicuw.uwm100.expdat 
            certmp.Fname    = sicuw.uwm100.name1                
            certmp.Lname    = sicuw.uwm100.name2
            certmp.effdate  = sicuw.uwm100.accdat
            certmp.Modno    = tgenerage.model
            certmp.PAText1  = TRIM(tgenerage.yrmanu) 
            certmp.RenPol   = sicuw.uwm100.endno        
            Certmp.Progid   = nv_progid2  
            Certmp.usrid    = nv_useid    
            Certmp.entdat   = nv_entdat   
            Certmp.enttim   = nv_enttime  
            certmp.Premium  = deci(tgenerage.prem)  
            certmp.Simax    = deci(tgenerage.premtot)  
            certmp.NetPrm   = deci(tgenerage.si)     .  
        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
            sicuw.uwm130.policy = tgenerage.policy      AND /**/
            sicuw.uwm130.rencnt = sicuw.uwm100.rencnt   AND
            sicuw.uwm130.endcnt = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm130  THEN DO:
            ASSIGN
                certmp.Tax    = DECI(sicuw.uwm130.uom1_V)   
                certmp.Stamp  = DECI(sicuw.uwm130.uom2_V)   
                certmp.Simin  = DECI(sicuw.uwm130.uom5_V) . 
        END.
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
            sicuw.uwm301.policy = tgenerage.policy     AND
            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt  AND             
            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.     
        IF AVAIL sicuw.uwm301 THEN DO:
            i_index = INDEX(uwm301.moddes," ") - 1.                                                               
            nvmoddes1 = SUBSTR(uwm301.moddes,1,i_index).                                                       
            ASSIGN                                                                                                
                certmp.Regno   = sicuw.uwm301.vehreg                                               
                certmp.Bodyno  = TRIM(sicuw.uwm301.cha_no)                                        
                certmp.PreBody = TRIM(sicuw.uwm301.vehuse)                                                        
                certmp.Engno   = TRIM(sicuw.uwm301.eng_no)                                                                                                          
                certmp.Brand   = nvmoddes1 .                                                           
        END.
        FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
            sicuw.uwm120.policy =  tgenerage.policy AND
            sicuw.uwm120.rencnt =  sicuw.uwm100.rencnt AND 
            sicuw.uwm120.endcnt =  sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm120 THEN DO:
            certmp.Class = TRIM(SUBSTR(sicuw.uwm120.class,2,3)).
        END.
        nv_fptr = uwm100.fptr05. 
        nv_bptr = uwm100.bptr05. 
        DO WHILE nv_fptr <> 0 AND uwm100.fptr05 <> ? :
            /* FIND FIRST sicuw.uwd104 WHERE A53-0312 */
            FIND LAST sicuw.uwd104 WHERE  
                /*uwd104.endcnt = uwm100.endcnt AND A53-0312*/
                RECID(uwd104) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAIL uwd104 THEN DO:
                nv_Covtext1 = nv_Covtext1 + uwd104.ltext.
                nv_fptr = uwd104.fptr. 
            END.
        END.
        certmp.Covtext1 = SUBSTRING(nv_Covtext1,1,30).            /*ตัดบรรทัดที่1 -to--A53-0239*/
        certmp.Covtext2 = SUBSTRING(nv_Covtext1,31,30).           /*ตัดบรรทัดที่2--to-A530-239*/
        certmp.Covtext3 = SUBSTRING(nv_Covtext1,61,100).          /*ตัดบรรทัดที่3--to-A53-0239*/
        certmp.Covtext4 = SUBSTRING(nv_Covtext1,91,LENGTH(nv_Covtext1)).
        nv_Covtext1 = "".
        nv_codtime = SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +         
            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +           
            SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2). 
        Certmp.Covtext5 = "_" + nv_codtime.                                                                   
    END.
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdGetPrtList WGWAYCL1 
PROCEDURE pdGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  def var printer-list  as character no-undo.
  def var port-list     as character no-undo.
  def var printer-count as integer no-undo.
  def var printer       as character no-undo format "x(32)".
  def var port          as character no-undo format "x(20)".

  run aderb/_prlist.p (output printer-list, output port-list,
                 output printer-count).

  ASSIGN
    cbPrtList:List-Items IN FRAME fr_main = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME fr_main.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create-certmp WGWAYCL1 
PROCEDURE pd_create-certmp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by :  Nipawadee R. to A530211 
  ------------------------------------------------------------------------------*/
  /* Comment by Nipawadee R. 
 FOR EACH certmp WHERE         
     certmp.progid  = "WGWAYCL1" .
     DELETE certmp.
 END. to A53-0312 */
  /*comment by kridtiya i. A58-0121......new pd_create-certmp2
DO WITH FRAME fr_main.
 /*Lukkana M. A55-0209 11/07/2012*/
 DEF VAR nv_name AS CHAR.
 DEF VAR nv_comd AS INTE.
 DEF VAR nv_comm AS INTE.
 DEF VAR nv_comy AS INTE.
 
 DEF VAR nv_expd AS INTE.
 DEF VAR nv_expm AS INTE.
 DEF VAR nv_expy    AS INTE.
 DEF VAR nv_com_dat AS DATE.
 DEF VAR nv_exp_dat AS DATE.
 DEF VAR nv_com_dat1 AS CHAR.
 DEF VAR nv_exp_dat1 AS CHAR.
 DEF VAR n_si        AS INTE.
 DEF VAR n_si1       AS CHAR.
 DEF VAR n_si2       AS DECI.
 DEF VAR n_prem      AS INTE.
 DEF VAR n_prem1     AS CHAR.
 DEF VAR n_prem2     AS DECI.
 DEF VAR n_pretot    AS INTE.
 DEF VAR n_pretot1   AS CHAR.
 DEF VAR n_pretot2   AS DECI.

 
 outfile2 = "C:\TEMP\" + INPUT fi_bchprev + "(ไม่พบข้อมูล)" + ".SLK" .                   
 OUTPUT STREAM ns1 TO VALUE(outfile2).
 PUT STREAM ns1 "ID;PND"  SKIP.
 ASSIGN 
     nv_row1 = 0              /* A57-0291 */
     nv_row1 = nv_row1 + 1.   /*HEAD*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X1;K"  '"'   "ลำดับที่"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X2;K"  '"'   "สาขา Aycal"      '"' SKIP.  /*A57-0371*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X3;K"  '"'   "ชื่อ-นามสกุล"    '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   "วันที่คุ้มครอง"  '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   "วันที่สิ้นสุด"   '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X6;K"  '"'   "ปีประกัน"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X7;K"  '"'   "ชื่อรถยนต์"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X8;K"  '"'   "เลขทะเบียน"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X9;K"  '"'   "เลขตัวถัง"       '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X10;K" '"'   "เลขเครื่องยนต์"  '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X11;K" '"'   "ทุนประกัน"       '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X12;K" '"'   "เบี้ยสุทธิ"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X13;K" '"'   "เบี้ยรวม"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X14;K" '"'   "หมายเหตุ"        '"' SKIP.

 /*Lukkana M. A55-0209 11/07/2012*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X15;K" '"'   "กรมธรรม์"       '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X16;K" '"'   "Producer Code"  '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/

 FOR EACH aycldeto_fil  WHERE
          aycldeto_fil.bchyr  = INPUT fi_bchyr   AND   /*nv_bchyr*/ 
          aycldeto_fil.bchno  = INPUT fi_bchprev AND   /*nv_bchno*/ 
          aycldeto_fil.bchcnt = INPUT fi_bchcnt  AND   /*nv_bchcnt*/
         (aycldeto_fil.rectyp <> "H"       AND         /*Header*/    
          aycldeto_fil.rectyp <> "T" )     NO-LOCK     /*Total*/ 
     BREAK BY aycldeto_fil.rseqno:

    FIND LAST sicuw.uwm100 WHERE 
              sicuw.uwm100.policy = aycldeto_fil.policy AND
              sicuw.uwm100.releas = YES  NO-LOCK NO-ERROR.
                       
    IF AVAIL sicuw.uwm100 THEN DO:
       CREATE certmp.     
          ASSIGN      
              certmp.YearReg  = INT(aycldeto_fil.rseqno)   
              certmp.polno    = aycldeto_fil.policy
              certmp.Branch   = aycldeto_fil.prodcode  
              certmp.rencnt   = sicuw.uwm100.rencnt /*A53-0312*/
              certmp.endcnt   = sicuw.uwm100.endcnt /*A53-0312*/
              certmp.Agent    = sicuw.uwm100.acno1 
              certmp.institle = sicuw.uwm100.ntitle 
              certmp.ComDate  = sicuw.uwm100.comdat /*เพิ่มยึดวัน Comdat ตามระบบ Nipawadee R. A53-0239*/
              certmp.ExpDat   = sicuw.uwm100.expdat /*เพิ่มยึดวัน expdat ตามระบบ Nipawadee R. A53-0239**/ 
              certmp.Fname    = sicuw.uwm100.name1                
              certmp.Lname    = sicuw.uwm100.name2
              certmp.effdate  = sicuw.uwm100.accdat
              certmp.Modno    = aycldeto_fil.model                                           
              certmp.PAText1  = TRIM(aycldeto_fil.yrmanu)        
              /* Comment by Nipawadee to A53-0380
              certmp.Premium  = sicuw.uwm100.prem_t
              certmp.Simax    = certmp.Premium + uwm100.rstp_t + uwm100.rtax_t  */         
               
              certmp.RenPol   = sicuw.uwm100.endno        
              /*certmp.progid   = "WGWAYCL1" . A53-0312 */
              Certmp.Progid  = nv_progid2   /*A53-0312*/
              Certmp.usrid   = nv_useid     /*A53-0312*/
              Certmp.entdat  = nv_entdat    /*A53-0312*/
              Certmp.enttim  = nv_enttime . /*A53-0312*/
              
          /* Add by Nipwadee R. 01/12/2010  A53-0380*/
              nv_prem1  = LENGTH(aycldeto_fil.prem).                                                                     
              nv_prem2  = SUBSTR(aycldeto_fil.prem,1,nv_prem1 - 2) + "." + SUBSTR(aycldeto_fil.prem,nv_prem1 - 1,2).     
              nv_prem3  = DECI(nv_prem2).           

              certmp.Premium  = nv_prem3 .
              
              nv_premto1 = LENGTH(aycldeto_fil.premtot).                                                                       
              nv_premto2 = SUBSTR(aycldeto_fil.premtot,1,nv_premto1 - 2) + "." + SUBSTR(aycldeto_fil.premtot,nv_premto1 - 1,2). 
              nv_premto3 = DECI(nv_premto2).    

              certmp.Simax    = nv_premto3 .
              
              nv_premsi1 = LENGTH(aycldeto_fil.si).    
              nv_premsi2 = SUBSTR(aycldeto_fil.si,1,nv_premsi1 - 2) + "." + SUBSTR(aycldeto_fil.si,nv_premsi1 - 1,2).    
              nv_premsi3 = DECI(nv_premsi2).

              certmp.NetPrm = nv_premsi3. 
              
        
        /*End add by Nipawadee R. 01/12/2010  A53-0380*/
      
       /* Comment by Nipawadee R. 08/10/2010   /*--สูญหายไฟไหม้--*/
       nv_premsi1  = LENGTH(aycldeto_fil.si). 
       nv_premsi2  = SUBSTR(aycldeto_fil.si,1,nv_premsi1 - 2) + "." + SUBSTR(aycldeto_fil.si,nv_premsi1 - 1,2).
       nv_premsi3  = DECI(nv_premsi2).
       /*--หาเบี้ยสุทธิ--*/
       nv_prem1  = LENGTH(aycldeto_fil.prem). 
       nv_prem2  = SUBSTR(aycldeto_fil.prem,1,nv_prem1 - 2) + "." + SUBSTR(aycldeto_fil.prem,nv_prem1 - 1,2).
       nv_prem3  = DECI(nv_prem2).
      
       /*--หาเบี้ยรวม--*/
       nv_premto1 = LENGTH(aycldeto_fil.premtot).
       nv_premto2 = SUBSTR(aycldeto_fil.premtot,1,nv_premto1 - 2) + "." + SUBSTR(aycldeto_fil.premto,nv_premto1 - 1,2).
       nv_premto3 = DECI(nv_premto2).
    
      /*-หา Comdate-*/
        IF aycldeto_fil.comdat <> "000000" THEN DO: 

            ASSIGN
             nv_comyea    = ""
             nv_common    = ""
             nv_comday    = ""
             nv_comyea1   = 0
             nv_comdate1  = ""
             nv_comdate2  = ? .
          nv_comyea  = SUBSTR(aycldeto_fil.comdat,1,2).                                                           
          nv_common  = SUBSTR(aycldeto_fil.comdat,3,2).                                                           
          nv_comday  = SUBSTR(aycldeto_fil.comdat,5,2).                                                           

          nv_comyea1  = INTE("25" + nv_comyea) - 543.

          nv_comdate1 = STRING(nv_comday,"99") + "/" + STRING(nv_common,"99") + "/" + STRING(nv_comyea1,"9999").

          nv_comdate2 = DATE(nv_comdate1).
        END.
        /*-หา Expdat-*/
        IF aycldeto_fil.expdat <> "000000" THEN DO:
    
            ASSIGN
              nv_comyea    = ""
              nv_common    = ""
              nv_comday    = ""
              nv_comyea1   = 0
              nv_comdate1  = ""
              nv_comdate2  = ? .
           nv_comyea  = SUBSTR(aycldeto_fil.comdat,1,2).                                                           
           nv_common  = SUBSTR(aycldeto_fil.comdat,3,2).                                                           
           nv_comday  = SUBSTR(aycldeto_fil.comdat,5,2).                                                           
                                                                                                                
           nv_comyea1  = INTE("25" + nv_comyea) - 543.
          
           nv_comdate1 = STRING(nv_comday,"99") + "/" + STRING(nv_common,"99") + "/" + STRING(nv_comyea1,"9999").
           
           nv_comdate2 = DATE(nv_comdate1).

           /*certmp.expDat = nv_comdate2.Comment by A53-0239*/ 
           
        END. /*-Exdate-*/   Comment to A53-0312 */
       /* A53-0312
       FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
       sicuw.uwm130.policy = certmp.polno   NO-LOCK NO-ERROR.*/

        /*--เบี้ยสุญหายไฟใหม้ เดิมยึดของ Text file นำเข้า-A53-0239-*/
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                  sicuw.uwm130.policy = aycldeto_fil.policy AND /**/
                  sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                  sicuw.uwm130.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm130  THEN DO:
            ASSIGN
               certmp.Tax    = DECI(sicuw.uwm130.uom1_V)   /*ความรับผิดชอบต่อบุคคล ต่อ/คน  A53-0239*/
               certmp.Stamp  = DECI(sicuw.uwm130.uom2_V)  /*ความรับผิดชอบต่อบุคคล ต่อ/ครั้ง A53-0239*/
               certmp.Simin  = DECI(sicuw.uwm130.uom5_V) . /*ความรับผิดชอบต่อบุคคล ต่อ/ครั้ง  A53-0239*/
             /*  certmp.NetPrm = DECI(sicuw.uwm130.uom7_v). */ 

        END.
        
        /*--หาประเภทรถ--*/ 
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                  sicuw.uwm301.policy = aycldeto_fil.policy AND
                  sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND             
                  sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.     
        IF AVAIL sicuw.uwm301 THEN DO:

           i_index = INDEX(uwm301.moddes," ") - 1.                                                               
           nvmoddes1 = SUBSTR(uwm301.moddes,1,i_index).                                                          
                                                                                                                 
           ASSIGN                                                                                                
               certmp.Regno   = sicuw.uwm301.vehreg /*เลขทะเบียน*/                                               
               certmp.Bodyno  = TRIM(sicuw.uwm301.cha_no) /*เลขตัวถัง*/                                          
               certmp.PreBody = TRIM(sicuw.uwm301.vehuse)                                                        
               certmp.Engno   = TRIM(sicuw.uwm301.eng_no)                                                                                                          
               certmp.Brand   = nvmoddes1 . /*ยี่ห้อ*/                                                           
        END.                                                                                                      

        /*--หารหัสรถ--*/
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                  sicuw.uwm120.policy =  aycldeto_fil.policy AND
                  sicuw.uwm120.rencnt =  sicuw.uwm100.rencnt AND 
                  sicuw.uwm120.endcnt =  sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm120 THEN DO:

            certmp.Class = TRIM(SUBSTR(sicuw.uwm120.class,2,3)).

        END.

        /*--หา Endorse Text by Nipawadee R. A53-0239--*/
        nv_fptr = uwm100.fptr05. 
        nv_bptr = uwm100.bptr05. 

        DO WHILE nv_fptr <> 0 AND uwm100.fptr05 <> ? :

        /* FIND FIRST sicuw.uwd104 WHERE A53-0312 */
            FIND LAST sicuw.uwd104 WHERE  
                /*uwd104.endcnt = uwm100.endcnt AND A53-0312*/
                RECID(uwd104) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAIL uwd104 THEN DO:
                nv_Covtext1 = nv_Covtext1 + uwd104.ltext.
                nv_fptr = uwd104.fptr. 
            END.

        END.
        
        certmp.Covtext1 = SUBSTRING(nv_Covtext1,1,30).   /*ตัดบรรทัดที่1 -to--A53-0239*/
        certmp.Covtext2 = SUBSTRING(nv_Covtext1,31,30).  /*ตัดบรรทัดที่2--to-A530-239*/
        certmp.Covtext3 = SUBSTRING(nv_Covtext1,61,100). /*ตัดบรรทัดที่3--to-A53-0239*/
        certmp.Covtext4 = SUBSTRING(nv_Covtext1,91,LENGTH(nv_Covtext1)).
        
        nv_Covtext1 = "".

        /* Comment by Nipawadee R. to A53-0312
        --หาเวลาเพื่อออกเลขที่ออกรายงาน ใน Report by Nipawadee R. A53-0239--*/
        /*nv_time = SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2).  
        Certmp.EntTim = "_" + nv_time. */

        /*Add by Nipawadee R. 01/10/2010 A53-0312 เปลี่ยนแปลง Field เลขทั่ออกรายงาน*/

        nv_codtime = SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +         
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +           
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2). 

        Certmp.Covtext5 = "_" + nv_codtime.  /*เลขที่ออกรายงาน*/                                                                     
            
    END. /*find first sicuw.uwm100*/   
    /*Lukkana M. A55-0209 06/07/2012*/
    ELSE DO: /*ถ้าไม่เจอ*/
        ASSIGN
            nv_name     = ""        
            nv_comd     = 0                             nv_comm     = 0
            nv_comy     = 0                             nv_expd     = 0
            nv_expm     = 0                             nv_expy     = 0
            nv_com_dat  = ?                             nv_exp_dat  = ?
            nv_com_dat1 = ""                            nv_exp_dat1 = ""
            nv_com_dat1 = '25' + aycldeto_fil.comdat    nv_exp_dat1 = '25' + aycldeto_fil.expdat
            n_si        = 0                             n_si1       = ""
            n_si2       = 0                             n_prem      = 0
            n_prem1     = ""                            n_prem2     = 0
            n_pretot    = 0                             n_pretot1   = ""
            n_pretot2   = 0.

        ASSIGN
            nv_name   = TRIM(aycldeto_fil.ntitle) + TRIM(aycldeto_fil.fname) + " " + TRIM(aycldeto_fil.lname)
            n_si      = LENGTH(aycldeto_fil.si)
            n_si1     = SUBSTR(aycldeto_fil.si,1,n_si - 2) + "." + SUBSTR(aycldeto_fil.si,n_si - 1,2)
            n_si2     = DECI(n_si1)
            n_prem    = LENGTH(aycldeto_fil.prem)
            n_prem1   = SUBSTR(aycldeto_fil.prem,1,n_prem - 2) + "." + SUBSTR(aycldeto_fil.prem,n_prem - 1,2)
            n_prem2   = DECI(n_prem1)
            n_pretot  = LENGTH(aycldeto_fil.premtot)
            n_pretot1 = SUBSTR(aycldeto_fil.premtot,1,n_pretot - 2) + "." + SUBSTR(aycldeto_fil.premtot,n_pretot - 1,2)
            n_pretot2 = DECI(n_pretot1).

        /*Lukkana M. A55-0244 30/07/2012*/
        IF aycldeto_fil.comdat <> "000000" THEN DO: 
            
            ASSIGN
                nv_comd   = INTE(SUBSTRING(nv_com_dat1,7,2))
                nv_comm   = INTE(SUBSTRING(nv_com_dat1,5,2))
                nv_comy   = INTE(SUBSTRING(nv_com_dat1,1,4)) - 543.

            nv_com_dat = DATE(nv_comm,nv_comd,nv_comy).
        END.
        ELSE nv_com_dat = ? .

        IF aycldeto_fil.expdat <> "000000" THEN DO: 
            ASSIGN
                nv_expd   = INTE(SUBSTRING(nv_exp_dat1,7,2))
                nv_expm   = INTE(SUBSTRING(nv_exp_dat1,5,2))
                nv_expy   = INTE(SUBSTRING(nv_exp_dat1,1,4)) - 543.

            nv_exp_dat = DATE(nv_expm,nv_expd,nv_expy).

        END.
        ELSE nv_exp_dat = ?.
        /*Lukkana M. A55-0244 30/07/2012*/
        ASSIGN n_branchaycl = aycldeto_fil.prodcode.  /*A57-0371*/
        RUN proc_matbranch.   /*A57-0371*/

        nv_row1 = nv_row1 + 1.   /*detail*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X1;K"  '"'   aycldeto_fil.rseqno                     '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X2;K"  '"'   n_branchsty            FORMAT "X(45)"    '"' SKIP.  /*A57-0371*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X3;K"  '"'   nv_name                FORMAT "X(40)"   '"' SKIP.   /*Lukkana M. A55-0244 30/07/2012*/
        IF nv_com_dat <> ? THEN 
             PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   nv_com_dat        FORMAT "99/99/9999"    '"' SKIP.
        ELSE PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   aycldeto_fil.comdat        '"' SKIP.     

        IF nv_exp_dat <> ? THEN                                                                           
             PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   nv_exp_dat        FORMAT "99/99/9999"    '"' SKIP.
        ELSE PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   aycldeto_fil.expdat        '"' SKIP.
        /*Lukkana M. A55-0244 30/07/2012*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X6;K"  '"'   aycldeto_fil.yrmanu  FORMAT "X(10)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X7;K"  '"'   aycldeto_fil.brand   FORMAT "X(10)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X8;K"  '"'   aycldeto_fil.vehreg  FORMAT "X(15)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X9;K"  '"'   aycldeto_fil.cha_no  FORMAT "X(40)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X10;K"  '"'   aycldeto_fil.eng_no  FORMAT "X(40)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X11;K" '"'   n_si2     FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X12;K" '"'   n_prem2   FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X13;K" '"'   n_pretot2 FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X14;K" '"'   aycldeto_fil.remark FORMAT "X(60)"                      '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X15;K" '"'   TRIM(SUBSTR(aycldeto_fil.remark,100,12)) FORMAT "X(12)" '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X16;K" '"'   TRIM(SUBSTR(aycldeto_fil.remark,120,10)) FORMAT "X(10)" '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
        
    END.
    /*Lukkana M. A55-0209 06/07/2012*/
  
 END.  /*--For each--*/  
 
 RELEASE aycldeto_fil.

 /*Lukkana M. A55-0209 06/07/2012*/
 PAGE STREAM ns1.
 PUT STREAM ns1 "E" SKIP.
 OUTPUT STREAM ns1 CLOSE.
 /*Lukkana M. A55-0209 06/07/2012*/
END.
 end.  comment by kridtiya i. A58-0121......new pd_create-certmp2*/
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create-certmp2 WGWAYCL1 
PROCEDURE pd_create-certmp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main.
 DEF VAR nv_name AS CHAR.
 DEF VAR nv_comd AS INTE.
 DEF VAR nv_comm AS INTE.
 DEF VAR nv_comy AS INTE.
 
 DEF VAR nv_expd AS INTE.
 DEF VAR nv_expm AS INTE.
 DEF VAR nv_expy    AS INTE.
 DEF VAR nv_com_dat AS DATE.
 DEF VAR nv_exp_dat AS DATE.
 DEF VAR nv_com_dat1 AS CHAR.
 DEF VAR nv_exp_dat1 AS CHAR.
 DEF VAR n_si        AS INTE.
 DEF VAR n_si1       AS CHAR.
 DEF VAR n_si2       AS DECI.
 DEF VAR n_prem      AS INTE.
 DEF VAR n_prem1     AS CHAR.
 DEF VAR n_prem2     AS DECI.
 DEF VAR n_pretot    AS INTE.
 DEF VAR n_pretot1   AS CHAR.
 DEF VAR n_pretot2   AS DECI.
 outfile2 = "C:\TEMP\" + INPUT fi_bchprev + "(ไม่พบข้อมูล)" + ".SLK" .                   
 OUTPUT STREAM ns1 TO VALUE(outfile2).
 PUT STREAM ns1 "ID;PND"  SKIP.
 ASSIGN 
     nv_row1 = 0              /* A57-0291 */
     nv_row1 = nv_row1 + 1.   /*HEAD*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X1;K"  '"'   "ลำดับที่"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X2;K"  '"'   "สาขา Aycal"      '"' SKIP.  /*A57-0371*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X3;K"  '"'   "ชื่อ-นามสกุล"    '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   "วันที่คุ้มครอง"  '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   "วันที่สิ้นสุด"   '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X6;K"  '"'   "ปีประกัน"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X7;K"  '"'   "ชื่อรถยนต์"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X8;K"  '"'   "เลขทะเบียน"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X9;K"  '"'   "เลขตัวถัง"       '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X10;K" '"'   "เลขเครื่องยนต์"  '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X11;K" '"'   "ทุนประกัน"       '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X12;K" '"'   "เบี้ยสุทธิ"      '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X13;K" '"'   "เบี้ยรวม"        '"' SKIP.
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X14;K" '"'   "หมายเหตุ"        '"' SKIP.

 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X15;K" '"'   "กรมธรรม์"       '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
 PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X16;K" '"'   "Producer Code"  '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/

 FOR EACH aycldeto2_fil  WHERE
          aycldeto2_fil.bchyr  = INPUT fi_bchyr   AND   /*nv_bchyr*/ 
          aycldeto2_fil.bchno  = INPUT fi_bchprev AND   /*nv_bchno*/ 
          aycldeto2_fil.bchcnt = INPUT fi_bchcnt  AND   /*nv_bchcnt*/
         (aycldeto2_fil.rectyp <> "H"       AND         /*Header*/    
          aycldeto2_fil.rectyp <> "T" )     NO-LOCK     /*Total*/ 
     BREAK BY aycldeto2_fil.rseqno:

    FIND LAST sicuw.uwm100 WHERE 
              sicuw.uwm100.policy = aycldeto2_fil.policy AND
              sicuw.uwm100.releas = YES  NO-LOCK NO-ERROR.
                       
    IF AVAIL sicuw.uwm100 THEN DO:
       CREATE certmp.     
          ASSIGN      
              certmp.YearReg  = INT(aycldeto2_fil.rseqno)   
              certmp.polno    = aycldeto2_fil.policy
              certmp.Branch   = aycldeto2_fil.prodcode  
              certmp.rencnt   = sicuw.uwm100.rencnt /*A53-0312*/
              certmp.endcnt   = sicuw.uwm100.endcnt /*A53-0312*/
              certmp.Agent    = sicuw.uwm100.acno1 
              certmp.institle = sicuw.uwm100.ntitle 
              certmp.ComDate  = sicuw.uwm100.comdat /*เพิ่มยึดวัน Comdat ตามระบบ Nipawadee R. A53-0239*/
              certmp.ExpDat   = sicuw.uwm100.expdat /*เพิ่มยึดวัน expdat ตามระบบ Nipawadee R. A53-0239**/ 
              certmp.Fname    = sicuw.uwm100.name1                
              certmp.Lname    = sicuw.uwm100.name2
              certmp.effdate  = sicuw.uwm100.accdat
              certmp.Modno    = aycldeto2_fil.model                                           
              certmp.PAText1  = TRIM(aycldeto2_fil.yrmanu)        
              /* Comment by Nipawadee to A53-0380
              certmp.Premium  = sicuw.uwm100.prem_t
              certmp.Simax    = certmp.Premium + uwm100.rstp_t + uwm100.rtax_t  */         
               
              certmp.RenPol   = sicuw.uwm100.endno        
              /*certmp.progid   = "WGWAYCL1" . A53-0312 */
              Certmp.Progid  = nv_progid2   /*A53-0312*/
              Certmp.usrid   = nv_useid     /*A53-0312*/
              Certmp.entdat  = nv_entdat    /*A53-0312*/
              Certmp.enttim  = nv_enttime . /*A53-0312*/
              
          /* Add by Nipwadee R. 01/12/2010  A53-0380*/
              nv_prem1  = LENGTH(aycldeto2_fil.prem).                                                                     
              nv_prem2  = SUBSTR(aycldeto2_fil.prem,1,nv_prem1 - 2) + "." + SUBSTR(aycldeto2_fil.prem,nv_prem1 - 1,2).     
              nv_prem3  = DECI(nv_prem2).           

              certmp.Premium  = nv_prem3 .
              
              nv_premto1 = LENGTH(aycldeto2_fil.premtot).                                                                       
              nv_premto2 = SUBSTR(aycldeto2_fil.premtot,1,nv_premto1 - 2) + "." + SUBSTR(aycldeto2_fil.premtot,nv_premto1 - 1,2). 
              nv_premto3 = DECI(nv_premto2).    

              certmp.Simax    = nv_premto3 .
              
              nv_premsi1 = LENGTH(aycldeto2_fil.si).    
              nv_premsi2 = SUBSTR(aycldeto2_fil.si,1,nv_premsi1 - 2) + "." + SUBSTR(aycldeto2_fil.si,nv_premsi1 - 1,2).    
              nv_premsi3 = DECI(nv_premsi2).

              certmp.NetPrm = nv_premsi3. 
              
        
        /*End add by Nipawadee R. 01/12/2010  A53-0380*/
      
       /* Comment by Nipawadee R. 08/10/2010   /*--สูญหายไฟไหม้--*/
       nv_premsi1  = LENGTH(aycldeto2_fil.si). 
       nv_premsi2  = SUBSTR(aycldeto2_fil.si,1,nv_premsi1 - 2) + "." + SUBSTR(aycldeto2_fil.si,nv_premsi1 - 1,2).
       nv_premsi3  = DECI(nv_premsi2).
       /*--หาเบี้ยสุทธิ--*/
       nv_prem1  = LENGTH(aycldeto2_fil.prem). 
       nv_prem2  = SUBSTR(aycldeto2_fil.prem,1,nv_prem1 - 2) + "." + SUBSTR(aycldeto2_fil.prem,nv_prem1 - 1,2).
       nv_prem3  = DECI(nv_prem2).
      
       /*--หาเบี้ยรวม--*/
       nv_premto1 = LENGTH(aycldeto2_fil.premtot).
       nv_premto2 = SUBSTR(aycldeto2_fil.premtot,1,nv_premto1 - 2) + "." + SUBSTR(aycldeto2_fil.premto,nv_premto1 - 1,2).
       nv_premto3 = DECI(nv_premto2).
    
      /*-หา Comdate-*/
        IF aycldeto2_fil.comdat <> "000000" THEN DO: 

            ASSIGN
             nv_comyea    = ""
             nv_common    = ""
             nv_comday    = ""
             nv_comyea1   = 0
             nv_comdate1  = ""
             nv_comdate2  = ? .
          nv_comyea  = SUBSTR(aycldeto2_fil.comdat,1,2).                                                           
          nv_common  = SUBSTR(aycldeto2_fil.comdat,3,2).                                                           
          nv_comday  = SUBSTR(aycldeto2_fil.comdat,5,2).                                                           

          nv_comyea1  = INTE("25" + nv_comyea) - 543.

          nv_comdate1 = STRING(nv_comday,"99") + "/" + STRING(nv_common,"99") + "/" + STRING(nv_comyea1,"9999").

          nv_comdate2 = DATE(nv_comdate1).
        END.
        /*-หา Expdat-*/
        IF aycldeto2_fil.expdat <> "000000" THEN DO:
    
            ASSIGN
              nv_comyea    = ""
              nv_common    = ""
              nv_comday    = ""
              nv_comyea1   = 0
              nv_comdate1  = ""
              nv_comdate2  = ? .
           nv_comyea  = SUBSTR(aycldeto2_fil.comdat,1,2).                                                           
           nv_common  = SUBSTR(aycldeto2_fil.comdat,3,2).                                                           
           nv_comday  = SUBSTR(aycldeto2_fil.comdat,5,2).                                                           
                                                                                                                
           nv_comyea1  = INTE("25" + nv_comyea) - 543.
          
           nv_comdate1 = STRING(nv_comday,"99") + "/" + STRING(nv_common,"99") + "/" + STRING(nv_comyea1,"9999").
           
           nv_comdate2 = DATE(nv_comdate1).

           /*certmp.expDat = nv_comdate2.Comment by A53-0239*/ 
           
        END. /*-Exdate-*/   Comment to A53-0312 */
       /* A53-0312
       FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
       sicuw.uwm130.policy = certmp.polno   NO-LOCK NO-ERROR.*/

        /*--เบี้ยสุญหายไฟใหม้ เดิมยึดของ Text file นำเข้า-A53-0239-*/
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                  sicuw.uwm130.policy = aycldeto2_fil.policy AND /**/
                  sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                  sicuw.uwm130.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm130  THEN DO:
            ASSIGN
               certmp.Tax    = DECI(sicuw.uwm130.uom1_V)   /*ความรับผิดชอบต่อบุคคล ต่อ/คน  A53-0239*/
               certmp.Stamp  = DECI(sicuw.uwm130.uom2_V)  /*ความรับผิดชอบต่อบุคคล ต่อ/ครั้ง A53-0239*/
               certmp.Simin  = DECI(sicuw.uwm130.uom5_V) . /*ความรับผิดชอบต่อบุคคล ต่อ/ครั้ง  A53-0239*/
             /*  certmp.NetPrm = DECI(sicuw.uwm130.uom7_v). */ 

        END.
        
        /*--หาประเภทรถ--*/ 
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                  sicuw.uwm301.policy = aycldeto2_fil.policy AND
                  sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND             
                  sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.     
        IF AVAIL sicuw.uwm301 THEN DO:

           i_index = INDEX(uwm301.moddes," ") - 1.                                                               
           nvmoddes1 = SUBSTR(uwm301.moddes,1,i_index).                                                          
                                                                                                                 
           ASSIGN                                                                                                
               certmp.Regno   = sicuw.uwm301.vehreg /*เลขทะเบียน*/                                               
               certmp.Bodyno  = TRIM(sicuw.uwm301.cha_no) /*เลขตัวถัง*/                                          
               certmp.PreBody = TRIM(sicuw.uwm301.vehuse)                                                        
               certmp.Engno   = TRIM(sicuw.uwm301.eng_no)                                                                                                          
               certmp.Brand   = nvmoddes1 . /*ยี่ห้อ*/                                                           
        END.                                                                                                      

        /*--หารหัสรถ--*/
        /*-เพิ่ม Check Renew-Endos  A53-0312 -*/
        FIND LAST sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                  sicuw.uwm120.policy =  aycldeto2_fil.policy AND
                  sicuw.uwm120.rencnt =  sicuw.uwm100.rencnt AND 
                  sicuw.uwm120.endcnt =  sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm120 THEN DO:

            certmp.Class = TRIM(SUBSTR(sicuw.uwm120.class,2,3)).

        END.

        /*--หา Endorse Text by Nipawadee R. A53-0239--*/
        nv_fptr = uwm100.fptr05. 
        nv_bptr = uwm100.bptr05. 

        DO WHILE nv_fptr <> 0 AND uwm100.fptr05 <> ? :

        /* FIND FIRST sicuw.uwd104 WHERE A53-0312 */
            FIND LAST sicuw.uwd104 WHERE  
                /*uwd104.endcnt = uwm100.endcnt AND A53-0312*/
                RECID(uwd104) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAIL uwd104 THEN DO:
                nv_Covtext1 = nv_Covtext1 + uwd104.ltext.
                nv_fptr = uwd104.fptr. 
            END.

        END.
        
        certmp.Covtext1 = SUBSTRING(nv_Covtext1,1,30).   /*ตัดบรรทัดที่1 -to--A53-0239*/
        certmp.Covtext2 = SUBSTRING(nv_Covtext1,31,30).  /*ตัดบรรทัดที่2--to-A530-239*/
        certmp.Covtext3 = SUBSTRING(nv_Covtext1,61,100). /*ตัดบรรทัดที่3--to-A53-0239*/
        certmp.Covtext4 = SUBSTRING(nv_Covtext1,91,LENGTH(nv_Covtext1)).
        
        nv_Covtext1 = "".

        /* Comment by Nipawadee R. to A53-0312
        --หาเวลาเพื่อออกเลขที่ออกรายงาน ใน Report by Nipawadee R. A53-0239--*/
        /*nv_time = SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2).  
        Certmp.EntTim = "_" + nv_time. */

        /*Add by Nipawadee R. 01/10/2010 A53-0312 เปลี่ยนแปลง Field เลขทั่ออกรายงาน*/

        nv_codtime = SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +         
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +           
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2). 

        Certmp.Covtext5 = "_" + nv_codtime.  /*เลขที่ออกรายงาน*/                                                                     
            
    END. /*find first sicuw.uwm100*/   
    /*Lukkana M. A55-0209 06/07/2012*/
    ELSE DO: /*ถ้าไม่เจอ*/
        ASSIGN
            nv_name     = ""        
            nv_comd     = 0                             nv_comm     = 0
            nv_comy     = 0                             nv_expd     = 0
            nv_expm     = 0                             nv_expy     = 0
            nv_com_dat  = ?                             nv_exp_dat  = ?
            nv_com_dat1 = ""                            nv_exp_dat1 = ""
            nv_com_dat1 = '25' + aycldeto2_fil.comdat    nv_exp_dat1 = '25' + aycldeto2_fil.expdat
            n_si        = 0                             n_si1       = ""
            n_si2       = 0                             n_prem      = 0
            n_prem1     = ""                            n_prem2     = 0
            n_pretot    = 0                             n_pretot1   = ""
            n_pretot2   = 0.

        ASSIGN
            nv_name   = TRIM(aycldeto2_fil.ntitle) + TRIM(aycldeto2_fil.fname) + " " + TRIM(aycldeto2_fil.lname)
            n_si      = LENGTH(aycldeto2_fil.si)
            n_si1     = SUBSTR(aycldeto2_fil.si,1,n_si - 2) + "." + SUBSTR(aycldeto2_fil.si,n_si - 1,2)
            n_si2     = DECI(n_si1)
            n_prem    = LENGTH(aycldeto2_fil.prem)
            n_prem1   = SUBSTR(aycldeto2_fil.prem,1,n_prem - 2) + "." + SUBSTR(aycldeto2_fil.prem,n_prem - 1,2)
            n_prem2   = DECI(n_prem1)
            n_pretot  = LENGTH(aycldeto2_fil.premtot)
            n_pretot1 = SUBSTR(aycldeto2_fil.premtot,1,n_pretot - 2) + "." + SUBSTR(aycldeto2_fil.premtot,n_pretot - 1,2)
            n_pretot2 = DECI(n_pretot1).

        /*Lukkana M. A55-0244 30/07/2012*/
        IF aycldeto2_fil.comdat <> "000000" THEN DO: 
            
            ASSIGN
                nv_comd   = INTE(SUBSTRING(nv_com_dat1,7,2))
                nv_comm   = INTE(SUBSTRING(nv_com_dat1,5,2))
                nv_comy   = INTE(SUBSTRING(nv_com_dat1,1,4)) - 543.

            nv_com_dat = DATE(nv_comm,nv_comd,nv_comy).
        END.
        ELSE nv_com_dat = ? .

        IF aycldeto2_fil.expdat <> "000000" THEN DO: 
            ASSIGN
                nv_expd   = INTE(SUBSTRING(nv_exp_dat1,7,2))
                nv_expm   = INTE(SUBSTRING(nv_exp_dat1,5,2))
                nv_expy   = INTE(SUBSTRING(nv_exp_dat1,1,4)) - 543.

            nv_exp_dat = DATE(nv_expm,nv_expd,nv_expy).

        END.
        ELSE nv_exp_dat = ?.
        /*Lukkana M. A55-0244 30/07/2012*/
        ASSIGN n_branchaycl = aycldeto2_fil.prodcode.  /*A57-0371*/
        RUN proc_matbranch.   /*A57-0371*/

        nv_row1 = nv_row1 + 1.   /*detail*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X1;K"  '"'   aycldeto2_fil.rseqno                     '"' SKIP. 
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X2;K"  '"'   n_branchsty            FORMAT "X(45)"    '"' SKIP.  /*A57-0371*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X3;K"  '"'   nv_name                FORMAT "X(40)"   '"' SKIP.   /*Lukkana M. A55-0244 30/07/2012*/
        IF nv_com_dat <> ? THEN 
             PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   nv_com_dat        FORMAT "99/99/9999"    '"' SKIP.
        ELSE PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X4;K"  '"'   aycldeto2_fil.comdat        '"' SKIP.     

        IF nv_exp_dat <> ? THEN                                                                           
             PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   nv_exp_dat        FORMAT "99/99/9999"    '"' SKIP.
        ELSE PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X5;K"  '"'   aycldeto2_fil.expdat        '"' SKIP.
        /*Lukkana M. A55-0244 30/07/2012*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X6;K"  '"'   aycldeto2_fil.yrmanu  FORMAT "X(10)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X7;K"  '"'   aycldeto2_fil.brand   FORMAT "X(10)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X8;K"  '"'   aycldeto2_fil.vehreg  FORMAT "X(15)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X9;K"  '"'   aycldeto2_fil.cha_no  FORMAT "X(40)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X10;K"  '"'   aycldeto2_fil.eng_no  FORMAT "X(40)"                     '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X11;K" '"'   n_si2     FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X12;K" '"'   n_prem2   FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X13;K" '"'   n_pretot2 FORMAT ">>>>>>>>>9.99"                        '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X14;K" '"'   aycldeto2_fil.remark FORMAT "X(60)"                      '"' SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X15;K" '"'   TRIM(SUBSTR(aycldeto2_fil.remark,100,12)) FORMAT "X(12)" '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
        PUT STREAM ns1 "C;Y" STRING(nv_row1) ";X16;K" '"'   TRIM(SUBSTR(aycldeto2_fil.remark,120,10)) FORMAT "X(10)" '"' SKIP. /*Lukkana M. A55-0244 03/08/2012*/
        
    END.
  
 END.  /*--For each--*/  
 
 RELEASE aycldeto2_fil.

 /*Lukkana M. A55-0209 06/07/2012*/
 PAGE STREAM ns1.
 PUT STREAM ns1 "E" SKIP.
 OUTPUT STREAM ns1 CLOSE.
 /*Lukkana M. A55-0209 06/07/2012*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_guaran_file WGWAYCL1 
PROCEDURE pd_guaran_file :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Output to excel file by Nipawadee R. Garuntee Report      
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main.
   /*DEF VAR outfile      AS CHAR. Lukkana M. A55-0175 07/06/2012*/
   DEF VAR nv_row       AS INTE.
   DEF VAR nv_bran      AS CHAR.
   DEF VAR nv_count     AS INTE.
   DEF VAR nv_ToNetP    AS DECI FORMAT ">>>,>>>,>>>,>>9.99".
   DEF VAR nv_ToSi      AS DECI FORMAT ">>>,>>>,>>>,>>9.99".    
   DEF VAR nv_ToPre     AS DECI FORMAT ">>>,>>>,>>>,>>9.99".   
   DEF VAR nv_cnt       AS INTE.

   /*Lukkana M. A55-0175 07/06/2012*/
   outfile1 = "C:\TEMP\" + INPUT fi_bchprev + "Gua_excel" + ".SLK" .                   
   OUTPUT STREAM ns1 TO VALUE(outfile1).
   /*Lukkana M. A55-0175 07/06/2012*/

   /*outfile = n_filename + ".SLK". 
   OUTPUT STREAM ns1 TO VALUE(outfile).Lukkana M. A55-0175 07/06/2012*/
   IF ra_typtitle = 1 THEN DO:   /* A57-0062 add A57-0062 add ra_typtitle = AYCAL */
       PUT STREAM ns1 "ID;PND"  SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "บริษัท ประกันคุ้มกัย จำกัด (มหาชน)"       '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ผู้รับผลประโยชน์ บริษัท อยุธยา แคปปิตอล  ออโต้ ลีส จำกัด (มหาชน)"   '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       /*PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ที่อยู่ สำนักงานใหญ่ เลขที่87/1 อาคารแคปปิตอล ทาวเวอร์ ชั้น 3"      '"' SKIP./*A57-0371*/
       nv_row = nv_row + 1.   /*HEAD*/                                                                                                   /*A57-0371*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "และ เลขที่ 87/2 อาคาร ซี อาร์ ที ทาวเวอร์ ชั้น 30 ออลซีซั่นส์เพลส"  '"' SKIP.*//*A57-0371*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ที่อยู่ สำนักงานใหญ่ เลขที่ 87/2 อาคารซี อาร์ ซี ทาวเวอร์ ชั้น 26, 30 และ 48 ออลซีซั่นส์ เพลส"  '"' SKIP.  /*A57-0371*/
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ถนนวิทยุ แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330"                     '"' SKIP. 
       nv_cnt = 0.
   END.
   ELSE DO:
       PUT STREAM ns1 "ID;PND"  SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "บริษัท ประกันคุ้มกัย จำกัด (มหาชน)"       '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ผู้รับผลประโยชน์ ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)"   '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ที่อยู่ 1222 ถนนพระรามที่ 3 แขวงบางโพงพาง"      '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "เขตยานนาวา กรุงเทพมหานคร 10120"  '"' SKIP.
       nv_row = nv_row + 1.   /*HEAD*/
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   ""                     '"' SKIP. 
       nv_cnt = 0.
   END. 
   /*end.....add A57-0062 add ra_typtitle = BAY */
   /*Nipawadee R. Comment 01/10/2010 FOR EACH certmp WHERE Certmp.ProgID = "WGWAYCL1" */

   FOR EACH certmp USE-INDEX certmp01
                   WHERE Certmp.Progid  = nv_progid2    
                   AND   Certmp.usrid   = nv_useid      
                   AND   Certmp.entdat  = nv_entdat     
                   AND   Certmp.enttim  = nv_enttime NO-LOCK 
     BREAK BY certmp.Branch BY certmp.YearReg.

      IF FIRST-OF(certmp.Branch) THEN DO:

         IF nv_cnt = 0 THEN DO: /*Put-HEAD-เฉพาะสาขาครั้งแรก--*/
             nv_row = nv_row + 1.   /*HEAD*/
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "สาขา" + certmp.Branch  FORMAT "X(25)" '"' SKIP. 
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K" '"'   "เลขที่กธ.สมัครใจ"         '"' SKIP.
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K" '"'   "รหัสตัวแทน"               '"' SKIP.
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K" '"'   "ชื่อ/นามสกุล"             '"' SKIP.
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K" '"'   "วันที่ทำสัญญา"            '"' SKIP.
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K" '"'   "วันที่คุ้มครอง"           '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K" '"'   "วันที่สิ้นสุด"            '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K" '"'   "ประเภท"                   '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K" '"'   "ปีประกัน"                 '"' SKIP. 
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"'  "รหัสรถยนต์"               '"' SKIP. 
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"'  "ชื่อรถยนต์"               '"' SKIP. 
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"'  "เลขทะเบียน"               '"' SKIP.   
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"'  "เลขตัวถัง"                '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"'  "เลขเครื่องยนต์"           '"' SKIP.
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"'  "ความรับผิดชอบต่อบุคคลภายนอก"  '"' SKIP.  /*add by Niipawadee R. A53-0239*/
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"'  "เสียหายสูญหายไฟไหม้"      '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"'  "เบี้ยรวม"                 '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"'  "เบี้ยสุทธิ"               '"' SKIP.             
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"'  "เลขสลักหลัง"              '"' SKIP.  
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"'  "เรื่องที่สลักหลัง"        '"' SKIP. /*add by Niipawadee R. A53-0239*/

             nv_row = nv_row + 1.                                                         
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ลำดับที่"                 '"' SKIP.  
             nv_cnt = nv_cnt + 1.

         END.
         ELSE DO:
             nv_row = nv_row + 1. /*HEAD*/
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "สาขา" + certmp.Branch  FORMAT "X(25)" '"' SKIP. 
             nv_row = nv_row + 1.                                                         
             PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K" '"'   "ลำดับที่"                 '"' SKIP.
         END.
      END.
   
      nv_row = nv_row + 1.                                                                  
      /*PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' certmp.YearReg   FORMAT "999"       '"' SKIP. Lukkana M. A55-0209 05/07/2012*/
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' certmp.YearReg   FORMAT ">>>>>9"       '"' SKIP. /*Lukkana M. A55-0209 05/07/2012*/
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"' certmp.polno                                 '"' SKIP.
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' certmp.Agent                                 '"' SKIP.
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"' certmp.Institle + certmp.Fname FORMAT "X(80)" '"' SKIP.
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"' certmp.effdate   FORMAT "99/99/9999"         '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"' certmp.ComDate   FORMAT "99/99/9999"         '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"' certmp.ExpDate   FORMAT "99/99/9999"         '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"' certmp.PreBody                               '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"' certmp.PAText1                               '"' SKIP.              
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"' certmp.Class                                 '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"' certmp.Brand                                 '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"' certmp.Regno                                 '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"' certmp.Bodyno                                '"' SKIP.               
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"' certmp.Engno                                 '"' SKIP.
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"' certmp.simin   FORMAT ">,>>>,>>>,>>>,>>9.99" + " " + "/คน"  '"'   SKIP.  /*add by Niipawadee R. A53-0239*/                                                      
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"' certmp.NetPrm                                '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"' certmp.Simax                                 '"' SKIP.                    
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"' certmp.Premium                               '"' SKIP.   
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"' certmp.RenPol                                '"' SKIP. 

      /*----เพิ่มเรื่องที่สลักหลัง By Nipawadee R. 16 /08/2010 to A530239----*/
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"' certmp.Covtext1 + certmp.Covtext2 + certmp.Covtext3  FORMAT "X(200)" '"' SKIP. 
      nv_row = nv_row + 1.                             
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"' certmp.stamp  FORMAT ">,>>>,>>>,>>>,>>9.99" + " " + "/ครั้ง " '"'   SKIP.  
      nv_row = nv_row + 1.                              
      PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"' certmp.Tax    FORMAT ">,>>>,>>>,>>>,>>9.99" + " " + "/ครั้ง " '"'   SKIP.    
      /*----เพิ่มเรื่องที่สลักหลัง By Nipawadee R. 16 /08/2010 to A530239----*/
     ASSIGN
          nv_ToNetP = nv_ToNetP + certmp.NetPrm .          
          nv_ToSi   = nv_ToSi  +  certmp.Simax.        
          nv_ToPre  = nv_ToPre +  certmp.Premium. 
       
      IF LAST-OF(certmp.Branch) THEN DO:

          nv_row = nv_row + 1.
          PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' "รวม"     '"' SKIP.
          PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"' nv_ToNetP '"' SKIP.          
          PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"' nv_ToSi   '"' SKIP.           
          PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"' nv_ToPre  '"' SKIP.   

        ASSIGN
           nv_ToNetP = 0
           nv_ToSi   = 0
           nv_ToPre  = 0.                                          
      
      END. /* if-last*/ 
   END. /* For Each */
  
   PAGE STREAM ns1.
   PUT STREAM ns1 "E" SKIP.
   OUTPUT STREAM ns1 CLOSE.

   /*--
   MESSAGE "OUTPUT TEXT FILE Completed ..." SKIP
           "To file : " outfile VIEW-AS ALERT-BOX INFORMATION. 
   Lukkana M. A55-0175 07/06/2012*/        
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_guaran_print WGWAYCL1 
PROCEDURE pd_guaran_print :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Connect Database และ เรียกใช้ Filter Nipawadee R. [A53-0312] 
          แก้ไขครั้งที่ 2
          - เพิ่ม RB-INCLUDE-RECORDS 
          - แก้ไข RB-FILTER เนื่องจาก รายงานมี Line 30,90 ออกมาในรายงานด้วย   
------------------------------------------------------------------------------*/
/*Connect Database ส่งค่า RB - Connection*/
   FIND FIRST  dbtable WHERE dbtable.phyname = "form" OR dbtable.phyname = "formtmp"  NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL dbtable THEN DO:
         IF dbtable.phyname = "form" OR dbtable.phyname = "formtmp" THEN DO:
            /*ASSIGN 
                 nv_User  = "?"
                 nv_pwd   = "?". Lukkana M. A55-0175 23/05/2012 เปลี่ยนการส่งuserค่าว่าง*/
             RB-DB-CONNECTION = dbtable.unixpara.  /*Lukkana M. A55-0175 23/05/2012*/
         END.
         ELSE DO: 
            /*ASSIGN 
                 nv_User = n_user                     
                 nv_pwd  = n_passwd.  
                 RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.  Lukkana M. A55-0209 16/07/2012*/       
             /*RB-DB-CONNECTION  = dbtable.unixpara. /*Lukkana M. A55-0209 16/07/2012*/*//*kridtiya i.A57-0062*/  
             ASSIGN 
                 nv_User = n_user     /*kridtiya i.A57-0062*/                   
                 nv_pwd  = n_passwd   /*kridtiya i.A57-0062*/    
                 RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.  /*kridtiya i.A57-0062*/  
         END.
   END.
/*-- A59-0184 --*/
   ASSIGN
       nv_pic        = "wimage\suwanna_new.gif"      /* Signature Suwanna  */
       nv_Signature  = SEARCH(nv_pic) 
       nv_pic        = "wimage\stamp_c_new_n.gif"       /*Picture Stamp*/
       nv_pstamp     = SEARCH(nv_pic).

   /*  /*Version 9.1e file .JPG*/
   /*-- A59-0184 --*/
   ASSIGN
       nv_pic        = "wimage\suwanna_new.JPG"      /* Signature Suwanna  */
       nv_Signature  = SEARCH(nv_pic) 
       nv_pic        = "wimage\stamp_c_new.GIF"       /*Picture Stamp*/
       nv_pstamp     = SEARCH(nv_pic).
   
   */

   IF nv_Signature  = ? OR  nv_Signature  = "" THEN  nv_Signature  = "".
   IF  nv_pstamp    = ? OR  nv_pstamp     = "" THEN  nv_pstamp     = "".

   RB-OTHER-PARAMETERS   =
            "rb_logo     = " + nv_pstamp   + 
            "~nrb_image  = " + nv_Signature.
/*-- End A59-0184 --*/
   /*--Add เรียก Report  by Nipawadee R. A53-0312--*/ 
   ASSIGN

    RB-NO-WAIT  = NO
    /* Nipawadee R. 28/10/2010 RB-FILTER   = 'Certmp.UsrID  = ' + nv_useid + " AND " +
                  'CerTmp.EntDat = ' + STRING (MONTH (nv_entdat)) + "/" +       
                                       STRING (DAY (nv_entdat))   + "/" +         
                                       STRING (YEAR (nv_entdat))  + " AND " +    
                  'Certmp.ProgID = ' + nv_progid2 + " AND " +                                                                                           
     'CerTmp.EntTim = ' + nv_enttime . Comment to A53-0312 */
                                           
    RB-INCLUDE-RECORDS   = "O"

    RB-FILTER     = "CerTmp.Progid = '" + nv_Progid2 + "'" +       
                    " AND " +                                         
                    "CerTmp.Usrid = '" + nv_Useid + "'" +             
                    " AND " +                                         
                    " certmp.Entdat = " +                             
                    STRING (MONTH (nv_Entdat)) + "/" +                
                    STRING (DAY (nv_Entdat)) + "/" +                  
                    STRING (YEAR (nv_Entdat)) +                       
                    " AND " +                                         
                    "CerTmp.EntTim = '" + nv_EntTime + "'" .        
                      
    RB-PRINT-DESTINATION = n_destination . 
    IF ra_typtitle = 1 THEN ASSIGN report-name  = "AYCL01".  /*A57-0062*/
    ELSE ASSIGN report-name  = "AYCL02".                     /*A57-0062*/
    RUN aderb\_printrb(SEARCH (report-library), 
                            report-name,
                            RB-DB-CONNECTION,
                            RB-INCLUDE-RECORDS,
                            RB-FILTER,
                            RB-MEMO-FILE,
                            RB-PRINT-DESTINATION,
                            RB-PRINTER-NAME,
                            RB-PRINTER-PORT,
                            RB-OUTPUT-FILE,
                            RB-NUMBER-COPIES,
                            RB-BEGIN-PAGE,
                            RB-END-PAGE,
                            RB-TEST-PATTERN,
                            RB-WINDOW-TITLE,
                            RB-DISPLAY-ERRORS,
                            RB-DISPLAY-STATUS,
                            RB-NO-WAIT,
                            RB-OTHER-PARAMETERS).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matbranch WGWAYCL1 
PROCEDURE proc_matbranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF      n_branchaycl = "11" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".   
ELSE IF n_branchaycl = "12" THEN ASSIGN n_branchsty = "MC" .        
ELSE IF n_branchaycl = "13" THEN ASSIGN n_branchsty = "บางแค"       .   
ELSE IF n_branchaycl = "14" THEN ASSIGN n_branchsty = "บางนา"       .   
ELSE IF n_branchaycl = "15" THEN ASSIGN n_branchsty = "นนทบุรี"     .   
ELSE IF n_branchaycl = "16" THEN ASSIGN n_branchsty = "หลักสี่"     .   
ELSE IF n_branchaycl = "17" THEN ASSIGN n_branchsty = "บางใหญ่"     .   
ELSE IF n_branchaycl = "18" THEN ASSIGN n_branchsty = "รามอินทรา"   .  
ELSE IF n_branchaycl = "19" THEN ASSIGN n_branchsty = "เยาวราช  "   .  
ELSE IF n_branchaycl = "21" THEN ASSIGN n_branchsty = "สาขาขอนแก่น"      .
ELSE IF n_branchaycl = "22" THEN ASSIGN n_branchsty = "สาขานครราชสีมา "  .
ELSE IF n_branchaycl = "23" THEN ASSIGN n_branchsty = "สาขาอุดรธานี   "  .
ELSE IF n_branchaycl = "24" THEN ASSIGN n_branchsty = "สาขาอุบลราชธานี"  .
ELSE IF n_branchaycl = "25" THEN ASSIGN n_branchsty = "สาขาร้อยเอ็ด"     .
ELSE IF n_branchaycl = "26" THEN ASSIGN n_branchsty = "สาขาสกลนคร"       .
ELSE IF n_branchaycl = "27" THEN ASSIGN n_branchsty = "สาขาศรีสะเกษ"     .
ELSE IF n_branchaycl = "28" THEN ASSIGN n_branchsty = "สาขาสุรินทร์"     .
ELSE IF n_branchaycl = "31" THEN ASSIGN n_branchsty = "สาขาหาดใหญ่ "     .
ELSE IF n_branchaycl = "32" THEN ASSIGN n_branchsty = "สาขาสุราษฏร์ธานี" .
ELSE IF n_branchaycl = "33" THEN ASSIGN n_branchsty = "สาขาตรัง"         .
ELSE IF n_branchaycl = "34" THEN ASSIGN n_branchsty = "สาขาภูเก็ต"       .
ELSE IF n_branchaycl = "35" THEN ASSIGN n_branchsty = "สาขานครศรีธรรมราช". 
ELSE IF n_branchaycl = "36" THEN ASSIGN n_branchsty = "สาขาหาดใหญ่"      . 
ELSE IF n_branchaycl = "37" THEN ASSIGN n_branchsty = "สาขาชุมพร"        . 
ELSE IF n_branchaycl = "38" THEN ASSIGN n_branchsty = "สาขากระบี่"       . 
ELSE IF n_branchaycl = "41" THEN ASSIGN n_branchsty = "สาขาชลบุรี"       . 
ELSE IF n_branchaycl = "42" THEN ASSIGN n_branchsty = "สาขานครปฐม"       . 
ELSE IF n_branchaycl = "43" THEN ASSIGN n_branchsty = "สาขาระยอง"        . 
ELSE IF n_branchaycl = "44" THEN ASSIGN n_branchsty = "สาขาปราณบุรี"     . 
ELSE IF n_branchaycl = "45" THEN ASSIGN n_branchsty = "สาขาปราจีนบุรี"   . 
ELSE IF n_branchaycl = "46" THEN ASSIGN n_branchsty = "สาขาฉะเชิงเทรา"   . 
ELSE IF n_branchaycl = "47" THEN ASSIGN n_branchsty = "สาขาจันทบุรี"     . 
ELSE IF n_branchaycl = "51" THEN ASSIGN n_branchsty = "สาขาเชียงใหม่"    . 
ELSE IF n_branchaycl = "52" THEN ASSIGN n_branchsty = "สาขาพิษณุโลก"     . 
ELSE IF n_branchaycl = "53" THEN ASSIGN n_branchsty = "สาขานครสวรรค์"    . 
ELSE IF n_branchaycl = "54" THEN ASSIGN n_branchsty = "สาขาลำปาง"        . 
ELSE IF n_branchaycl = "55" THEN ASSIGN n_branchsty = "สาขาเชียงราย"     . 
ELSE IF n_branchaycl = "56" THEN ASSIGN n_branchsty = "สาขากำแพงเพชร"    . 
ELSE IF n_branchaycl = "57" THEN ASSIGN n_branchsty = "สาขาเพชรบูรณ์"    . 
ELSE IF n_branchaycl = "61" THEN ASSIGN n_branchsty = "สาขาปากช่อง "     . 
ELSE IF n_branchaycl = "62" THEN ASSIGN n_branchsty = "สาขายโสธร" .       
ELSE IF n_branchaycl = "63" THEN ASSIGN n_branchsty = "สาขามุกดาหาร".  
ELSE IF n_branchaycl = "64" THEN ASSIGN n_branchsty = "สาขาหนองคาย ".  
ELSE IF n_branchaycl = "69" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".  
ELSE IF n_branchaycl = "71" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".  
ELSE IF n_branchaycl = "73" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".  
ELSE IF n_branchaycl = "74" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".  
ELSE IF n_branchaycl = "82" THEN ASSIGN n_branchsty = "สำนักงานใหญ่".  
ELSE IF n_branchaycl = "83" THEN ASSIGN n_branchsty = "สระบุรี"     .  
ELSE IF n_branchaycl = "84" THEN ASSIGN n_branchsty = "อยุธยา"      .  
ELSE IF n_branchaycl = "91" THEN ASSIGN n_branchsty = "สวัสดิการ"   .  
ELSE ASSIGN n_branchsty = n_branchaycl.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputexcel WGWAYCL1 
PROCEDURE proc_outputexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A65-0115      
------------------------------------------------------------------------------*/
If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".csv"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".csv"  .
DISP fi_outputconv WITH FRAM fr_main.
OUTPUT TO VALUE(fi_outputconv).
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "H" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp             
        tgenerage.rseqno             
        tgenerage.prodcode           
        tgenerage.brncode            
        tgenerage.contno             
        tgenerage.ntitle .
END.
FOR EACH tgenerage NO-LOCK  
     WHERE tgenerage.rectyp  <> "H"  AND 
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .  
    EXPORT DELIMITER "|" 
        tgenerage.rectyp             
        tgenerage.rseqno             
        tgenerage.prodcode           
        tgenerage.brncode            
        tgenerage.contno             
        tgenerage.ntitle             
        tgenerage.fname              
        tgenerage.lname              
        tgenerage.addr1              
        tgenerage.addr2              
        tgenerage.addr3              
        tgenerage.postcd             
        tgenerage.ICNO               
        tgenerage.brand              
        tgenerage.model              
        tgenerage.CCOLOR             
        tgenerage.vehreg             
        tgenerage.province           
        tgenerage.yrmanu             
        tgenerage.engine             
        tgenerage.cha_no             
        tgenerage.eng_no             
        tgenerage.engine_typ         
        tgenerage.covcod             
        STRING(deci(tgenerage.prem_cus) / 100  ,">>>,>>>,>>9.99")    
        tgenerage.yrins                
        tgenerage.notify               
        tgenerage.Serialno             
        tgenerage.policy               
        tgenerage.comdat              
        tgenerage.expdat                      
        string(deci(tgenerage.si) / 100 ,">>>,>>>,>>9.99")                        
        string(deci(tgenerage.prem) / 100 ,">>>,>>>,>>9.99")                    
        string(deci(tgenerage.premtot) / 100 ,">>>,>>>,>>9.99")  .         
END.
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "T" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp             
        tgenerage.rseqno             
        tgenerage.prodcode           
        tgenerage.brncode            
        tgenerage.contno             
        tgenerage.ntitle   .   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputexcel_2 WGWAYCL1 
PROCEDURE proc_outputexcel_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A65-0115       
------------------------------------------------------------------------------*/

If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".csv"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".csv"  .
DISP fi_outputconv WITH FRAM fr_main.
OUTPUT TO VALUE(fi_outputconv).
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "H" .
    EXPORT DELIMITER "|" 
       tgenerage.rectyp             
       tgenerage.rseqno             
       tgenerage.prodcode           
       tgenerage.brncode            
       tgenerage.contno             
       tgenerage.ntitle .
END.
FOR EACH tgenerage NO-LOCK  
     WHERE tgenerage.rectyp  <> "H"  AND 
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .  
    EXPORT DELIMITER "|" 
        tgenerage.rectyp       
        tgenerage.rseqno       
        tgenerage.prodcode     
        tgenerage.brncode      
        tgenerage.contno       
        tgenerage.ntitle       
        tgenerage.fname        
        tgenerage.lname        
        tgenerage.addr1        
        tgenerage.addr2        
        tgenerage.addr3        
        tgenerage.postcd       
        tgenerage.ICNO         
        tgenerage.brand        
        tgenerage.model        
        tgenerage.CCOLOR       
        tgenerage.vehreg       
        tgenerage.province     
        tgenerage.yrmanu       
        tgenerage.engine       
        tgenerage.cha_no       
        tgenerage.eng_no       
        tgenerage.engine_typ   
        tgenerage.covcod       
        STRING(deci(tgenerage.prem_cus),">>>,>>>,>>9.99") 
        tgenerage.yrins    
        tgenerage.notify  
        tgenerage.Serialno 
        tgenerage.policy   
        tgenerage.comdat   
        tgenerage.expdat   
        string(deci(tgenerage.si),">>>,>>>,>>9.99")      
        string(deci(tgenerage.prem),">>>,>>>,>>9.99")            
        string(deci(tgenerage.premtot),">>>,>>>,>>9.99") .
END.
FOR EACH tgenerage NO-LOCK 
    WHERE tgenerage.rectyp  = "T" .
    EXPORT DELIMITER "|" 
        tgenerage.rectyp             
       tgenerage.rseqno             
       tgenerage.prodcode           
       tgenerage.brncode            
       tgenerage.contno             
       tgenerage.ntitle .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile WGWAYCL1 
PROCEDURE proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A65-0115      
------------------------------------------------------------------------------*/
def var n_si        as char .
def var n_prem      as char .
def var n_premtot   as char .

FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "H" NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
    PUT UNFORMATTED 
        TRIM(ayclhead2_fil.rectyp)    + "|" +
        TRIM(ayclhead2_fil.fseqno)    + "|" +
        TRIM(ayclhead2_fil.compno)    + "|" +
        TRIM(ayclhead2_fil.compins)   + "|" +
        TRIM(ayclhead2_fil.asofdat)   + "|" +
        TRIM(ayclhead2_fil.developno) + "" SKIP.  
END.
/**** Detail ****/
FOR EACH aycldeto2_fil NO-LOCK WHERE
    aycldeto2_fil.bchyr  = nv_bchyr    AND
    aycldeto2_fil.bchno  = nv_bchprev  AND
    aycldeto2_fil.bchcnt = nv_bchcnt   
    BREAK BY aycldeto2_fil.rseqno :
    ASSIGN 
        nv_premtaxs = "" 
        nv_premtaxs = string(deci(aycldeto2_fil.premtax),"999999999")
        n_rseqno    = INTE(aycldeto2_fil.rseqno)
        n_totpolno  = n_totpolno + 1
        /*A59-0359*/
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    FIND LAST workf_aycl WHERE 
        workf_aycl.bchyr    =  aycldeto2_fil.bchyr  AND  
        workf_aycl.bchno    =  aycldeto2_fil.bchno  AND
        workf_aycl.bchcnt   =  aycldeto2_fil.bchcnt AND
        workf_aycl.rseqno   =  aycldeto2_fil.rseqno NO-LOCK NO-ERROR .
    IF AVAIL workf_aycl THEN
        ASSIGN 
        /*np_finint    =  workf_aycl.finint */  
        np_addr1     =  workf_aycl.addr1     
        np_addr2     =  workf_aycl.addr2     
        np_addr3     =  workf_aycl.addr3     
        np_postcd    =  workf_aycl.postcd    
        /*np_flag      =  workf_aycl.flag  */   
        np_CCOLOR    =  workf_aycl.CCOLOR   
        np_acno1     =  workf_aycl.acno1    
        np_covcod    =  workf_aycl.covcod   
        np_prem_cus  =  workf_aycl.prem_cus .
    ELSE ASSIGN 
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
       /* a65-0115 */
    ASSIGN 
        n_si         = ""
        n_prem       = ""
        n_premtot    = "" 
        n_si         = trim(aycldeto2_fil.si)
        n_prem       = trim(aycldeto2_fil.prem)
        n_premtot    = trim(aycldeto2_fil.premtot) .
       
        IF      LENGTH(n_si) = 8 THEN assign n_si = "0" + n_si.
        ELSE IF LENGTH(n_si) = 7 THEN assign n_si = "00" + n_si.
        ELSE IF LENGTH(n_si) = 6 THEN assign n_si = "000" + n_si.
        ELSE IF LENGTH(n_si) = 5 THEN assign n_si = "0000" + n_si.
        ELSE IF LENGTH(n_si) = 4 THEN assign n_si = "00000" + n_si.
        ELSE IF LENGTH(n_si) = 3 THEN assign n_si = "000000" + n_si.
        ELSE IF LENGTH(n_si) = 2 THEN assign n_si = "0000000" + n_si.
        ELSE IF LENGTH(n_si) = 1 THEN assign n_si = "00000000" + n_si.
        ELSE IF LENGTH(n_si) = 0 THEN assign n_si = "000000000" + n_si.
          
        IF      LENGTH(n_prem) = 8 THEN assign n_prem = "0" + n_prem.
        ELSE IF LENGTH(n_prem) = 7 THEN assign n_prem = "00" + n_prem.
        ELSE IF LENGTH(n_prem) = 6 THEN assign n_prem = "000" + n_prem.
        ELSE IF LENGTH(n_prem) = 5 THEN assign n_prem = "0000" + n_prem.
        ELSE IF LENGTH(n_prem) = 4 THEN assign n_prem = "00000" + n_prem.
        ELSE IF LENGTH(n_prem) = 3 THEN assign n_prem = "000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 2 THEN assign n_prem = "0000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 1 THEN assign n_prem = "00000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 0 THEN assign n_prem = "000000000" + n_prem.
          
        IF      LENGTH(n_premtot) = 8 THEN assign n_premtot = "0" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 7 THEN assign n_premtot = "00" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 6 THEN assign n_premtot = "000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 5 THEN assign n_premtot = "0000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 4 THEN assign n_premtot = "00000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 3 THEN assign n_premtot = "000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 2 THEN assign n_premtot = "0000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 1 THEN assign n_premtot = "00000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 0 THEN assign n_premtot = "000000000" + n_premtot.
  
    /* end : A65-0115 */

    /*A59-0359*/
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
    PUT UNFORMATTED  
        TRIM(aycldeto2_fil.rectyp)   + "|" +
        TRIM(aycldeto2_fil.rseqno)   + "|" +
        /*TRIM(aycldeto2_fil.compno)   + "|" +*/
        TRIM(aycldeto2_fil.prodcode) + "|" +
        TRIM(aycldeto2_fil.brncode)  + "|" +
        TRIM(aycldeto2_fil.contno)   + "|" +
        /*TRIM(np_finint)              + "|" + */
        TRIM(aycldeto2_fil.ntitle)   + "|" +
        TRIM(aycldeto2_fil.fname)    + "|" +
        TRIM(aycldeto2_fil.lname)    + "|" +
        TRIM(np_addr1)               + "|" + 
        TRIM(np_addr2)               + "|" + 
        TRIM(np_addr3)               + "|" + 
        TRIM(np_postcd)              + "|" + 
        /*TRIM(np_flag)                + "|" + */
        TRIM(aycldeto2_fil.textchar1) + "|" +
        TRIM(aycldeto2_fil.brand)    + "|" +
        TRIM(aycldeto2_fil.model)    + "|" +
        TRIM(np_CCOLOR)              + "|" + 
        TRIM(aycldeto2_fil.vehreg)   + "|" +
        TRIM(aycldeto2_fil.province) + "|" +
        TRIM(aycldeto2_fil.yrmanu)   + "|" +
        TRIM(aycldeto2_fil.engine)   + "|" +
        TRIM(aycldeto2_fil.cha_no)   + "|" +
        TRIM(aycldeto2_fil.eng_no)   + "|" +
        TRIM(aycldeto2_fil.textchar2) + "|" +
        /*TRIM(np_acno1)               + "|" + */
        TRIM(np_covcod)              + "|" + 
        TRIM(np_prem_cus)            + "|" + 
        TRIM(aycldeto2_fil.yrins)    + "|" +
        TRIM(aycldeto2_fil.notify)   + "|" +
        TRIM(aycldeto2_fil.textchar3) + "|" +
        TRIM(aycldeto2_fil.policy)   + "|" +
        TRIM(aycldeto2_fil.comdat)   + "|" +
        TRIM(aycldeto2_fil.expdat)   + "|" +
        trim(n_si)       + "|" +
        trim(n_prem)     + "|" +
        trim(n_premtot)   SKIP.  
END.  /*FOR EACH aycldeto2_fil*/
/**** Total ****/
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "T"         NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
    n_totpolno1 =  STRING(n_totpolno,"99999").
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
    PUT UNFORMATTED  
        TRIM(ayclhead2_fil.rectyp)      + "|" +
        TRIM(n_rseqno1)                 + "|" +  
        TRIM(n_totpolno1)               + "|" +  
        TRIM(ayclhead2_fil.totpremt)    + "|" +
        TRIM(ayclhead2_fil.chkdigit)    + "|" +
        trim(ayclhead2_fil.developno)   + ""  SKIP.
    END.   /*FIND FIRST ayclhead2_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile02 WGWAYCL1 
PROCEDURE proc_outputfile02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A65-0115      
------------------------------------------------------------------------------*/
def var n_si        as char .
def var n_prem      as char .
def var n_premtot   as char .

FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "H" NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
    PUT UNFORMATTED 
        TRIM(ayclhead2_fil.rectyp)    + "|" +
        TRIM(ayclhead2_fil.fseqno)    + "|" +
        TRIM(ayclhead2_fil.compno)    + "|" +
        TRIM(ayclhead2_fil.compins)   + "|" +
        TRIM(ayclhead2_fil.asofdat)   + "|" +
        TRIM(ayclhead2_fil.developno) + "" SKIP.  
END.
/**** Detail ****/
FOR EACH aycldeto2_fil NO-LOCK WHERE
    aycldeto2_fil.bchyr  = nv_bchyr    AND
    aycldeto2_fil.bchno  = nv_bchprev  AND
    aycldeto2_fil.bchcnt = nv_bchcnt   
    BREAK BY aycldeto2_fil.rseqno :
    ASSIGN 
        n_rseqno    = INTE(aycldeto2_fil.rseqno) 
        n_totpolno  = n_totpolno + 1
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    FIND LAST workf_aycl WHERE 
        workf_aycl.bchyr    =  aycldeto2_fil.bchyr  AND  
        workf_aycl.bchno    =  aycldeto2_fil.bchno  AND
        workf_aycl.bchcnt   =  aycldeto2_fil.bchcnt AND
        workf_aycl.rseqno   =  aycldeto2_fil.rseqno NO-LOCK NO-ERROR .
    IF AVAIL workf_aycl THEN
        ASSIGN 
        /*np_finint    =  workf_aycl.finint   */
        np_addr1     =  workf_aycl.addr1     
        np_addr2     =  workf_aycl.addr2     
        np_addr3     =  workf_aycl.addr3     
        np_postcd    =  workf_aycl.postcd    
        np_flag      =  workf_aycl.flag     
        np_CCOLOR    =  workf_aycl.CCOLOR   
        /*np_acno1     =  workf_aycl.acno1   */  
        np_covcod    =  workf_aycl.covcod  
        np_prem_cus  =  workf_aycl.prem_cus .
    ELSE ASSIGN 
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    /* a65-0115 */
    ASSIGN 
        n_si         = ""
        n_prem       = ""
        n_premtot    = "" 
        n_si         = trim(aycldeto2_fil.si)
        n_prem       = trim(aycldeto2_fil.prem)
        n_premtot    = trim(aycldeto2_fil.premtot) .
       
        IF      LENGTH(n_si) = 8 THEN assign n_si = "0" + n_si.
        ELSE IF LENGTH(n_si) = 7 THEN assign n_si = "00" + n_si.
        ELSE IF LENGTH(n_si) = 6 THEN assign n_si = "000" + n_si.
        ELSE IF LENGTH(n_si) = 5 THEN assign n_si = "0000" + n_si.
        ELSE IF LENGTH(n_si) = 4 THEN assign n_si = "00000" + n_si.
        ELSE IF LENGTH(n_si) = 3 THEN assign n_si = "000000" + n_si.
        ELSE IF LENGTH(n_si) = 2 THEN assign n_si = "0000000" + n_si.
        ELSE IF LENGTH(n_si) = 1 THEN assign n_si = "00000000" + n_si.
        ELSE IF LENGTH(n_si) = 0 THEN assign n_si = "000000000" + n_si.
          
        IF      LENGTH(n_prem) = 8 THEN assign n_prem = "0" + n_prem.
        ELSE IF LENGTH(n_prem) = 7 THEN assign n_prem = "00" + n_prem.
        ELSE IF LENGTH(n_prem) = 6 THEN assign n_prem = "000" + n_prem.
        ELSE IF LENGTH(n_prem) = 5 THEN assign n_prem = "0000" + n_prem.
        ELSE IF LENGTH(n_prem) = 4 THEN assign n_prem = "00000" + n_prem.
        ELSE IF LENGTH(n_prem) = 3 THEN assign n_prem = "000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 2 THEN assign n_prem = "0000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 1 THEN assign n_prem = "00000000" + n_prem.
        ELSE IF LENGTH(n_prem) = 0 THEN assign n_prem = "000000000" + n_prem.
          
        IF      LENGTH(n_premtot) = 8 THEN assign n_premtot = "0" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 7 THEN assign n_premtot = "00" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 6 THEN assign n_premtot = "000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 5 THEN assign n_premtot = "0000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 4 THEN assign n_premtot = "00000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 3 THEN assign n_premtot = "000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 2 THEN assign n_premtot = "0000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 1 THEN assign n_premtot = "00000000" + n_premtot.
        ELSE IF LENGTH(n_premtot) = 0 THEN assign n_premtot = "000000000" + n_premtot.
    /*END.*/
    /* end : A65-0115 */
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
    PUT UNFORMATTED  
        TRIM(aycldeto2_fil.rectyp)   + "|" +
        TRIM(aycldeto2_fil.rseqno)   + "|" +
        /*TRIM(aycldeto2_fil.compno)   + "|" +*/
        TRIM(aycldeto2_fil.prodcode) + "|" +
        TRIM(aycldeto2_fil.brncode)  + "|" +
        TRIM(aycldeto2_fil.contno)   + "|" +
        /*TRIM(np_finint)              + "|" + */
        TRIM(aycldeto2_fil.ntitle)   + "|" +
        TRIM(aycldeto2_fil.fname)    + "|" +
        TRIM(aycldeto2_fil.lname)    + "|" +
        TRIM(np_addr1)               + "|" + 
        TRIM(np_addr2)               + "|" + 
        TRIM(np_addr3)               + "|" + 
        TRIM(np_postcd)              + "|" + 
        /*TRIM(np_flag)                + "|" + */
        TRIM(aycldeto2_fil.textchar1) + "|" +
        TRIM(aycldeto2_fil.brand)    + "|" +
        TRIM(aycldeto2_fil.model)    + "|" +
        TRIM(np_CCOLOR)              + "|" + 
        TRIM(aycldeto2_fil.vehreg)   + "|" +
        TRIM(aycldeto2_fil.province) + "|" +
        TRIM(aycldeto2_fil.yrmanu)   + "|" +
        TRIM(aycldeto2_fil.engine)   + "|" +
        TRIM(aycldeto2_fil.cha_no)   + "|" +
        TRIM(aycldeto2_fil.eng_no)   + "|" +
        TRIM(aycldeto2_fil.textchar2) + "|" +
        /*TRIM(np_acno1)               + "|" + */
        TRIM(np_covcod)              + "|" + 
        TRIM(np_prem_cus)            + "|" + 
        TRIM(aycldeto2_fil.yrins)    + "|" +
        TRIM(aycldeto2_fil.notify)   + "|" +
        TRIM(aycldeto2_fil.textchar3) + "|" +
        TRIM(aycldeto2_fil.policy)   + "|" +
        TRIM(aycldeto2_fil.comdat)   + "|" +
        TRIM(aycldeto2_fil.expdat)   + "|" +
        trim(n_si)                   + "|" +
        trim(n_prem)                 + "|" +
        trim(n_premtot)              + "|" + 
        trim(aycldeto2_fil.remark)  SKIP.  
END.  /*FOR EACH aycldeto2_fil*/
/**** Total ****/
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr    AND
    ayclhead2_fil.bchno  = nv_bchprev  AND
    ayclhead2_fil.bchcnt = nv_bchcnt   AND
    ayclhead2_fil.rectyp = "T"         NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
    n_totpolno1 =  STRING(n_totpolno,"99999").
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
    PUT UNFORMATTED  
        TRIM(ayclhead2_fil.rectyp)      + "|" +
        TRIM(n_rseqno1)                 + "|" +  
        TRIM(n_totpolno1)               + "|" +  
        TRIM(ayclhead2_fil.totpremt)    + "|" +
        TRIM(ayclhead2_fil.chkdigit)    + "|" +
        trim(ayclhead2_fil.developno)   + ""  SKIP.
    END.   /*FIND FIRST ayclhead2_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile2 WGWAYCL1 
PROCEDURE proc_outputfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by kridtiya i. A58-0121 ปรับแก้ไข table 
ayclhead_fil/ ayclhead2_fil
aycldeto_fil/ aycldeto2_fil
aycldeti_fil/ aycldeti2_fil
*/
/* comment by : A65-0115..
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr   AND
    ayclhead2_fil.bchno  = nv_bchprev AND
    ayclhead2_fil.bchcnt = nv_bchcnt  AND
    ayclhead2_fil.rectyp = "H" NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
    PUT UNFORMATTED /*Lukkana M. A52-0136 22/06/2009*/
        TRIM(ayclhead2_fil.rectyp) + "|" +
        TRIM(ayclhead2_fil.fseqno) + "|" +
        TRIM(ayclhead2_fil.compno) + "|" +
        TRIM(ayclhead2_fil.compins) + "|" +
        TRIM(ayclhead2_fil.asofdat) + "" SKIP.
END.
/**** Detail ****/
FOR EACH aycldeto2_fil WHERE
    aycldeto2_fil.bchyr  = nv_bchyr   AND
    aycldeto2_fil.bchno  = nv_bchprev AND
    aycldeto2_fil.bchcnt = nv_bchcnt  NO-LOCK:
    ASSIGN 
        n_rseqno    = INTE(aycldeto2_fil.rseqno)
        n_totpolno  = n_totpolno + 1   
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    FIND LAST workf_aycl WHERE 
        workf_aycl.bchyr    =  aycldeto2_fil.bchyr  AND  
        workf_aycl.bchno    =  aycldeto2_fil.bchno  AND
        workf_aycl.bchcnt   =  aycldeto2_fil.bchcnt AND
        workf_aycl.rseqno   =  aycldeto2_fil.rseqno NO-LOCK NO-ERROR .
    IF AVAIL workf_aycl THEN
        ASSIGN 
        np_finint    =  workf_aycl.finint   
        np_addr1     =  workf_aycl.addr1     
        np_addr2     =  workf_aycl.addr2     
        np_addr3     =  workf_aycl.addr3     
        np_postcd    =  workf_aycl.postcd    
        np_flag      =  workf_aycl.flag     
        np_CCOLOR    =  workf_aycl.CCOLOR   
        np_acno1     =  workf_aycl.acno1    
        np_covcod    =  workf_aycl.covcod   
        np_prem_cus  =  workf_aycl.prem_cus .
    ELSE ASSIGN 
        np_finint    =  ""  
        np_addr1     =  ""    
        np_addr2     =  ""    
        np_addr3     =  ""   
        np_postcd    =  ""  
        np_flag      =  ""    
        np_CCOLOR    =  "" 
        np_acno1     =  ""    
        np_covcod    =  ""  
        np_prem_cus  =  "" .
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
    PUT UNFORMATTED  
        TRIM(aycldeto2_fil.rectyp)   + "|" +
        TRIM(aycldeto2_fil.rseqno)   + "|" +
        TRIM(aycldeto2_fil.compno)   + "|" +
        TRIM(aycldeto2_fil.brncode)  + "|" +
        TRIM(aycldeto2_fil.prodcode) + "|" +
        TRIM(aycldeto2_fil.contno)   + "|" +
        TRIM(np_finint)              + "|" + 
        TRIM(aycldeto2_fil.ntitle)   + "|" +
        TRIM(aycldeto2_fil.fname)    + "|" +
        TRIM(aycldeto2_fil.lname)    + "|" +
        TRIM(np_addr1)                + "|" + 
        TRIM(np_addr2)                + "|" + 
        TRIM(np_addr3)                + "|" + 
        TRIM(np_postcd)              + "|" + 
        TRIM(np_flag)                + "|" + 
        TRIM(aycldeto2_fil.brand)    + "|" +
        TRIM(aycldeto2_fil.model)    + "|" +
        TRIM(np_CCOLOR)              + "|" + 
        TRIM(aycldeto2_fil.vehreg)   + "|" +
        TRIM(aycldeto2_fil.province) + "|" +
        TRIM(aycldeto2_fil.yrmanu)   + "|" +
        TRIM(aycldeto2_fil.engine)   + "|" +
        TRIM(aycldeto2_fil.cha_no)   + "|" +
        TRIM(aycldeto2_fil.eng_no)   + "|" +
        TRIM(np_acno1)               + "|" + 
        TRIM(np_covcod)              + "|" + 
        TRIM(aycldeto2_fil.compins)  + "|" +
        TRIM(aycldeto2_fil.policy)   + "|" +
        TRIM(aycldeto2_fil.comdat)   + "|" +
        TRIM(aycldeto2_fil.expdat)   + "|" +
        TRIM(aycldeto2_fil.si)       + "|" +
        TRIM(aycldeto2_fil.prem)     + "|" +
        TRIM(aycldeto2_fil.premtot)  + "|" +
        TRIM(np_prem_cus)            + "|" + 
        TRIM(aycldeto2_fil.yrins)    + "|" +
        TRIM(aycldeto2_fil.notify)   + "|" +
        TRIM(aycldeto2_fil.jobcode)  + "|" +
        TRIM(aycldeto2_fil.firstdat)  SKIP.
END.  /*FOR EACH aycldeto2_fil*/
/**** Total ****/
FIND FIRST ayclhead2_fil WHERE 
    ayclhead2_fil.bchyr  = nv_bchyr   AND
    ayclhead2_fil.bchno  = nv_bchprev AND
    ayclhead2_fil.bchcnt = nv_bchcnt  AND
    ayclhead2_fil.rectyp = "T"        NO-LOCK NO-ERROR.
IF AVAIL ayclhead2_fil THEN DO:
    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
    n_totpolno1 =  STRING(n_totpolno,"99999").
    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
    PUT UNFORMATTED  
        TRIM(ayclhead2_fil.rectyp)   + "|" +
        TRIM(n_rseqno1)              + "|" +  
        TRIM(n_totpolno1)            + "|" +  
        TRIM(ayclhead2_fil.totpremt) + "|" +
        TRIM(ayclhead2_fil.chkdigit) + "" SKIP.
END.  /*FIND FIRST ayclhead2_fil*/
... end :A65-0115..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfileconv WGWAYCL1 
PROCEDURE proc_outputfileconv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment BY Kridtiya i. A59-0359
DEF VAR outfile      AS CHAR.
    DEF VAR logAns       AS LOGI INIT No.
    DEF VAR n_rseqno     AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_rseqno1    AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_totpolno   AS INTE . /*Lukkana M. A53-0161 22/04/2010*/
    DEF VAR n_totpolno1  AS CHAR . /*Lukkana M. A53-0161 22/04/2010*/
    /** comment by Nipawadee R. 30/08/2010/ to A53-0239
    FOR EACH certmp WHERE certmp.progid  = "WGWAYCL1" .
        DELETE certmp.
    END.*/
    END..comment BY Kridtiya i. A59-0359*/

    /*Lukkana M. A53-0161 22/04/2010*/
    ASSIGN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
        n_rseqno    = 0
        n_rseqno1   = "" 
        n_totpolno  = 0
        n_totpolno1 = "".
    /*Lukkana M. A53-0161 22/04/2010*/

    DISABLE ALL 
        EXCEPT fi_bchprev fi_bchyr fi_bchcnt
               br_input bu_out bu_exit 
    WITH FRAM fr_main.

    ENABLE fi_bchcnt 
           TO_textaycl to_guaranexcel to_guaranpdf WITH FRAME fr_main. /*Lukkana M. A55-0175 08/06/2012*/
    IF INPUT TO_guaranpdf = NO THEN DISABLE cbPrtList WITH FRAME fr_main.  /*Lukkana M. A55-0175 08/06/2012*/
    ELSE ENABLE cbPrtList WITH FRAME fr_main.  /*Lukkana M. A55-0175 08/06/2012*/

    nv_bchyr = fi_bchyr.
   
    FOR EACH certmp USE-INDEX certmp01
                    WHERE Certmp.usrid = nv_useid  
                    AND Certmp.entdat  = nv_entdat 
                    AND Certmp.enttim  = nv_enttime      
                    AND Certmp.Progid  = nv_progid2 : 
        DELETE certmp.

    END.

    IF INPUT fi_bchyr  <= 0   OR
       INPUT fi_bchprev = ""  OR
       INPUT fi_bchcnt <= 0   THEN DO:

        MESSAGE "กรุณาระบุข้อมูล Batch no. ที่ต้องการ...!" VIEW-AS ALERT-BOX WARNING.

    END.
    ELSE DO: 

        IF fi_bchprev <> ""  THEN DO:
            IF LENGTH(fi_bchprev) <> 16 THEN DO:
                 MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                         "Please Check Batch No. Again             " view-as alert-box.
                 APPLY "entry" TO fi_bchprev.
                 RETURN NO-APPLY.
            END.
        END. 
        IF fi_bchyr <= 0 THEN DO:
            MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
            APPLY "entry" to fi_bchyr.
            RETURN NO-APPLY.
        END.

        /*-- Lukkana M. A55-0175 07/06/2012
        IF fi_usrcnt <= 0  THEN DO:
            MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
            APPLY "entry" to fi_usrcnt.
            RETURN NO-APPLY.
        END.
        
        IF INPUT rs_type = 1 THEN DO: /*AYAL Text File*/

        outfile = "C:\TEMP\" + fi_bchprev + STRING(fi_bchcnt,"99") + ".txt" . 
        
        MESSAGE "OUTPUT TEXT File (AYCL) " UPDATE logAns
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm Output Text file".

         IF logAns THEN DO:

            OUTPUT TO VALUE(outfile).

            /**** Head ****/
            FIND FIRST ayclhead_fil WHERE 
                       ayclhead_fil.bchyr  = fi_bchyr AND
                       ayclhead_fil.bchno  = fi_bchprev AND
                       ayclhead_fil.bchcnt = fi_bchcnt AND
                       ayclhead_fil.rectyp = "H" NO-LOCK NO-ERROR.
            IF AVAIL ayclhead_fil THEN DO:
                
                /*EXPORT Lukkana M. A52-0136 22/06/2009*/
                PUT UNFORMATTED /*Lukkana M. A52-0136 22/06/2009*/
                    TRIM(ayclhead_fil.rectyp) + "|" +
                    TRIM(ayclhead_fil.fseqno) + "|" +
                    TRIM(ayclhead_fil.compno) + "|" +
                    TRIM(ayclhead_fil.compins) + "|" +
                    TRIM(ayclhead_fil.asofdat) + "" SKIP.
            END.                                          
            
            /**** Detail ****/
            FOR EACH aycldeto_fil WHERE
                     aycldeto_fil.bchyr  = fi_bchyr AND
                     aycldeto_fil.bchno  = fi_bchprev AND
                     aycldeto_fil.bchcnt = fi_bchcnt 
            NO-LOCK:

            n_rseqno    = INTE(aycldeto_fil.rseqno). /*Lukkana M. A53-0161 22/04/2010*/
            n_totpolno  = n_totpolno + 1.  /*Lukkana M. A53-0161 22/04/2010*/
            
            /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
            PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                TRIM(aycldeto_fil.rectyp)   + "|" +
                TRIM(aycldeto_fil.rseqno)   + "|" +
                TRIM(aycldeto_fil.compno)   + "|" +
                TRIM(aycldeto_fil.brncode)  + "|" +
                TRIM(aycldeto_fil.prodcode) + "|" +
                TRIM(aycldeto_fil.contno)   + "|" +
                TRIM(aycldeto_fil.finint)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.ntitle)   + "|" +
                TRIM(aycldeto_fil.fname)    + "|" +
                TRIM(aycldeto_fil.lname)    + "|" +
                TRIM(aycldeto_fil.addr1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.addr2)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.addr3)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.postcd)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.flag)     + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.brand)    + "|" +
                TRIM(aycldeto_fil.model)    + "|" +
                TRIM(aycldeto_fil.ccolor)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.vehreg)   + "|" +
                TRIM(aycldeto_fil.province) + "|" +
                TRIM(aycldeto_fil.yrmanu)   + "|" +
                TRIM(aycldeto_fil.engine)   + "|" +
                TRIM(aycldeto_fil.cha_no)   + "|" +
                TRIM(aycldeto_fil.eng_no)   + "|" +
                TRIM(aycldeto_fil.acno1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.covcod)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.compins)  + "|" +
                TRIM(aycldeto_fil.policy)   + "|" +
                TRIM(aycldeto_fil.comdat)   + "|" +
                TRIM(aycldeto_fil.expdat)   + "|" +
                TRIM(aycldeto_fil.si)       + "|" +
                TRIM(aycldeto_fil.prem)     + "|" +
                TRIM(aycldeto_fil.premtot)  + "|" +
                TRIM(aycldeto_fil.prem_cus) + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                TRIM(aycldeto_fil.yrins)    + "|" +
                TRIM(aycldeto_fil.notify)   + "|" +
                TRIM(aycldeto_fil.jobcode)  + "|" +
                TRIM(aycldeto_fil.firstdat)  SKIP.
            END.

            /**** Total ****/
            FIND FIRST ayclhead_fil WHERE 
                       ayclhead_fil.bchyr  = fi_bchyr AND
                       ayclhead_fil.bchno  = fi_bchprev AND
                       ayclhead_fil.bchcnt = fi_bchcnt AND
                       ayclhead_fil.rectyp = "T" NO-LOCK NO-ERROR.
            IF AVAIL ayclhead_fil THEN DO:
                n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
                n_totpolno1 =  STRING(n_totpolno,"99999").
            
                /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
                PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                    TRIM(ayclhead_fil.rectyp)   + "|" +
                    /*----
                    TRIM(ayclhead_fil.lseqno)   + "|" + 
                    TRIM(ayclhead_fil.totpolno) + "|" +
                    Lukkana M. A53-0161 22/04/2010--*/
                    TRIM(n_rseqno1)             + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                    TRIM(n_totpolno1)           + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                    TRIM(ayclhead_fil.totpremt) + "|" +
                    TRIM(ayclhead_fil.chkdigit) + "" SKIP.
            END.

            OUTPUT CLOSE.

            MESSAGE "OUTPUT TEXT FILE Completed ..." SKIP
                    "To file : " outfile VIEW-AS ALERT-BOX INFORMATION.
         END. /*if 1. */

        END. 
        ELSE IF INPUT rs_type = 2 THEN DO:  /*Guarantee  Nipawadee 16/07/2010  A53-0211*/

            RUN wgw\wgwe01   (INPUT-OUTPUT n_destination,
                              INPUT-OUTPUT n_printer,
                              INPUT-OUTPUT n_filename,
                              INPUT-OUTPUT n_print).

            RUN pd_create-certmp. /*Create ค่าลง table certmp*/

            MESSAGE n_printer VIEW-AS ALERT-BOX.
            RB-PRINTER-NAME  =  n_printer.

            IF n_filename <> "" THEN DO: /*File*/
                RUN pd_guaran_file.
                RETURN NO-APPLY.
            END.
            ELSE IF n_printer <> "" OR n_destination <> "" THEN DO:  /*Printer*/
                RUN pd_guaran_print.
            END.

        END.
        Lukkana M. A55-0175 07/06/2012--*/
        
        /*--Lukkana M. A55-0175 07/06/2012--*/

        IF INPUT TO_textaycl    <> YES  AND 
           INPUT TO_guaranexcel <> YES  AND 
           INPUT TO_guaranpdf   <> YES  THEN DO:

           MESSAGE "กรุณาระบุประเภท" SKIP 
                   "Output Report Type ที่ต้องการ...!" VIEW-AS ALERT-BOX WARNING.
        END.

        RUN pd_create-certmp. /*Create ค่าลง table certmp*/

        ASSIGN  outfile  = ""
                outfile1 = "".
        
        IF INPUT TO_textaycl = YES THEN DO: /*AYAL Text File*/

            outfile = "C:\TEMP\" + INPUT fi_bchprev + STRING(fi_bchcnt,"99") + ".txt" . 
            
            /*MESSAGE "OUTPUT TEXT File (AYCL) " UPDATE logAns
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "Confirm Output Text file".
    
            IF logAns THEN DO:*/
        
                OUTPUT TO VALUE(outfile) NO-ECHO.
                /*comment by Kridtiya i. A59-0359........
                /**** Head ****/
                FIND FIRST ayclhead_fil WHERE 
                           ayclhead_fil.bchyr  = INPUT fi_bchyr AND
                           ayclhead_fil.bchno  = INPUT fi_bchprev AND
                           ayclhead_fil.bchcnt = INPUT fi_bchcnt AND
                           ayclhead_fil.rectyp = "H" NO-LOCK NO-ERROR.
                IF AVAIL ayclhead_fil THEN DO:
                    
                    /*EXPORT Lukkana M. A52-0136 22/06/2009*/
                    PUT UNFORMATTED /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(ayclhead_fil.rectyp) + "|" +
                        TRIM(ayclhead_fil.fseqno) + "|" +
                        TRIM(ayclhead_fil.compno) + "|" +
                        TRIM(ayclhead_fil.compins) + "|" +
                        TRIM(ayclhead_fil.asofdat) + "" SKIP.
                END.                                          
                
                /**** Detail ****/
                FOR EACH aycldeto_fil WHERE
                         aycldeto_fil.bchyr  = INPUT fi_bchyr   AND
                         aycldeto_fil.bchno  = INPUT fi_bchprev AND
                         aycldeto_fil.bchcnt = INPUT fi_bchcnt  NO-LOCK:

                    n_rseqno    = INTE(aycldeto_fil.rseqno). /*Lukkana M. A53-0161 22/04/2010*/
                    n_totpolno  = n_totpolno + 1.  /*Lukkana M. A53-0161 22/04/2010*/
                
                    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/ 
                    PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(aycldeto_fil.rectyp)   + "|" +
                        TRIM(aycldeto_fil.rseqno)   + "|" +
                        TRIM(aycldeto_fil.compno)   + "|" +
                        TRIM(aycldeto_fil.brncode)  + "|" +
                        TRIM(aycldeto_fil.prodcode) + "|" +
                        TRIM(aycldeto_fil.contno)   + "|" +
                        TRIM(aycldeto_fil.finint)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.ntitle)   + "|" +
                        TRIM(aycldeto_fil.fname)    + "|" +
                        TRIM(aycldeto_fil.lname)    + "|" +
                        TRIM(aycldeto_fil.addr1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.addr2)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.addr3)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.postcd)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.flag)     + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.brand)    + "|" +
                        TRIM(aycldeto_fil.model)    + "|" +
                        TRIM(aycldeto_fil.ccolor)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.vehreg)   + "|" +
                        TRIM(aycldeto_fil.province) + "|" +
                        TRIM(aycldeto_fil.yrmanu)   + "|" +
                        TRIM(aycldeto_fil.engine)   + "|" +
                        TRIM(aycldeto_fil.cha_no)   + "|" +
                        TRIM(aycldeto_fil.eng_no)   + "|" +
                        TRIM(aycldeto_fil.acno1)    + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.covcod)   + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.compins)  + "|" +
                        TRIM(aycldeto_fil.policy)   + "|" +
                        TRIM(aycldeto_fil.comdat)   + "|" +
                        TRIM(aycldeto_fil.expdat)   + "|" +
                        TRIM(aycldeto_fil.si)       + "|" +
                        TRIM(aycldeto_fil.prem)     + "|" +
                        TRIM(aycldeto_fil.premtot)  + "|" +
                        TRIM(aycldeto_fil.prem_cus) + "|" + /*Lukkana M. A55-0175 31/05/2012*/
                        TRIM(aycldeto_fil.yrins)    + "|" +
                        TRIM(aycldeto_fil.notify)   + "|" +
                        TRIM(aycldeto_fil.jobcode)  + "|" +
                        TRIM(aycldeto_fil.firstdat)  SKIP.
                END. /*FOR EACH aycldeto_fil*/
        
                /**** Total ****/
                FIND FIRST ayclhead_fil WHERE 
                           ayclhead_fil.bchyr  = INPUT fi_bchyr   AND
                           ayclhead_fil.bchno  = INPUT fi_bchprev AND
                           ayclhead_fil.bchcnt = INPUT fi_bchcnt  AND
                           ayclhead_fil.rectyp = "T"        NO-LOCK NO-ERROR.
                IF AVAIL ayclhead_fil THEN DO:
                    n_rseqno1   =  STRING(n_rseqno  +  1,"99999") .
                    n_totpolno1 =  STRING(n_totpolno,"99999").
                
                    /*EXPORT  Lukkana M. A52-0136 22/06/2009*/                   
                    PUT UNFORMATTED  /*Lukkana M. A52-0136 22/06/2009*/
                        TRIM(ayclhead_fil.rectyp)   + "|" +
                        /*----
                        TRIM(ayclhead_fil.lseqno)   + "|" + 
                        TRIM(ayclhead_fil.totpolno) + "|" +
                        Lukkana M. A53-0161 22/04/2010--*/
                        TRIM(n_rseqno1)             + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                        TRIM(n_totpolno1)           + "|" +  /*Lukkana M. A53-0161 22/04/2010*/
                        TRIM(ayclhead_fil.totpremt) + "|" +
                        TRIM(ayclhead_fil.chkdigit) + "" SKIP.
                END. /*FIND FIRST ayclhead_fil*/
                END ...comment by Kridtiya i. A58-0121........*/

                RUN proc_outputfile2.  /*A59-0359*/
        
                OUTPUT CLOSE.
                /*--
                MESSAGE "OUTPUT TEXT FILE Completed ..." SKIP
                        "To file : " outfile VIEW-AS ALERT-BOX INFORMATION. --*/
            /*
            END. /*if 1. */
            */
        END. 
        IF INPUT TO_guaranexcel = YES THEN DO:  /*Guarantee  EXCEL*/
            RUN pd_guaran_file.
        END.
        IF INPUT TO_guaranpdf = YES THEN DO: /*Guarantee PDF*/
            n_printer   = cbPrtList.
            RB-PRINTER-NAME = n_printer.
            RUN pd_guaran_print.
        END.

        IF outfile <> "" AND outfile1 <> "" THEN DO: /*เลือกทั้ง 2 ไฟล์*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "AYCAL Text File     :" outfile  SKIP
                    "Guarantee Excel     :" outfile1 SKIP 
                    "File Data not match :" outfile2 VIEW-AS ALERT-BOX INFORMATION.
        END.
        ELSE IF outfile <> "" AND outfile1 = "" THEN DO: /*เลือกเฉพาะ AYCAL Text file*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "AYCAL Text File :" outfile  VIEW-AS ALERT-BOX INFORMATION.
        END.
        ELSE IF outfile = "" AND outfile1 <> "" THEN DO: /*เลือกเฉพาะ Guarantee excel*/
            MESSAGE "OUTPUT Completed ..."       SKIP
                    "Guarantee Excel     :" outfile1 SKIP 
                    "File Data not match :" outfile2 VIEW-AS ALERT-BOX INFORMATION.
        END.
        /*--Lukkana M. A55-0175 07/06/2012--*/
        
    END.

    /*--Add by Nipawadee R. to A53-0312---*/
    FOR EACH certmp USE-INDEX certmp01
                   WHERE Certmp.Progid  = nv_progid2    
                   AND   Certmp.usrid   = nv_useid      
                   AND   Certmp.entdat  = nv_entdat     
                   AND   Certmp.enttim  = nv_enttime :
    DELETE certmp.
    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_output_txt WGWAYCL1 
PROCEDURE proc_output_txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A65-0115      
------------------------------------------------------------------------------*/
If  substr(fi_outputconv,length(fi_outputconv) - 3,4) <>  ".txt"  THEN 
    fi_outputconv  =  Trim(fi_outputconv) + ".txt"  .
 
OUTPUT TO VALUE(fi_outputconv) NO-ECHO.
FIND LAST  tgenerage WHERE   tgenerage.rectyp  = "H" NO-LOCK NO-ERROR.
IF AVAIL tgenerage THEN DO:
    PUT UNFORMATTED
        tgenerage.rectyp     + "|" + 
        tgenerage.rseqno     + "|" +
        tgenerage.prodcode   + "|" +
        tgenerage.brncode    + "|" +
        tgenerage.contno     + "|" +
        tgenerage.ntitle     +  ""     SKIP. 
END.                         
FOR EACH tgenerage NO-LOCK   
     WHERE tgenerage.rectyp  <> "H"  AND
           tgenerage.rectyp  <> "T"  AND 
           tgenerage.rectyp  <> "" .  
    
    PUT UNFORMATTED 
        tgenerage.rectyp       + "|" + 
        tgenerage.rseqno       + "|" +
        tgenerage.prodcode     + "|" +
        tgenerage.brncode      + "|" +
        tgenerage.contno       + "|" +
        tgenerage.ntitle       + "|" +
        tgenerage.fname        + "|" +
        tgenerage.lname        + "|" +
        tgenerage.addr1        + "|" +
        tgenerage.addr2        + "|" +
        tgenerage.addr3        + "|" +
        tgenerage.postcd       + "|" +
        tgenerage.ICNO         + "|" +
        tgenerage.brand        + "|" +
        tgenerage.model        + "|" +
        tgenerage.CCOLOR       + "|" +
        tgenerage.vehreg       + "|" +
        tgenerage.province     + "|" +
        tgenerage.yrmanu       + "|" +
        tgenerage.engine       + "|" +
        tgenerage.cha_no       + "|" +
        tgenerage.eng_no       + "|" +
        tgenerage.engine_typ   + "|" +
        tgenerage.covcod       + "|" +
        tgenerage.prem_cus     + "|" +
        tgenerage.yrins        + "|" +
        tgenerage.notify       + "|" +
        tgenerage.Serialno     + "|" +
        tgenerage.policy       + "|" +
        tgenerage.comdat       + "|" +
        tgenerage.expdat       + "|" +
        tgenerage.si           + "|" +
        tgenerage.prem         + "|" +
        tgenerage.premtot      SKIP. 
END.
FIND LAST  tgenerage  WHERE tgenerage.rectyp  = "T" NO-LOCK NO-ERROR .
IF AVAIL tgenerage THEN DO:
    PUT UNFORMATTED 
        tgenerage.rectyp   + "|" +  
        tgenerage.rseqno   + "|" +  
        tgenerage.prodcode + "|" +  
        tgenerage.brncode  + "|" +  
        tgenerage.contno   + "|" +  
        tgenerage.ntitle   + ""    SKIP.   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen WGWAYCL1 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ssrn TO value(fi_output3).
PUT STREAM ssrn   
"  INPUT - OUTPUT TEXT FILE 'AYCL' " SKIP
"    Transaction Date : " fi_trndat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " nv_bchno FORMAT "X(20)" /*fi_bchprev Lukkana M. A55-0244 07/08/2012*/   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"     Batch File Name : " fi_output3    SKIP
SKIP(2)
/*"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_nbchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .*/
/*"                             Total Record : " fi_impcnt      "   Success Record : " fi_completecnt  SKIP Lukkana M. A55-0209 06/07/2012*/
"                       Import Total Record : " fi_impcnt      "   Output Total Record : " fi_completecnt  SKIP /*Lukkana M. A55-0209 06/07/2012*/
"Batch No. : " nv_bchno FORMAT "X(20)".
       

OUTPUT STREAM ssrn CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_upuzm705 WGWAYCL1 
PROCEDURE Proc_upuzm705 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST uzm705 USE-INDEX uzm70501 WHERE 
           uzm705.bchtyp = "D"           AND
           uzm705.branch = fi_branch     AND
           uzm705.acno   = fi_producer   AND
           uzm705.bchyr  = nv_bchyr      AND
           uzm705.bchno  = nv_bchno      AND
           uzm705.bchcnt = nv_bchcnt  NO-ERROR.
IF AVAIL uzm705 THEN DO:
    ASSIGN
        uzm705.recout   = nv_compcnt
        uzm705.outdat   = TODAY
        uzm705.outusrid = gv_prgid.
END.

RELEASE uzm705.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

