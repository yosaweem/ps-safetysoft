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
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
  wuwqtis2.w :  Import text file from  Tisco  to create  new policy   
                         Add in table  tlt  
                         Quey & Update data before Gen.
  Create  by    :  Kridtiya i. A53-0207 On   14/09/2010
  modify by     :  Kridtiya i. A54-0061 On   05/04/2011
  Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
  modify by     :  Kridtiya i. A54-0216 ขยายช่อง remak1, remak2 จาก 20 เป็น 100 ตัวอักษร
  modify by     :  Kridtiya i. A56-0146 02/05/2013  เพิ่มการบันทึกข้อมูลแก้ไข 
/*modify by     : Kridtiya i. A57-0017 add column seat , first date       */
/*modify by   : Kridtiya i. A57-0262 add new format idno and id br name */
/*Modify BY   :  Manop G.  A59-0178   27/06/2016    เพิ่ม Field ช้อมูล Line72  */
/*Modify by  : Ranu I. A60-0095 date 20/02/2017 เพิ่มการเก็บข้อมูลของ line 72 เมื่อมีการแก้ไขหรือเพิ่มค่า */
/*Modify by  : Ranu I. A60-0118 date 01/03/2017 เพิ่มการเก็บข้อมูลเลขที่ตรวจสภาพ จากกล่อง Inspection */
/*Modify by  : Sarinya C. A63-0210 date 26/05/2020 เปลี่ยนแปลง Layout Text โดยเพิ่ม field  ต่อท้ายจากเดิม */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I.  Date. 05/03/2021  เพิ่มช่องอุปกรณ์เสริม */
/*Modify by   : Kridtiya i. A65-0356 Date. 07/01/2023 ขยายช่อง เลขเครื่องเลขถัง ทะเบียน สี */
/*Modify by   : Kridtiya i. A66-0140 Date. 01/07/2023 เพิ่ม งาน 2ปี GWM */
/*Modify by : Ranu i. A67-0114 แก้ไขหน้าจอเพิ่มการแสดงข้อมูลรถไฟฟ้า */
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
/* Ranu i. inspection A60-0118           */
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
DEF VAR n_Rec_name72  AS CHAR FORMAT "x(150)" INIT "".    /*Start A63-0210*/
DEF VAR n_Rec_add1    AS CHAR FORMAT "x(60)"  INIT "".    
DEF VAR n_Rec_add2    AS CHAR FORMAT "x(60)"  INIT "".    
DEF VAR nv_cutrec     AS CHAR FORMAT "x(200)" INIT "".    /*End A63-0210*/
DEF VAR nv_acc        AS CHAR FORMAT "x(255)" INIT "" . /*A64-0092*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_policy fi_pro_off fi_cmrcode fi_ins_comp ~
fi_polsystem fi_notno fi_year fi_eng_no fi_ton fi_power fi_color fi_garage ~
fi_cha_no fi_fleetper fi_ncbper fi_othper fi_deduct fi_vehuse fi_seatnew ~
fi_brand fi_licence fi_province fi_comdat fi_expdat fi_sumsi fi_sumfi ~
fi_72comdat fi_72expdat fi_class fi_caruse fi_prem1 fi_compprm fi_gross_amt ~
fi_sckno fi_not_off fi_ins_off fi_notdat fi_nottim fi_notcode fi_title ~
fi_firstname fi_lastname fi_preinsur fi_accno2 fi_addr70 fi_addr72 ~
fi_producer fi_agent fi_client fi_accno fi_susspect fi_benname fi_remark1 ~
fi_remark2 fi_remark3 fi_branch fi_covcod fi_pack fi_tp1 fi_tp2 fi_tp3 ~
bu_save ra_poltyp bu_exit fi_acc1 fi_acc2 fi_covcodcd fi_policy2yGWM ~
fi_detailisp bu_upins fi_insp fi_inspno fi_acc3 fi_acc4 bu_car RECT-335 ~
RECT-337 RECT-338 RECT-464 RECT-465 
&Scoped-Define DISPLAYED-OBJECTS fi_policy fi_pro_off fi_cmrcode ~
fi_ins_comp fi_polsystem fi_notno fi_year fi_eng_no fi_ton fi_power ~
fi_color fi_garage fi_cha_no fi_fleetper fi_ncbper fi_othper fi_deduct ~
fi_vehuse fi_seatnew fi_brand fi_licence fi_province fi_comdat fi_expdat ~
fi_sumsi fi_sumfi fi_72comdat fi_72expdat fi_class fi_caruse fi_prem1 ~
fi_compprm fi_gross_amt fi_sckno fi_not_off fi_ins_off fi_notdat fi_nottim ~
fi_notcode fi_title fi_firstname fi_lastname fi_preinsur fi_accno2 ~
fi_addr70 fi_addr72 fi_producer fi_agent fi_client fi_accno fi_susspect ~
fi_benname fi_remark1 fi_remark2 fi_remark3 fi_branch fi_covcod fi_pack ~
fi_tp1 fi_tp2 fi_tp3 ra_poltyp fi_trndat fi_userid fi_acc1 fi_acc2 ~
fi_covcodcd fi_confirmdate fi_policy2yGWM fi_detailisp fi_insp fi_inspno ~
fi_acc3 fi_acc4 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_car 
     LABEL "Page 2" 
     SIZE 8.67 BY 1.43
     BGCOLOR 7 FGCOLOR 6 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY .81
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY .81
     FONT 6.

DEFINE BUTTON bu_upins 
     LABEL "CHECK ISP" 
     SIZE 12.5 BY .91
     BGCOLOR 6 FGCOLOR 2 FONT 6.

DEFINE VARIABLE fi_72comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_72expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_acc1 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 109.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 109.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc3 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 109.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc4 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 109.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_accno2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr70 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 91 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr72 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 91 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_caruse AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 33.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_confirmdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcodcd AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_deduct AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_detailisp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22.33 BY .91
     BGCOLOR 19 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fleetper AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 10.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(1)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY .91
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inspno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .91
     BGCOLOR 15 FGCOLOR 6 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_ins_comp AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ncbper AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notcode AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_not_off AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_othper AS DECIMAL FORMAT ">>>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_policy2yGWM AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 59 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 109.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 109.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark3 AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 109.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_seatnew AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumfi AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_susspect AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tp1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 9.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 19.5 BY .95
     BGCOLOR 10 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131.83 BY 25.19
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-337
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.33
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.17 BY 1.33
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-464
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.5 BY 1.19
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 2.38
     BGCOLOR 5 FGCOLOR 15 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_policy AT ROW 1.29 COL 39.17 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 2.57 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 2.57 COL 37.17 COLON-ALIGNED NO-LABEL
     fi_ins_comp AT ROW 2.57 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.24 COL 78 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 2.62 COL 87.33 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 3.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 3.57 COL 39 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 4.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 4.57 COL 41.33 COLON-ALIGNED NO-LABEL
     fi_color AT ROW 4.57 COL 62 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 4.62 COL 86.83 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 3.62 COL 86.67 COLON-ALIGNED NO-LABEL
     fi_fleetper AT ROW 5.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_ncbper AT ROW 5.57 COL 41.33 COLON-ALIGNED NO-LABEL
     fi_othper AT ROW 5.57 COL 65 COLON-ALIGNED NO-LABEL
     fi_deduct AT ROW 5.57 COL 86.67 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 5.57 COL 110.17 COLON-ALIGNED NO-LABEL
     fi_seatnew AT ROW 4.57 COL 110.17 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 6.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 6.57 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 6.57 COL 105.67 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 7.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 7.57 COL 47.5 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 7.57 COL 73.83 COLON-ALIGNED NO-LABEL
     fi_sumfi AT ROW 7.57 COL 99.67 COLON-ALIGNED NO-LABEL
     fi_72comdat AT ROW 8.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_72expdat AT ROW 8.57 COL 51.67 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 8.57 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_caruse AT ROW 8.57 COL 102 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 9.62 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 9.62 COL 47.33 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 9.62 COL 73.5 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 9.62 COL 103.33 COLON-ALIGNED NO-LABEL
     fi_not_off AT ROW 10.62 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 10.62 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 11.62 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 11.62 COL 45.5 COLON-ALIGNED NO-LABEL
     fi_notcode AT ROW 11.62 COL 70 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 12.62 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 12.62 COL 44.5 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 12.62 COL 91.33 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 13.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_accno2 AT ROW 13.67 COL 94.17 COLON-ALIGNED NO-LABEL
     fi_addr70 AT ROW 14.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_addr72 AT ROW 15.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 16.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 16.67 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 16.67 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 16.67 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_susspect AT ROW 10.67 COL 122.33 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_benname AT ROW 17.71 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 18.62 COL 19.5 NO-LABEL
     fi_remark2 AT ROW 19.48 COL 17.5 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 134.5 BY 26.81
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_remark3 AT ROW 20.33 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 24.71 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 24.71 COL 31 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 24.71 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_tp1 AT ROW 24.71 COL 56.83 COLON-ALIGNED NO-LABEL
     fi_tp2 AT ROW 24.71 COL 74.83 COLON-ALIGNED NO-LABEL
     fi_tp3 AT ROW 24.71 COL 93.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 24.86 COL 111
     ra_poltyp AT ROW 1.29 COL 3 NO-LABEL
     bu_exit AT ROW 26.14 COL 110.83
     fi_trndat AT ROW 14.67 COL 115.67 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 13.67 COL 120.67 COLON-ALIGNED NO-LABEL
     fi_acc1 AT ROW 21.19 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_acc2 AT ROW 22.05 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_covcodcd AT ROW 8.57 COL 118.17 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fi_confirmdate AT ROW 15.62 COL 115.67 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_policy2yGWM AT ROW 1.24 COL 106.33 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     fi_detailisp AT ROW 25.91 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 256
     bu_upins AT ROW 25.91 COL 95 WIDGET-ID 254
     fi_insp AT ROW 25.91 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 258
     fi_inspno AT ROW 25.91 COL 76 COLON-ALIGNED NO-LABEL WIDGET-ID 260
     fi_acc3 AT ROW 22.91 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 280
     fi_acc4 AT ROW 23.76 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 282
     bu_car AT ROW 25.14 COL 121.67 WIDGET-ID 192
     " Color :":35 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 4.57 COL 56.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "        Branch :":30 VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 24.71 COL 5.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Policy RENEW :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 1.29 COL 23.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "covcod":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.57 COL 111.67 WIDGET-ID 26
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Addr_pol72 :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 15.67 COL 2
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "TP2":30 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 24.71 COL 71.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Sum  SI :":35 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 7.57 COL 65.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "    Notified Date :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 11.62 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "               Brand :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 6.57 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "          Com Date :":35 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 7.57 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Process Office  :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 2.62 COL 2.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "           Remark  :":30 VIEW-AS TEXT
          SIZE 17.17 BY .86 AT ROW 18.67 COL 1.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 134.5 BY 26.81
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  Weight Kg/Ton :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 4.57 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Veh.Use :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 5.57 COL 102
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "TP1":30 VIEW-AS TEXT
          SIZE 4.67 BY .91 AT ROW 24.71 COL 54.17
          FGCOLOR 4 FONT 6
     "Other Disc.":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 5.57 COL 54.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Seat :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 4.57 COL 105.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Insur. Officer  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 10.62 COL 43.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Covcod":30 VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 24.71 COL 24.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Expiry Date :":35 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 7.57 COL 36
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Car Code :":30 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 8.52 COL 70.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "CMR Code :":35 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 2.62 COL 27.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  Notified Office :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 10.62 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Account No.":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 16.67 COL 99
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Garage  :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 4.62 COL 79.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Policy 2Y:":30 VIEW-AS TEXT
          SIZE 10.33 BY .86 AT ROW 1.24 COL 97.5 WIDGET-ID 44
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 16.67 COL 39.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Comp. Prem :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 9.62 COL 36
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Notified Code :":30 VIEW-AS TEXT
          SIZE 14.33 BY .95 AT ROW 11.62 COL 57.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Licen No.:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 6.57 COL 71.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Power/HP :":30 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 4.57 COL 31.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "TP3":30 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 24.71 COL 89.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "User :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 13.71 COL 116.5 WIDGET-ID 272
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Engine no :":35 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 3.57 COL 29.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Last Name :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 12.62 COL 80.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  IMP :" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 14.71 COL 111.17 WIDGET-ID 274
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "ผลตรวจสภาพ :" VIEW-AS TEXT
          SIZE 14.17 BY .86 AT ROW 25.91 COL 24.33 WIDGET-ID 266
          BGCOLOR 29 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 134.5 BY 26.81
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Comp Com Date :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 8.43 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "CFRM :" VIEW-AS TEXT
          SIZE 6.67 BY .91 AT ROW 15.67 COL 111 WIDGET-ID 276
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Insur. Prem. :":25 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 9.62 COL 62.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขที่ตรวจสภาพ :" VIEW-AS TEXT
          SIZE 16.5 BY .86 AT ROW 25.91 COL 61.33 WIDGET-ID 268
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Provin Reg. :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.57 COL 94.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Sum FI :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 7.57 COL 91.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ตรวจสภาพ :" VIEW-AS TEXT
          SIZE 12.67 BY .86 AT ROW 25.91 COL 5.67 WIDGET-ID 270
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "                Title :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 12.62 COL 2
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Year :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 3.57 COL 12.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "         Policy  NEW :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 1.24 COL 59.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "First name :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 12.62 COL 35.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Package":30 VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 24.71 COL 38.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Chassis No :":20 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 3.62 COL 76.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Producer code  :":30 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 16.71 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "        Fleet Disc. :":35 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 5.57 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Notified No.:":35 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 2.62 COL 77
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Previous-Insur. :":35 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 13.67 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "      Accessory  :":30 VIEW-AS TEXT
          SIZE 16.17 BY .86 AT ROW 21.24 COL 3 WIDGET-ID 14
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Notified Time :":30 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 11.62 COL 33.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Insurance Company :":35 VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 2.62 COL 47
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " NCB Disc.:":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 5.57 COL 31.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "            Prem. 1 :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 9.62 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Per Used :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 8.57 COL 91.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Deduct. :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 5.52 COL 79.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 134.5 BY 26.81
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Sticker No.  :":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 9.62 COL 91.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "      Beneficiary  :":30 VIEW-AS TEXT
          SIZE 17.17 BY .86 AT ROW 17.76 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent [TISCO] :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.67 COL 79.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Susspect.":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 10.67 COL 114.5 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Addr_pol70 :":30 VIEW-AS TEXT
          SIZE 17.33 BY .95 AT ROW 14.67 COL 2
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Comp Exp Date :":30 VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 8.57 COL 36
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Client No. :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 16.67 COL 69
          BGCOLOR 19 FGCOLOR 0 FONT 6
     RECT-335 AT ROW 2.43 COL 1.67
     RECT-337 AT ROW 25.91 COL 109
     RECT-338 AT ROW 24.62 COL 109.17
     RECT-464 AT ROW 25.76 COL 5 WIDGET-ID 278
     RECT-465 AT ROW 24.67 COL 120.5 WIDGET-ID 284
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 134.5 BY 26.81
         BGCOLOR 19 FGCOLOR 1 .


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
         TITLE              = "Update Data TISCO"
         HEIGHT             = 26.86
         WIDTH              = 133.33
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 170.67
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_confirmdate IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_insp:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data TISCO */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data TISCO */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_car
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_car C-Win
ON CHOOSE OF bu_car IN FRAME fr_main /* Page 2 */
DO:
     nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqtis1(Input  nv_recidtlt).
        Apply "Close"  To this-procedure.
        RETURN NO-APPLY.
        
        {&WINDOW-NAME}:hidden  =  No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                    tlt.nor_noti_ins = Input  fi_polsystem
                    tlt.flag         = If  Input  ra_poltyp  =  1  Then  "N" Else  "R"
                    /*tlt.sentcnt      = Input  fi_difprm*/
                    tlt.ins_name     = Trim(Input  fi_firstname) + " "  + Trim(Input  fi_lastname)
                    tlt.rec_name     = Trim(Input  fi_title)
                   /* tlt.ins_addr1    = Input fi_addr1  */ /*A67-0114*/
                   /* tlt.ins_addr2    = Input fi_addr2  */ /*A67-0114*/
                    tlt.rec_addr3    = INPUT fi_pro_off 
                    tlt.rec_addr4    = INPUT fi_cmrcode
                    tlt.subins       = INPUT fi_ins_comp
                    tlt.nor_noti_tlt = INPUT fi_notno
                    tlt.lince2       = INPUT fi_year
                    tlt.colorcod     = INPUT fi_color
                    tlt.nor_coamt    = INPUT fi_sumsi
                    tlt.comp_coamt   = INPUT fi_gross_amt
                    tlt.nor_grprm    = INPUT fi_prem1     
                    tlt.comp_grprm   = INPUT fi_compprm   
                    tlt.nor_usr_ins  = INPUT fi_ins_off
                    tlt.nor_usr_tlt  = INPUT fi_not_off   
                    tlt.datesent     = INPUT fi_notdat
                    tlt.gentim       = INPUT fi_nottim
                    tlt.comp_usr_tlt = INPUT fi_notcode 
                    tlt.rec_addr2    = INPUT fi_preinsur 
                    tlt.safe3        = INPUT fi_client  
                    tlt.safe2        = INPUT fi_accno     
                    /*tlt.filler2      = trim(Input fi_remark1) + trim(Input  fi_remark2)*//*kridtiya i. A54-0216*/
                    tlt.filler2      = trim(Input fi_remark1) + 
                                      ( IF trim(Input  fi_remark2) <> "" THEN " r2:" + trim(Input  fi_remark2) ELSE " r2: " )  +  /*kridtiya i. A54-0216*/
                                      ( IF trim(Input  fi_remark3) <> "" THEN " r3:" + trim(Input  fi_remark3) ELSE " r3: " )  +  /*kridtiya i. A56-0323*/
                                      /*( IF trim(Input  fi_remark4) <> "" THEN " r4:" + trim(Input  fi_remark4) ELSE " r4: " )     /*A63-0210*/ */ /*A64-0092*/
                                       " acc:" + TRIM(fi_acc1) + " " + TRIM(fi_acc2) /*A64-0092*/
                                        + " " + TRIM(fi_acc3) + " " + TRIM(fi_acc4)   /*A67-0114*/
                    /*tlt.comp_usr_ins = trim(Input fi_remark4)  /*A63-0210*/*/
                    /*tlt.comp_usr_ins = fi_receipt2   */ /*A67-0114*/
                    tlt.filler1      = Input fi_policy  
                    tlt.lince2       = Input fi_year    
                    tlt.eng_no       = Input fi_eng_no  
                    tlt.cha_no       = Input fi_cha_no  
                    tlt.cc_weight    = Input fi_ton     
                    tlt.rencnt       = Input fi_power   
                    tlt.lince1       = Input fi_licence 
                    tlt.stat         = Input fi_garage  
                    tlt.lince3       = Input fi_province
                    tlt.brand        = Input fi_brand 
                    /*tlt.comp_sck     = Input fi_sckno */ /*A60-0095*/
                    tlt.comp_sck     = IF LENGTH(Input fi_sckno) <> 13 THEN "0" + INPUT fi_sckno ELSE INPUT fi_sckno 
                    tlt.endno        = STRING(Input  fi_deduct)
                    tlt.lotno        = STRING(Input  fi_fleetper)
                    tlt.seqno        = Input fi_ncbper 
                    tlt.endcnt       = Input fi_othper 
                    tlt.model        = Input fi_vehuse 
                    tlt.gendat       = Input fi_comdat 
                    tlt.expodat      = Input fi_expdat 
                    tlt.rec_name     = Input fi_title   
                    tlt.safe1        = Input fi_benname 
                    /*tlt.model        = INPUT fi_vehuse*/ /*A60-0118*/  
                    tlt.model        = "ISP:" + INPUT fi_inspno /*A60-0118*/  
                    tlt.model        = IF INPUT fi_detailisp <> "" THEN "ISP:" + INPUT fi_inspno + " " + "Detail:" + INPUT fi_detailisp ELSE "ISP:" + INPUT fi_inspno  /*A60-0118*/  
                    tlt.recac        = INPUT fi_accno2       
                    tlt.EXP          = INPUT fi_branch  /*add Kridtiya i. A54-0061 On   05/04/2011*/
                    tlt.expotim      = Input fi_pack
                    tlt.old_eng      = Input fi_tp1
                    tlt.old_cha      = Input fi_tp2
                    tlt.comp_pol     = Input fi_tp3
                    /*tlt.dri_name1    = INPUT fi_driv1
                    tlt.dri_name2    = INPUT fi_driv2
                    tlt.dri_no1      = string(INPUT fi_birth1,"99/99/9999")
                    tlt.dri_no2      = string(INPUT fi_birth2,"99/99/9999") */ /*A67-0114 */
                    tlt.expousr      = Input fi_covcod 
                    tlt.ins_addr3    = INPUT fi_addr70
                    tlt.ins_addr4    = Input fi_addr72
                    tlt.sentcnt      = fi_seatnew       /*A57-0017*/ 
                    /*tlt.ins_addr5     = trim(wdetail.apptyp)
                    tlt.comp_noti_tlt = trim(wdetail.appcode) */
                    /*tlt.usrsent       = wdetail.nBLANK */
                    /*tlt.comp_usr_tlt  = "ID70:"    + trim(fi_receiptid70)   + /*A57-0262*/ 
                                        "ID70br:"  + trim(fi_receiptidbr) + /*A57-0262*/
                                        "ID72:"    + trim(fi_receiptid72)   + /*A57-0262*/  
                                        "ID72br:"  + trim(fi_receiptidbr72)   /*A57-0262*/*/ /*A67-0114*/
                    tlt.comp_sub      = INPUT fi_producer           
                    tlt.comp_noti_ins = INPUT fi_agent            
                    /*tlt.rec_addr1     = INPUT fi_receipt*/ /*A67-0114*/
                    /*--- A60-0095 ----*/
                    SUBSTR(tlt.model,51,15) = STRING(INPUT fi_sumfi)  
                    tlt.nor_effdat          = INPUT fi_72comdat    
                    tlt.comp_effdat         = INPUT fi_72expdat 
                    SUBSTR(tlt.expotim,6,3) = STRING(INPUT fi_class )  
                    SUBSTR(tlt.expousr,7,3) = STRING(INPUT fi_caruse) 
                    tlt.usrsent             = INPUT fi_susspect      /*A63-00472*/
                    tlt.covcod   = trim(fi_covcodcd)   /*A65-0356*/ 
                   /* tlt.note1    = trim(fi_acctype)    /*A65-0356*/ 
                    tlt.note2    = trim(fi_acccovsum)  /*A65-0356*/ 
                    tlt.note3    = trim(fi_accprem)    /*A65-0356*/ 
                    tlt.note4    = trim(fi_inspect)    /*A65-0356*/ 
                    tlt.note5    = trim(fi_quoteno)    /*A65-0356*/ */ /*A67-0114*/
                    tlt.note6    = trim(fi_policy2yGWM)  .
                    /*---end A60-0095---*/
                   
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_covcod.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_covcod with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upins C-Win
ON CHOOSE OF bu_upins IN FRAME fr_main /* CHECK ISP */
DO: /*--- Create by A60-0118---*/
    DEF VAR nv_docno  AS CHAR FORMAT "x(25)".
    DEF VAR nv_survey AS CHAR FORMAT "x(25)".
    DEF VAR nv_detail AS CHAR FORMAT "x(30)".
    DEF VAR nv_year   AS CHAR FORMAT "x(5)".

    ASSIGN  nv_docno    = ""   nv_tmp   = ""   
            nv_year     = STRING(YEAR(TODAY),"9999")
            nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------*/
    /*nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\ranu\" + nv_tmp .*/
    /*-----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
      chNavView      = chNotesView:CreateViewNav.
      chDocument     = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).
      IF VALID-HANDLE(chDocument) = YES THEN DO:

          chitem       = chDocument:Getfirstitem("docno"). 
          IF chitem <> 0 THEN nv_docno   = chitem:TEXT. 
          ELSE nv_docno = "".

          chitem       = chDocument:Getfirstitem("SurveyClose").
          IF chitem <> 0 THEN nv_survey    = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").
          IF chitem <> 0 THEN nv_detail    = chitem:TEXT.
          ELSE nv_detail = "".

          IF nv_docno <> ""  THEN DO:
              IF nv_survey <> "" THEN DO:
                ASSIGN  fi_inspno = nv_docno
                        fi_insp   = "YES"
                        fi_detailisp = nv_detail.
              END.
              ELSE DO:
                  ASSIGN fi_inspno = nv_docno       
                         fi_insp   = "NO"          
                         fi_detailisp = "". 
              END.
          END.
          ELSE ASSIGN  fi_inspno = "" 
                       fi_insp   = "NO"
                       fi_detailisp = "".

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
      
      DISP fi_inspno fi_insp  fi_detailisp  WITH FRAME fr_main.

      /*--- end : A60-0118----*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_72comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_72comdat C-Win
ON LEAVE OF fi_72comdat IN FRAME fr_main
DO:
  fi_72comdat = INPUT fi_72comdat.
  DISP fi_72comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_72expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_72expdat C-Win
ON LEAVE OF fi_72expdat IN FRAME fr_main
DO:
  fi_72expdat = INPUT fi_72expdat.
  DISP fi_72expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc1 C-Win
ON LEAVE OF fi_acc1 IN FRAME fr_main
DO:
    fi_acc1 = trim(INPUT fi_acc1).
    DISP fi_acc1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc2 C-Win
ON LEAVE OF fi_acc2 IN FRAME fr_main
DO:
    fi_acc2 = trim(INPUT fi_acc2).
    DISP fi_acc2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc3 C-Win
ON LEAVE OF fi_acc3 IN FRAME fr_main
DO:
    fi_acc3 = trim(INPUT fi_acc3).
    DISP fi_acc3 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc4 C-Win
ON LEAVE OF fi_acc4 IN FRAME fr_main
DO:
    fi_acc4 = trim(INPUT fi_acc4).
    DISP fi_acc4 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno C-Win
ON LEAVE OF fi_accno IN FRAME fr_main
DO:
  fi_accno = INPUT fi_accno.
  DISP fi_accno WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno2 C-Win
ON LEAVE OF fi_accno2 IN FRAME fr_main
DO:
    fi_accno2 = INPUT fi_accno2 .
    DISP fi_accno2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr70 C-Win
ON LEAVE OF fi_addr70 IN FRAME fr_main
DO:
    fi_addr70 = INPUT fi_addr70.
    DISP fi_addr70 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr72 C-Win
ON LEAVE OF fi_addr72 IN FRAME fr_main
DO:
    fi_addr72 = INPUT fi_addr72.
    DISP fi_addr72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = INPUT fi_benname .
  DISP fi_benname WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  fi_branch = INPUT fi_branch.
  DISP fi_branch WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand = INPUT fi_brand .
  DISP fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_caruse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caruse C-Win
ON LEAVE OF fi_caruse IN FRAME fr_main
DO:
    fi_caruse = INPUT fi_caruse .
    DISP fi_caruse WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no C-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  =  Input  fi_cha_no.
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
    fi_class = INPUT fi_class .
    DISP fi_class WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_client
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_client C-Win
ON LEAVE OF fi_client IN FRAME fr_main
DO:
  fi_client = INPUT fi_client.
  DISP fi_client WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode C-Win
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
    fi_cmrcode = INPUT fi_cmrcode  .
    DISP fi_cmrcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color C-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
  fi_color = INPUT fi_color .
  DISP fi_color WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compprm C-Win
ON LEAVE OF fi_compprm IN FRAME fr_main
DO:
  fi_compprm = INPUT fi_compprm.
  DISP fi_compprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcodcd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcodcd C-Win
ON LEAVE OF fi_covcodcd IN FRAME fr_main
DO:
  fi_covcodcd = INPUT fi_covcodcd.
  DISP fi_covcodcd WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
  fi_deduct = INPUT fi_deduct.
  DISP fi_deduct WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_detailisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_detailisp C-Win
ON LEAVE OF fi_detailisp IN FRAME fr_main
DO:
    fi_detailisp = INPUT fi_detailisp.
    DISP fi_detailisp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  Input  fi_eng_no.
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fleetper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fleetper C-Win
ON LEAVE OF fi_fleetper IN FRAME fr_main
DO:
  fi_fleetper =  Input  fi_fleetper.
  Disp  fi_fleetper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage =  Input  fi_garage.
  Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gross_amt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gross_amt C-Win
ON LEAVE OF fi_gross_amt IN FRAME fr_main
DO:
  fi_gross_amt = INPUT fi_gross_amt.
  DISP fi_gross_amt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspno C-Win
ON LEAVE OF fi_inspno IN FRAME fr_main
DO:
    fi_inspno = INPUT fi_inspno.
    DISP fi_inspno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_comp C-Win
ON LEAVE OF fi_ins_comp IN FRAME fr_main
DO:
  fi_ins_comp = INPUT fi_ins_comp.
  DISP fi_ins_comp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off C-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
  fi_ins_off = INPUT fi_ins_off .
  DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence C-Win
ON LEAVE OF fi_licence IN FRAME fr_main
DO:
  fi_licence =  Input  fi_licence.
  Disp  fi_licence with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ncbper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbper C-Win
ON LEAVE OF fi_ncbper IN FRAME fr_main
DO:
  fi_ncbper =  Input  fi_ncbper.
  Disp  fi_ncbper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notcode C-Win
ON LEAVE OF fi_notcode IN FRAME fr_main
DO:
  fi_notcode = INPUT fi_notcode .
  DISP fi_notcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_main
DO:
  fi_notdat = INPUT fi_notdat .
  DISP fi_notdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nottim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nottim C-Win
ON LEAVE OF fi_nottim IN FRAME fr_main
DO:
  fi_nottim = INPUT fi_nottim .
  DISP fi_nottim WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_not_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_not_off C-Win
ON LEAVE OF fi_not_off IN FRAME fr_main
DO:
  fi_not_off = INPUT fi_not_off .
  DISP fi_not_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_othper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_othper C-Win
ON LEAVE OF fi_othper IN FRAME fr_main
DO:
  fi_othper =  Input  fi_othper.
  Disp  fi_othper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack = INPUT fi_pack .
    DISP fi_pack WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy2yGWM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy2yGWM C-Win
ON LEAVE OF fi_policy2yGWM IN FRAME fr_main
DO:
  fi_policy2yGWM = INPUT fi_policy2yGWM.
  DISP fi_policy2yGWM  WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polsystem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polsystem C-Win
ON LEAVE OF fi_polsystem IN FRAME fr_main
DO:
  fi_polsystem  =  Input  fi_polsystem.
  Disp  fi_polsystem with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_power
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_power C-Win
ON LEAVE OF fi_power IN FRAME fr_main
DO:
  fi_power  =  Input  fi_power.
  Disp  fi_power with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_preinsur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur C-Win
ON LEAVE OF fi_preinsur IN FRAME fr_main
DO:
  fi_preinsur = INPUT fi_preinsur .
  DISP fi_preinsur WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fi_producer.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pro_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pro_off C-Win
ON LEAVE OF fi_pro_off IN FRAME fr_main
DO:
  fi_pro_off = INPUT fi_pro_off.
  DISP fi_pro_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
    fi_remark1 = trim(INPUT fi_remark1).
    DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark3 C-Win
ON LEAVE OF fi_remark3 IN FRAME fr_main
DO:
    fi_remark3 = trim(INPUT fi_remark3).
    DISP fi_remark3 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno C-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_seatnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seatnew C-Win
ON LEAVE OF fi_seatnew IN FRAME fr_main
DO:
  fi_seatnew =  Input  fi_seatnew.
  Disp  fi_seatnew with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumfi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumfi C-Win
ON LEAVE OF fi_sumfi IN FRAME fr_main
DO:
    fi_sumfi = INPUT fi_sumfi.
    DISP fi_sumfi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_susspect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_susspect C-Win
ON LEAVE OF fi_susspect IN FRAME fr_main
DO:
  fi_susspect = INPUT fi_susspect.
  DISP fi_susspect WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
  fi_ton  =  Input  fi_ton.
  Disp  fi_ton with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp1 C-Win
ON LEAVE OF fi_tp1 IN FRAME fr_main
DO:
    fi_tp1 = INPUT fi_tp1 .
    DISP fi_tp1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp2 C-Win
ON LEAVE OF fi_tp2 IN FRAME fr_main
DO:
    fi_tp2 = INPUT fi_tp2 .
    DISP fi_tp2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp3 C-Win
ON LEAVE OF fi_tp3 IN FRAME fr_main
DO:
    fi_tp3 = INPUT fi_tp3.
    DISP fi_tp3 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year .
  DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_main
DO:
  Apply "Entry" to  fi_title.
  Return no-apply.
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
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
 
  gv_prgid = "wgwqtis2".
  gv_prog  = "Query &Update Data  (Tisco  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
  Rect-337:Move-to-top().
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_trndat     = tlt.trndat
          fi_policy     = tlt.filler1 
          fi_pro_off    = tlt.rec_addr3
          fi_cmrcode    = tlt.rec_addr4
          fi_ins_comp   = tlt.subins
          fi_preinsur   = tlt.rec_addr2
          fi_notno      = tlt.nor_noti_tlt
          fi_year       = tlt.lince2
          fi_eng_no     = tlt.eng_no
          fi_cha_no     = tlt.cha_no
          fi_ton        = tlt.cc_weight
          fi_power      = tlt.rencnt
          fi_color      = tlt.colorcod
          fi_licence    = tlt.lince1
          fi_garage     = tlt.stat
          fi_province   = tlt.lince3
          fi_brand      = tlt.brand
          fi_sckno      = tlt.comp_sck
          fi_sumsi      = tlt.nor_coamt
          fi_gross_amt  = tlt.comp_coamt
          fi_prem1      = tlt.nor_grprm
          fi_compprm    = tlt.comp_grprm
          fi_deduct     = Integer(tlt.endno)
          fi_fleetper   = Integer(tlt.lotno)
          fi_ncbper     = tlt.seqno
          fi_othper     = tlt.endcnt
          /*fi_vehuse     = tlt.model*/ /*A60-0118*/
          fi_comdat     = tlt.gendat
          fi_expdat     = tlt.expodat
          fi_ins_off    = tlt.nor_usr_ins
          fi_notcode    = tlt.comp_usr_tlt
          fi_not_off    = tlt.nor_usr_tlt
          fi_notdat     = tlt.datesent
          fi_nottim     = tlt.gentim
          fi_title      = tlt.rec_name
         /* fi_addr1      = tlt.ins_addr1
          fi_addr2      = tlt.ins_addr2
          fi_driv1      = tlt.dri_name1
          fi_driv2      = tlt.dri_name2
          fi_birth1     = date(SUBSTR(tlt.dri_no1,1,10))
          fi_birth2     = date(SUBSTR(tlt.dri_no2,1,10))*/ /* A67-0114*/
          /*fi_agent      =  tlt.recac*/
          fi_client     =  tlt.safe3
          fi_accno      =  tlt.safe2
          fi_accno2     =  tlt.recac
          /*fi_receipt    =  tlt.rec_addr1*//*A67-0114*/
          /*fi_receipt2   =  IF index(tlt.comp_usr_ins,"a1:") <> 0 THEN SUBSTR(tlt.comp_usr_ins,1,INDEX(tlt.comp_usr_ins,"a1:") - 1) ELSE TRIM(tlt.comp_usr_ins)*/
          fi_benname    =  tlt.safe1
          fi_userid     =  tlt.usrid 
          fi_branch     =  tlt.EXP     /*add Kridtiya i. A54-0061 On   05/04/2011*/
          fi_pack       =  SUBSTR(tlt.expotim,1,5)  
          fi_tp1        =  tlt.old_eng  
          fi_tp2        =  tlt.old_cha  
          fi_tp3        =  tlt.comp_pol 
          fi_covcod     =  tlt.expousr  
          fi_addr70     =  tlt.ins_addr3
          fi_addr72     =  tlt.ins_addr4
          fi_seatnew    =  tlt.sentcnt     /*A57-0017*/ 
          /*tlt.ins_addr5     = trim(wdetail.apptyp)
          tlt.comp_noti_tlt = trim(wdetail.appcode) */
          /*tlt.usrsent       = wdetail.nBLANK */
          /*fi_pack       =  tlt.expotim    */              
          fi_tp1        =  tlt.old_eng                
          fi_tp2        =  tlt.old_cha                
          fi_tp3        =  tlt.comp_pol               
          fi_covcod     =  tlt.expousr                
          fi_producer   =  tlt.comp_sub                 
          fi_agent      =  tlt.comp_noti_ins          
          fi_remark1    =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2)
          fi_remark2    =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""
          fi_remark2    =  IF index(fi_remark2,"r3:")  <> 0 THEN   Substr(fi_remark2,1,index(fi_remark2,"r3:") - 1)  ELSE fi_remark2
          fi_remark3    =  IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE ""
          /*fi_remark3    =  IF index(fi_remark3,"r4:")  <> 0 THEN   Substr(fi_remark3,1,index(fi_remark3,"r4:") - 1 ) ELSE fi_remark3   /*A63-0210*/ */ /*A64-0092*/ 
          /*fi_remark4    =  IF index(tlt.filler2,"r4:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r4:") + 3 ) ELSE ""         /*A63-0210*/ */ /*A64-0092*/ 
          /* add by : A64-0092 */
          fi_remark3    =  IF index(fi_remark3,"r4:")   <> 0 THEN REPLACE(fi_remark3,"r4:"," ") ELSE fi_remark3   /*A64-0092*/
          fi_remark3    =  IF index(fi_remark3,"acc:")  <> 0 THEN Substr(fi_remark3,1,index(fi_remark3,"acc:") - 1 ) ELSE fi_remark3   
          nv_acc        =  IF index(tlt.filler2,"acc:") <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"acc:") + 4 )) 
                           ELSE IF index(tlt.filler2,"คค.") <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"คค."))) 
                           ELSE IF index(tlt.filler2,"||")  <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"||") + 2))
                           /*ELSE IF index(tlt.filler2," ")   <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2," ") + 1))*/
                           ELSE "" 
          nv_acc        =  IF INDEX(nv_acc,"r2:") <> 0 THEN REPLACE(nv_acc,"r2:","") ELSE nv_acc
          nv_acc        =  IF INDEX(nv_acc,"r3:") <> 0 THEN REPLACE(nv_acc,"r3:","") ELSE nv_acc
          nv_acc        =  IF INDEX(nv_acc,"r4:") <> 0 THEN REPLACE(nv_acc,"r4:","") ELSE nv_acc
          fi_acc1       =  IF LENGTH(nv_acc) > 120 THEN trim(SUBSTR(nv_acc,1,120))   ELSE nv_acc          
          fi_acc2       =  IF LENGTH(nv_acc) > 121 THEN trim(SUBSTR(nv_acc,121,120)) ELSE "" 
          fi_acc3       =  IF LENGTH(nv_acc) > 241 THEN trim(SUBSTR(nv_acc,241,120)) ELSE ""
          fi_acc4       =  IF LENGTH(nv_acc) > 361 THEN trim(SUBSTR(nv_acc,361,LENGTH(nv_acc))) ELSE "" 
          /*...end A67-0114...*/
          /* end a64-0092 */
          nv_index      =  Index(tlt.ins_name," ")
          fi_firstname  = Substr(tlt.ins_name,1,nv_index - 1) 
          fi_lastname   = Substr(tlt.ins_name,nv_index + 1,length(tlt.ins_name)) 
          fi_polsystem  = tlt.nor_noti_ins  
          ra_poltyp     = If tlt.flag  =  "N"  Then  1  Else 2  
          nv_chaidrep   = trim(tlt.comp_usr_tlt)
          /*A60-0118*/ 
          fi_insp       = IF INDEX(brstat.tlt.model,"Detail") <> 0 THEN "YES" ELSE "NO"                           
          fi_inspno     = IF INDEX(brstat.tlt.model,"ISP")  <> 0 AND INDEX(brstat.tlt.model,"Detail") <> 0 THEN 
                          SUBSTR(brstat.tlt.model,5,INDEX(brstat.tlt.model,"Detail") - 6 ) 
                          ELSE IF INDEX(brstat.tlt.model,"ISP")  <> 0 THEN SUBSTR(brstat.tlt.model,5,INDEX(brstat.tlt.model," ")) ELSE ""
          fi_detailisp  = IF INDEX(brstat.tlt.model,"Detail") <> 0 THEN SUBSTR(brstat.tlt.model,INDEX(brstat.tlt.model,"Detail:") + 7,INDEX(brstat.tlt.model," "))
                          ELSE ""
           /*A60-0118*/
           /*- Manop G. -*/
          /*fi_sumfi      =  INT(SUBSTR(tlt.model,51,10))*/ /*A60-0118*/
          fi_sumfi      =  INT(SUBSTR(tlt.model,51,15))     /*A60-0118*/
          fi_72comdat   =  tlt.nor_effdat           /* คุ้มครอง พรบ */    
          fi_72expdat   =  tlt.comp_effdat         /* สิ้นสุด พรบ */
          fi_class      =  SUBSTR(tlt.expotim,6,3)
          fi_caruse     =  SUBSTR(tlt.expousr,7,3)
          fi_susspect   =  tlt.usrsent          /*A63-00472*/
          fi_covcodcd   = trim(tlt.covcod)   /*A65-0356*/ 
          /* comment by : A67-0114....
          fi_acctype    = trim(tlt.note1)    /*A65-0356*/ 
          fi_acccovsum  = trim(tlt.note2)    /*A65-0356*/ 
          fi_accprem    = trim(tlt.note3)    /*A65-0356*/ 
          fi_inspect    = trim(tlt.note4)    /*A65-0356*/ 
          fi_quoteno    = trim(tlt.note5)   /*A65-0356*/ 
          ..end A67-0114...*/
          fi_confirmdate = tlt.ndate1       /*A65-0356*/ 
          
          fi_policy2yGWM = tlt.note6 .

   /* comment by : Ranu I. A67-0114 ...
   ASSIGN fi_receiptidbr72 = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE  /*A57-0262*/
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 )) /*A57-0262*/
       nv_chaidrep      = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE            /*A57-0262*/
           trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 )) /*A57-0262*/ 

       fi_receiptid72   = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           /*A57-0262*/  
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))  /*A57-0262*/

       nv_chaidrep      = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE               /*A57-0262*/
                          trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))    /*A57-0262*/

       fi_receiptidbr   = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))  /*A57-0262*/ 
       nv_chaidrep      = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE             /*A57-0262*/
                          trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) /*A57-0262*/
                          
       fi_receiptid70   = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE 
                             trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 )).    /*A57-0262*/ 
   ...end A67-0114...*/
/*
       ASSIGN 
           n_Rec_name72   = IF index(nv_cutrec,"Rname:") = 0 THEN "" ELSE            /*Start A63-0210*/          
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Rname:") + 6 ))   
           nv_cutrec      = IF index(nv_cutrec,"Rname:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,1,index(nv_cutrec,"Rname:") - 1 )) 
           n_Rec_add1     = IF index(nv_cutrec,"Radd1:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Radd1:") + 6 ))   
           nv_cutrec      = IF index(nv_cutrec,"Radd1:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,1,index(nv_cutrec,"Radd1:") - 1 )) 
           n_Rec_add2     = IF index(nv_cutrec,"Radd2:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Radd2:") + 6 ))   /*End A63-0210*/

           fi_remark4    =  TRIM(n_Rec_name72) +  TRIM(n_Rec_add1) + TRIM(n_Rec_add2) /*A63-0210*/
                                .*/
            
     Disp     fi_policy        fi_pro_off       fi_cmrcode        fi_covcodcd 
              fi_ins_comp      fi_preinsur      fi_notno         /*fi_acctype */     /*A67-0114*/   
              fi_year          fi_eng_no        fi_cha_no        /* fi_acccovsum */  /*A67-0114*/    
              fi_ton           fi_power         fi_color         /* fi_accprem   */  /*A67-0114*/    
              fi_licence       fi_garage        fi_province      /* fi_inspect  */   /*A67-0114*/    
              fi_brand         fi_sckno         fi_sumsi         /* fi_quoteno  */   /*A67-0114*/
              fi_sumfi         fi_72comdat      fi_72expdat
              fi_class         fi_caruse           /* Manop G. */ 
              fi_gross_amt     fi_prem1         fi_compprm  
              fi_deduct        fi_fleetper      fi_ncbper  
              fi_othper        fi_vehuse        fi_comdat  
              fi_expdat        fi_ins_off       fi_notcode  fi_confirmdate /*A65-0356*/
              fi_not_off       fi_notdat        fi_nottim   fi_seatnew  /*A57-0017*/ 
              fi_title         fi_firstname     fi_lastname fi_addr70 
              /*fi_addr1         fi_addr2 A67-0114*/        fi_agent    fi_addr72
              fi_client        fi_accno         /*fi_receipt*/ /*A67-0114*/  fi_accno2 fi_remark3
              fi_benname       fi_remark1       fi_remark2  /*fi_birth1*/ /*A67-0114*/  fi_producer
              fi_polsystem     ra_poltyp        fi_trndat   /*fi_birth2*/ /*A67-0114*/  fi_agent   
              fi_userid        fi_pack          fi_tp1      /*fi_driv1   fi_driv2
              fi_receiptid70  fi_receiptidbr    fi_receiptid72  fi_receiptidbr72 */ /*A67-0114*/   fi_susspect   /*A63-00472*/
              fi_tp2           fi_tp3           fi_covcod   fi_branch   /*add Kridtiya i. A54-0061 On   05/04/2011*/
              fi_insp          fi_inspno        fi_detailisp       /*A60-0118*/ /*fi_remark4 /*A63-0210*/ A64-0092*/  /*fi_receipt2*/ /*A67-0114*/
              fi_acc1          fi_acc2          fi_acc3     fi_acc4     fi_policy2yGWM   fi_confirmdate  /*A64-0092*/
      With frame  fr_main.               

          
  End.
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
  DISPLAY fi_policy fi_pro_off fi_cmrcode fi_ins_comp fi_polsystem fi_notno 
          fi_year fi_eng_no fi_ton fi_power fi_color fi_garage fi_cha_no 
          fi_fleetper fi_ncbper fi_othper fi_deduct fi_vehuse fi_seatnew 
          fi_brand fi_licence fi_province fi_comdat fi_expdat fi_sumsi fi_sumfi 
          fi_72comdat fi_72expdat fi_class fi_caruse fi_prem1 fi_compprm 
          fi_gross_amt fi_sckno fi_not_off fi_ins_off fi_notdat fi_nottim 
          fi_notcode fi_title fi_firstname fi_lastname fi_preinsur fi_accno2 
          fi_addr70 fi_addr72 fi_producer fi_agent fi_client fi_accno 
          fi_susspect fi_benname fi_remark1 fi_remark2 fi_remark3 fi_branch 
          fi_covcod fi_pack fi_tp1 fi_tp2 fi_tp3 ra_poltyp fi_trndat fi_userid 
          fi_acc1 fi_acc2 fi_covcodcd fi_confirmdate fi_policy2yGWM fi_detailisp 
          fi_insp fi_inspno fi_acc3 fi_acc4 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_policy fi_pro_off fi_cmrcode fi_ins_comp fi_polsystem fi_notno 
         fi_year fi_eng_no fi_ton fi_power fi_color fi_garage fi_cha_no 
         fi_fleetper fi_ncbper fi_othper fi_deduct fi_vehuse fi_seatnew 
         fi_brand fi_licence fi_province fi_comdat fi_expdat fi_sumsi fi_sumfi 
         fi_72comdat fi_72expdat fi_class fi_caruse fi_prem1 fi_compprm 
         fi_gross_amt fi_sckno fi_not_off fi_ins_off fi_notdat fi_nottim 
         fi_notcode fi_title fi_firstname fi_lastname fi_preinsur fi_accno2 
         fi_addr70 fi_addr72 fi_producer fi_agent fi_client fi_accno 
         fi_susspect fi_benname fi_remark1 fi_remark2 fi_remark3 fi_branch 
         fi_covcod fi_pack fi_tp1 fi_tp2 fi_tp3 bu_save ra_poltyp bu_exit 
         fi_acc1 fi_acc2 fi_covcodcd fi_policy2yGWM fi_detailisp bu_upins 
         fi_insp fi_inspno fi_acc3 fi_acc4 bu_car RECT-335 RECT-337 RECT-338 
         RECT-464 RECT-465 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

