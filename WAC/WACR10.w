&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME Wacr10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Wacr10 
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

/************   Program   **************
/*  Notes: ��ѡ��ùѺ�ʹ���������ôԵ ��� ��ҧ���� STATEMENT (A4)
              -  �� Tran Date ��  �ִ�ѹ��� 1 �ͧ��͹�Ѵ� ������Ѻ����������� credit 
              - ��  �ѹ��� 1 �ͧ��͹�Ѵ�  +  credit term( 30 �ѹ = 1 ��͹ )   ���Ǩ���������������ش ������  credit
                ��ͧ within Credit ��� ���������������͹ ��͹�ú��˹�����
                       due Amount ��� ��������ͧ��͹�ú��˹�����
                       overdue   ��� �����������Թ��˹�
                 �ó� credit Term =  0  ��������� overdue
              -  �ҡ��鹹��ѹ�������ش������  credit  ��� �ѹ����ǧ�������ҡ�ä�ҧ����  �ء��ǧ
              - ���ѹ�������Ъ�ǧ���Ǩ֧��   As date ����º  �ҡ��鹨֧����� 㹵���õ�ҧ �  �����ʴ��ŵ���*/

/* CREATE BY :  Kanchana C.        A44-0233*/
/* Modify By : Kanchana C.             A44-0233  
    03/07/2002 "������ asdate " 
    08/07/2002 "�� �͹ź�����šó� asdat ���ǡѹ �ҡ by_trndat_acno  ��� by_acno */
/* Modify By : Kanchana C.             04/11/2002 
    - ���� process date ��ŧ entrdat */
/* Modify By : Kanchana C.             A46-0015    09/01/2003
    - ���� Process  trnty1  = "O", "T"     (Inward Policy)
        ���������  ���     wacr01.w     - "PROCESS PREMIUM STATEMENT (A4)"
        �¡������͡�� wacr0101.w - "PROCESS PREMIUM STATEMENT (A4) DAILY"
    - �� process complete   ���  SUBSTRING(acProc_fil.enttim,10,3)  = "YES" 
*/
/* Modify By : KuK         A46-0130     18/04/2003 
    ���� Title ������ agtprm_fil.ac_name 㹡�� Process */
/* Modify : Kanchana C.  07/05/2003    Assign No.  :   A46-0142
    2. ��Ѻ������     ��äԴ �/� �ѡ     type YS, ZS   ��� �١˹�� �礤׹  type C, B      ����ա�äԴ credit term
        duedat = trandat  (�����ǹ����� process statement a4    program name : wacr01.w , wacr0101.w)
*/      
/* Modify : Kanchana C.  23/03/2004    Assign No.  :   A47-0108
    - Fix ���͹���������� ��� �ѹ��� Contra date  �ջ� �����������ҡ���� 2  ��� Bal = 0 �������� ����ͧ�֧����͡��  (�Ҩ�ա���к� contra date �Թ��ԧ)*/
/* Modify : Kanchana C.  21/04/2004    Assign No.  :   A47-0142
    - ��Ѻ Process Statement  A4 
    1. �óշ������������Ţ �/�  ����ͧ  ��Ҥ�ҷҧ��� uw   (���ͧ�ҡ �ҧ���  UW  �բ����ŷ��  �/�  �繪�ͧ��ҧ   ����� Br.  ��� �/�  �� Br.  0)
    2. �� client type code   ���   xmm600.clicod
*/


/* ���������������ѹ*/
Wac
        -Wacr10.w             /* PROCESS PREMIUM STATEMENT (A4) */
                                       /*  �� Warc02.w ��� print  PRINT PREMIUM STATEMENT (A4)*/
        -Wacc10.p
Whp
        -WhpAcno.w
Wut
        -WutDiCen.p
        -WutWiCen.p

------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   13/11/2007   [A500178]
             ��Ѻ format branch �����ͧ�Ѻ��â����Ң�
             ���� format fiacno1, fiacno2 �ҡ "X(7)" ��  Char "X(10)"
-------------------------------------------------------------------------
 Modify By A50-0218  Sayamol  ��Ѻ Process ���ç�Ѻ Report ����ͧ���
 
 -----------------------------------------------------------------------
 Modify By A51-0124  Sayamol  �� Process & Report & Branch
 
 -----------------------------------------------------------------------
 Modify By A51-0186  AMPARAT C. 
       Outward Fac ��� Premium ��� Claim ����բ����ź������ Safety Soft ��ѧ��� Process  
 
 Modify By: Lukkana M. Date : 30/10/2009
 Assign No: A52-0241 ��������´�ѧ���
            -  �礢����Ť�� req no . ���ͧ�ҡ����������͡
            -  �纤�� Total calim , share(%)
/* Modify By : Benjaporn J. [A60-0267] date 30/09/2017    
             : ���� Format Docno. �ҡ 7 ��ѡ�� 10 ��ѡ           */ 
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ��Ѻ�����Ţ Document �ҡ 7 �� 10 ��ѡ ���͹�����к����١��ͧ                  */
                   
*****************************************/    
/* ***************************  Definitions  ************************** */
DEF  SHARED VAR n_User   AS CHAR.
DEF  SHARED VAR n_Passwd AS CHAR.  
/*DEF      VAR   nv_User     AS CHAR NO-UNDO. 
 * DEF      VAR   nv_pwd    LIKE _password NO-UNDO.*/

/* Definitons  Report -------                                               */
DEF  VAR report-library       AS CHAR INIT "wAC/wprl/wac_sm01.prl".
DEF  VAR report-name          AS CHAR INIT "Statement of Account By Trandate".
DEF  VAR RB-DB-CONNECTION     AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS   AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER            AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE         AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME      AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT      AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE       AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES     AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE        AS INTE INIT 0.
DEF  VAR RB-END-PAGE          AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN      AS LOG  INIT no.
DEF  VAR RB-WINDOW-TITLE      AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS    AS LOG  INIT yes.
DEF  VAR RB-DISPLAY-STATUS    AS LOG  INIT yes.
DEF  VAR RB-NO-WAIT           AS LOG  INIT no.
DEF  VAR RB-OTHER-PARAMETERS  AS CHAR INIT "".

/* Parameters Definitions ---                                           */
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(7)".
------*/
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".

Def Var  n_name     As Char Format "x(50)". /*acno name*/
Def Var  n_chkname  As Char format "x(1)".  /* Acno-- chk button 1-2 */
Def Var  n_bdes     As Char Format "x(50)". /*branch name*/
Def Var  n_chkBname As Char format "x(1)".  /* branch-- chk button 1-2 */

/* Local Variable Definitions ---        */

DEF VAR nv_asmth    AS INTE INIT 0.
DEF VAR nv_frmth    AS INTE INIT 0.
DEF VAR nv_tomth    AS INTE INIT 0.
DEF VAR cv_mthListT AS CHAR INIT "���Ҥ�,����Ҿѹ��,�չҤ�,����¹,����Ҥ�,�Զع�¹,�á�Ҥ�,�ԧ�Ҥ�,�ѹ��¹,���Ҥ�,��Ȩԡ�¹,�ѹ�Ҥ�".
DEF VAR cv_mthListE AS CHAR INIT " January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_frdate   AS DATE FORMAT "99/99/9999".
DEF VAR n_todate   AS DATE FORMAT "99/99/9999".
DEF VAR n_asdat    AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto AS DATE FORMAT "99/99/9999".

/*DEF VAR n_y        AS   CHAR   FORMAT "X".*/

DEF VAR n_chkCopy    AS INTEGER.
DEF VAR n_OutputTo   AS INTEGER.
DEF VAR n_OutputFile AS Char.

DEF VAR vCliCod    AS CHAR.
DEF VAR vCliCodAll AS CHAR.
DEF VAR vCountRec  AS INT.

/* --------------------- Define Var use in process ---------------------------*/
DEF VAR n_frbr AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr AS   CHAR   FORMAT "x(2)".
/*--- A500178 ---
DEF VAR n_frac AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac AS   CHAR   FORMAT "x(7)".
------*/
DEF VAR n_frac AS   CHAR   FORMAT "x(10)".
DEF VAR n_toac AS   CHAR   FORMAT "x(10)".
DEF VAR n_typ  AS   CHAR   FORMAT "X".
DEF VAR n_typ1 AS   CHAR   FORMAT "X".
DEF VAR n_day  AS   INTE   FORMAT ">>9".
DEF VAR n_wcr  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nt_tdat   AS   CHAR   FORMAT "X(10)".
DEF VAR nt_asdat  AS   CHAR   FORMAT "X(10)".
DEF VAR n_xtm600  LIKE xtm600.name.
DEF VAR n_acc     LIKE acm001.acno FORMAT "X(10)".  /*--- A500178 --- ���� FORMAT "X(10)" ---*/
DEF VAR n_add1    LIKE xtm600.addr1.
DEF VAR n_add2    LIKE xtm600.addr2.
DEF VAR n_add3    LIKE xtm600.addr3.
DEF VAR n_add4    LIKE xtm600.addr4.
DEF VAR n_ltamt   LIKE xmm600.ltamt.
DEF VAR n_insur   AS   CHAR   FORMAT "x(35)".
DEF VAR n_trntyp  AS   CHAR   FORMAT "x(11)".
DEF VAR n_mocom   LIKE acm001.stamp.
DEF VAR n_prem    LIKE acm001.netamt.
DEF VAR n_comp    AS   DECI   FORMAT "->>,>>9.99".
DEF VAR n_gross   LIKE acm001.netamt.
                  
DEF VAR n_year    AS INTE FORMAT ">>9".
DEF VAR n_polyear AS CHAR FORMAT "X(4)".
DEF VAR n_cedpol  AS CHAR FORMAT "X(16)".
DEF VAR n_opnpol  AS CHAR FORMAT "X(16)".
DEF VAR n_prvpol  AS CHAR FORMAT "X(16)".
DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat    AS DATE FORMAT "99/99/9999".
DEF VAR n_poldes    AS CHAR FORMAT "X(35)".
DEF VAR n_polbrn    AS CHAR FORMAT "X(2)".
DEF VAR n_comdat    AS DATE FORMAT "99/99/9999".

DEF VAR vCountDay   AS INT.
DEF VAR n_comm      AS DECI FORMAT "->>,>>9.99".
DEF VAR n_comm_comp AS DECI FORMAT "->>,>>9.99".
DEF VAR n_odue1     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF VAR n_odue2     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF VAR n_odue3     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF VAR n_odue4     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/
DEF VAR n_odue5     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months*/

/* pdprocess2 */
DEF VAR n_day1 AS INT.
DEF VAR n_day2 AS INT.

DEF VAR v_trntyp12 AS CHAR init "".

/*  work table */
/*  DEF  TEMP-TABLE  wacm001
 * /*  DEF  workfile  wacm001*/
 * 
 *               FIELD  acno     LIKE acm001.acno
 *               FIELD  agent     LIKE acm001.agent
 *               FIELD  trndat    LIKE acm001.trndat
 *               FIELD  trnty1     LIKE acm001.trnty1
 *               FIELD  trnty2     LIKE acm001.trnty2
 *               FIELD  docno     LIKE acm001.docno
 *               FIELD  insno     LIKE acm001.insno
 *               FIELD  clicod     LIKE acm001.clicod
 *               FIELD  prem     LIKE acm001.prem
 *               FIELD  comm     LIKE acm001.comm
 *               FIELD  stamp     LIKE acm001.stamp
 *               FIELD  tax     LIKE acm001.tax
 *               FIELD  bal     LIKE acm001.bal
 *               FIELD  policy     LIKE acm001.policy
 *               FIELD  rencnt     LIKE acm001.rencnt
 *               FIELD  endcnt     LIKE acm001.endcnt
 *               FIELD  recno     LIKE acm001.recno
 *               FIELD  poltyp     LIKE acm001.poltyp
 *               FIELD  vehreg    LIKE acm001.vehreg
 *               FIELD  latdat     LIKE acm001.latdat
 *               FIELD  comdat  LIKE acm001.comdat
 *               FIELD  ref     LIKE acm001.ref
 *       INDEX  wacm001 IS UNIQUE PRIMARY acno trndat policy 
 *                                     trnty1 trnty2 docno recno ASCENDING.*/

DEF VAR n_recid AS RECID.
DEF VAR nv_type AS CHAR INIT "06".  /* "PROCESS STATEMENT CLAIM FAC. */
DEF VAR n_chkprocess AS LOGIC INIT NO.
/**/
DEF VAR nv_acm001   AS INT.
DEF VAR nv_acm001F  AS INT.
DEF VAR nv_acm001L  AS INT.
DEF VAR nv_findXmm  AS INT.
DEF VAR nv_findXmmF AS INT.
DEF VAR nv_findXmmL AS INT.
DEF VAR nv_finduwm  AS INT.
DEF VAR nv_finduwmF AS INT.
DEF VAR nv_finduwmL AS INT.
DEF VAR nv_create   AS INT.
DEF VAR nv_createF  AS INT.
DEF VAR nv_createL  AS INT.

DEF VAR nv_File-Name AS CHAR INIT "C:\temp\proc1".
DEF VAR vBackUp AS CHAR.

DEF VAR nv_YZCB AS CHAR INIT "YS,ZS,C,B". /* type ��� ���Դ credit term*/  /*A46-0142*/
/**/
DEF VAR n_clicod AS CHAR.

/*A50-0218*/
DEF VAR n_losdat   AS DATE.
DEF VAR nv_loss    AS CHAR.
DEF VAR n_risi_p   AS DEC FORMAT ">9.99".  
/*----A60-0267 
DEF VAR nv_req     AS CHAR.
DEF VAR reqno      AS CHAR.  ----*/
DEF VAR nv_req     AS CHAR FORMAT "x(13)"  .
DEF VAR reqno      AS CHAR FORMAT "x(13)"  .
/*----- A60-0267 ------*/
DEF VAR nv_netvat  AS DEC.
DEF VAR nv_vat     AS DEC. 
DEF VAR nv_tax     AS DEC.
DEF VAR nv_netamt  AS DEC.
DEF VAR nv_total   AS DEC.
DEF VAR nv_etotal  AS DEC.
DEF VAR nv_fex      AS LOGIC.
/*--------*/

/*--A51-0124--*/
DEF VAR nv_inscod  AS CHAR FORMAT "X(35)".
DEF VAR nv_insname AS CHAR FORMAT "X(35)".
/*------------*/
DEF VAR n_type  AS  CHAR FORMAT "X(2)".
/*--Lukkana M. A52-0241 28/10/2009--*/
DEF VAR  nv_totalb      AS DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  nv_pad         AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_pad1        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_pad_ch      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_pad_ch1     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_fee         AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_fee1        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_exp         AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_exp1        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_vat1        AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nt_pad         AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nt_pad_shar    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_totcl        AS DECI.   
DEF VAR n_docno         AS CHAR FORMAT "X(10)" . /* A60-0267 */  
/*--Lukkana M. A52-0241 28/10/2009--*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frCommand

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-406 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear Wacr10 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay Wacr10 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumDay Wacr10 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth Wacr10 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Wacr10 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-406
     EDGE-PIXELS 0    
     SIZE 133 BY 1.81
     BGCOLOR 3 .

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "CANCEL" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 23.5 BY 2.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23.5 BY 2.38
     BGCOLOR 1 .

DEFINE BUTTON buAcno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "���� Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "���� Producer"
     FONT 6.

DEFINE VARIABLE cbAsMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCount AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 108 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE reAsdate
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112.5 BY 4.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-88
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112.5 BY 1.76
     BGCOLOR 8 .

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112.5 BY 4.76
     BGCOLOR 8 .

DEFINE VARIABLE cbFrMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbToMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-407
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89 BY 3.57
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frCommand
     " PROCESS STATEMENT CLAIM FAC.":120 VIEW-AS TEXT
          SIZE 51.5 BY 1 AT ROW 1.43 COL 44.5
          BGCOLOR 3 FGCOLOR 7 FONT 23
     RECT-406 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22.4
         BGCOLOR 19 .

DEFINE FRAME frMain
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 3.33
         SIZE 129.5 BY 19.5
         BGCOLOR 3 .

DEFINE FRAME frTranDate
     fiFrDay AT ROW 2.91 COL 30.83 COLON-ALIGNED NO-LABEL
     cbFrMth AT ROW 2.91 COL 34.33 COLON-ALIGNED NO-LABEL
     fiFrYear AT ROW 2.91 COL 50.5 COLON-ALIGNED NO-LABEL
     fiToDay AT ROW 4.29 COL 30.83 COLON-ALIGNED NO-LABEL
     cbToMth AT ROW 4.29 COL 34.33 COLON-ALIGNED NO-LABEL
     fiToYear AT ROW 4.29 COL 50.5 COLON-ALIGNED NO-LABEL
     "                      TO :":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "�֧" AT ROW 4.29 COL 12.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   TRANSACTION  DATE":40 VIEW-AS TEXT
          SIZE 88.83 BY 1 TOOLTIP "�ѹ���ӡ�������" AT ROW 1.19 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                  FORM :":30 VIEW-AS TEXT
          SIZE 20 BY 1 TOOLTIP "�����" AT ROW 2.95 COL 12.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-407 AT ROW 2.29 COL 7.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 14.76
         SIZE 97 BY 5.24
         BGCOLOR 19 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.91 COL 6.67
     Btn_Cancel AT ROW 4.29 COL 6.67
     RECT-3 AT ROW 3.71 COL 2.67
     RECT2 AT ROW 1.29 COL 2.67
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 102 ROW 14.76
         SIZE 26.5 BY 5.24
         BGCOLOR 19 .

DEFINE FRAME frST
     fiacno1 AT ROW 3.38 COL 30.83 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 3.43 COL 47.5
     fiacno2 AT ROW 4.67 COL 30.83 COLON-ALIGNED NO-LABEL
     buAcno2 AT ROW 4.71 COL 47.5
     fiAsDay AT ROW 7.57 COL 30.83 COLON-ALIGNED NO-LABEL
     cbAsMth AT ROW 7.57 COL 34.5 COLON-ALIGNED NO-LABEL
     fiAsYear AT ROW 7.57 COL 50.67 COLON-ALIGNED NO-LABEL
     fiCount AT ROW 7.57 COL 68 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 9.14 COL 30.83 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 3.29 COL 49 COLON-ALIGNED
     finame2 AT ROW 4.33 COL 48.83 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 12 COL 10
     "         AS OF DATE :":30 VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 7.57 COL 12.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO :":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "���ʵ��᷹�֧" AT ROW 4.62 COL 27.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "FORM :":40 VIEW-AS TEXT
          SIZE 7.83 BY .95 TOOLTIP "���ʵ��᷹����������" AT ROW 3.38 COL 25
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  PRODUCER  CODE":40 VIEW-AS TEXT
          SIZE 111.5 BY 1 TOOLTIP "���ʵ��᷹" AT ROW 1.81 COL 8
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "   PROCESS DATE :":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "�ѹ����͡��§ҹ" AT ROW 9.14 COL 12.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     reAsdate AT ROW 6.81 COL 7.5
     RECT-88 AT ROW 11.57 COL 7.5
     RECT11 AT ROW 1.57 COL 7.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.5 ROW 1.38
         SIZE 126 BY 13.05
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
  CREATE WINDOW Wacr10 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr10 - PROCESS STATEMENT CLAIM FAC."
         HEIGHT             = 22.38
         WIDTH              = 132
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
IF NOT Wacr10:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Wacr10
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME frCommand:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE
       FRAME frTranDate:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME frCommand
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frMain
                                                                        */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frTranDate:MOVE-BEFORE-TAB-ITEM (FRAME frOK:HANDLE)
       XXTABVALXX = FRAME frST:MOVE-BEFORE-TAB-ITEM (FRAME frTranDate:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frST
                                                                        */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

/* SETTINGS FOR FRAME frTranDate
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Wacr10)
THEN Wacr10:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Wacr10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Wacr10 Wacr10
ON END-ERROR OF Wacr10 /* wacr10 - PROCESS STATEMENT CLAIM FAC. */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Wacr10 Wacr10
ON WINDOW-CLOSE OF Wacr10 /* wacr10 - PROCESS STATEMENT CLAIM FAC. */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Wacr10
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* CANCEL */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Wacr10
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
    DEF VAR vAcno       AS CHAR INIT "".
    DEF VAR vFirstTime  AS CHAR INIT "".
    DEF VAR vLastTime   AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fiacno1  fiacno1
            FRAME frST fiacno2  fiacno2
            FRAME frST fiAsDay  fiAsDay
            FRAME frST cbAsMth  cbAsMth
            FRAME frST fiAsYear fiAsYear

            FRAME frTranDate fiFrDay  fiFrDay
            FRAME frTranDate cbFrMth  cbFrMth
            FRAME frTranDate fiFrYear fiFrYear
            FRAME frTranDate fiToDay  fiToDay
            FRAME frTranDate cbToMth  cbToMth
            FRAME frTranDate fiToYear fiToYear
       
            nv_asmth  =  LOOKUP (cbasMth, cv_mthlistE)
            nv_frmth  =  LOOKUP (cbFrMth, cv_mthlistE)
            nv_tomth  =  LOOKUP (cbToMth, cv_mthlistE)

            n_asdat   =  DATE (nv_asmth, fiasDay, fiasYear)
            n_frdate  =  DATE (nv_Frmth, fiFrDay, fiFrYear)
            n_todate  =  DATE (nv_Tomth, fiToDay, fiToYear)
            n_frac    =  fiacno1
            n_toac    =  fiacno2 .
   END.

   /*--- A500178 ---
   If  n_frac = "" Then  n_frac = "0D00000".     
   If  n_toac = "" Then  n_toac = "0FZZZZZ".  
   ------*/
   If  n_frac = "" Then  n_frac = "0D00000".      /*A51-0124*/
   If  n_toac = "" Then  n_toac = "0FZZZZZZZZ".  

/* A47-0261 */
/*    IF ( n_frac > n_toac)   THEN DO:                                             */
/*          Message "�����ŵ��᷹�Դ��Ҵ" SKIP                                     */
/*          "���ʵ��᷹������鹵�ͧ�ҡ���������ش����" VIEW-AS ALERT-BOX WARNING . */
/*          Apply "Entry" To fiacno1  .                                            */
/*          Return No-Apply.                                                       */
/*    END.                                                                         */
/*                                                                                 */
/*    IF ( n_frdate > n_todate) OR n_frdate  = ? OR n_todate = ?   THEN DO:        */
/*          Message "�������ѹ���ӡ�������Դ��Ҵ" SKIP                           */
/*          "�ѹ���������鹵�ͧ�ҡ�����ѹ����ش����" VIEW-AS ALERT-BOX WARNING .   */
/*          Apply "Entry" To  fiFrDay .                                            */
/*          Return No-Apply.                                                       */
/*    END.                                                                         */

   MESSAGE "�ӡ�û����żŢ����� ! " SKIP (1)
           "���᷹/���˹��        : " n_frac     " �֧ " n_toac  SKIP (1)
           "�ѹ����͡��§ҹ       : " STRING(n_asdat,"99/99/9999")  SKIP (1)
           "�������������ѹ��� : " STRING(n_frdate,"99/99/9999") " �֧ " STRING(n_todate,"99/99/9999") SKIP (1)
           "Type                  : " nv_Type + " - " + "PROCESS STATEMENT CLAIM FAC."
   VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
   UPDATE CHOICE AS LOGICAL.
   CASE CHOICE:
       WHEN TRUE THEN DO:

            DOS SILENT del value(nv_file-name)  .   /* delete  file exports */
            RUN pdChkProcess01.  /* ��Ǩ�ͺ��� ���ա�� process � type  06 ���  ��ҫ��  ����� process ��� */
            
            IF n_chkprocess = YES THEN DO:
                vFirstTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
                    RUN pdProcess.  
                    RUN pdProcessYes.        /* ��� process ������� Process complete = YES  elapsed*/
                vLastTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
               
               /* kan. 08/07/2002---*/
               fiCount = fiCount + "  N = " + STRING(vCountRec).
               DISP fiCount WITH FRAME frST.
               /*--- kan.*/
               
                MESSAGE "�ѹ����͡��§ҹ : " STRING(n_asdat,"99/99/9999")   SKIP (1)
                        "���᷹              : "  n_frac " �֧ " n_toac     SKIP (1)
                        "�����żž������ŷ�����  " vCountRec   " ��¡��"  SKIP (1)
                        "����  " SUBSTRING(vFirstTime,1,18) "  -  " 
                                 SUBSTRING(vLastTime ,1,18) " �."
                VIEW-AS ALERT-BOX INFORMATION.
            END.
            ELSE DO:
                MESSAGE "�������ö Process �� ���ͧ�ҡ"  SKIP (1)
                        "�ա�� Process � As date �������"  /*n_chkprocess*/  VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
            END. /*  n_chkprocess = yes*/
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.    
        END.
    END CASE.


    OUTPUT TO VALUE (STRING(nv_File-Name)  ) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "Count : " vCountRec
            "" ""
            "nv_acm001 : " nv_acm001
            ""
            "nv_findXmm : " nv_findXmm
            ""
            "nv_finduwm : " nv_finduwm
            ""
            "nv_cerate : " nv_create
            ""
            vFirstTime
            vLastTime
            .
    OUTPUT CLOSE.

    vBackUP =  nv_File-Name + "B".

    DOS SILENT  COPY VALUE(nv_File-Name) VALUE(vBackUP) /Y  .   /* backup file exports */
        
/* ૵��� �����������ó�  �Դ����������ѹ */
    DO WITH FRAME frST:
       ASSIGN   
           /*--- A500178 ---
           fiacno1  = "0D00000"
           fiacno2  = "0FZZZZZ"       
           -----*/
           fiacno1  = "0D00000"   /*A51-0124*/
           fiacno2  = "0FZZZZZZZZ"       
           cbAsMth:List-Items = cv_mthlistE
           fiAsDay  = DAY(TODAY)
           cbAsMth  = ENTRY(MONTH (TODAY), cv_mthlistE) 
           fiAsYear = YEAR(TODAY)
           fiProcessDate = TODAY.
        DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiProcessDate.
    END.

/* �����ż������͡�ҡ������ѹ��*/
    MESSAGE "�����ż����º����"  VIEW-AS ALERT-BOX INFORMATION.
    APPLY "CHOOSE" TO btn_cancel.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 Wacr10
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
   n_chkname = "1". 
  RUN Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  Disp fiacno1 finame1  with Frame {&Frame-Name}      .
 
 n_agent1 =  fiacno1 .

  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 Wacr10
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  run Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame {&Frame-Name}      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTranDate
&Scoped-define SELF-NAME cbToMth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbToMth Wacr10
ON VALUE-CHANGED OF cbToMth IN FRAME frTranDate
DO:
      ASSIGN cbToMth.
  
     cbToMth  = INPUT cbToMth.
   DISP cbToMth WITH FRAME frTranDate.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 Wacr10
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
        
    IF Input  FiAcno1 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno1 = "".
              finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    End.    
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 Wacr10
ON RETURN OF fiacno1 IN FRAME frST
DO:
/*    Assign
 *   fiacno1 = input fiacno1
 *   n_agent1  = fiacno1.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 Wacr10
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.
     DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.
            
    IF Input  FiAcno2 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno2 = "".
              finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 Wacr10
ON RETURN OF fiacno2 IN FRAME frST
DO:
/*      Assign
 *   fiacno2 = input fiacno2
 *   n_agent2  = fiacno2.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAsDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAsDay Wacr10
ON LEAVE OF fiAsDay IN FRAME frST
DO:
  ASSIGN fiAsDay.

   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTranDate
&Scoped-define SELF-NAME fiFrDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFrDay Wacr10
ON LEAVE OF fiFrDay IN FRAME frTranDate
DO:
  ASSIGN fiFrDay.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToDay Wacr10
ON LEAVE OF fiToDay IN FRAME frTranDate
DO:
  ASSIGN fiToDay.
  
     fiToDay  = INPUT fiToDay.
   DISP fiToDay WITH FRAME frTranDate.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToYear Wacr10
ON LEAVE OF fiToYear IN FRAME frTranDate
DO:
    ASSIGN fiToYear.
  
/*     fiAsYear  =  fiToYear.
 *    DISP fiAsYear WITH FRAME frST.*/
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frCommand
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Wacr10 


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
  
  gv_prgid = "WACR10".
  gv_prog  = "PROCESS STATEMENT CLAIM FAC.".

  RUN  WUT\WUTHEAD (WACR10:HANDLE,gv_prgid,gv_prog).
/*********************************************************************/
  RUN WUT\WUTWICEN (WACR10:HANDLE).

  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
  SESSION:DATA-ENTRY-RETURN = YES.

  APPLY "ENTRY" TO fiToDay.

  DISABLE ALL EXCEPT fiAsDay cbAsMth fiAsYear WITH FRAME frST.    

    DO WITH FRAME frST:
        /*reProducer:MOVE-TO-TOP() .   */ 
       ASSIGN   
           /*--- A500178 ---
           fiacno1 = "0D00000"
           fiacno2 = "0FZZZZZ"
           ------*/
           fiacno1 = "0D00000"    /*A51-0124*/
           fiacno2 = "0FZZZZZZZZ"
           cbAsMth:List-Items = cv_mthlistE
/*            fiAsDay  =  DAY(TODAY)  /*fuNumDay(TODAY) */ */
           fiAsDAy = DAY(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)
           
           cbAsMth = IF MONTH(TODAY) = 1 THEN ENTRY (12 , cv_mthlistE)
                     ELSE ENTRY( (MONTH (TODAY)) - 1 , cv_mthlistE)
                     
           fiAsYear = YEAR(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)
           
/* kan--- 04/11/2002*/
           fiProcessDate = TODAY.
/* ---kan*/
           DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiProcessDate.
    END.
    DO WITH FRAME frTranDate:
        ASSIGN  
          cbFrMth:List-Items  = cv_mthlistE 
          cbToMth:List-Items  = cv_mthlistE 
          
          fiFrDay = 1           cbFrMth = ENTRY(1, cv_mthlistE)             fiFrYear = 2003
          fiToDay = DAY (TODAY) cbToMth = ENTRY(MONTH (TODAY), cv_mthlistE) fiToYear = YEAR (TODAY).
      
          DISPLAY 
            fiFrDay cbFrMth fiFrYear
            fiToDay cbToMth fiToYear
          WITH FRAME frTranDate .
    END.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Wacr10  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Wacr10)
  THEN DELETE WIDGET Wacr10.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Wacr10  _DEFAULT-ENABLE
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
  ENABLE RECT-406 
      WITH FRAME frCommand IN WINDOW Wacr10.
  {&OPEN-BROWSERS-IN-QUERY-frCommand}
  DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiCount fiProcessDate finame1 
          finame2 fiProcess 
      WITH FRAME frST IN WINDOW Wacr10.
  ENABLE reAsdate RECT-88 RECT11 fiacno1 buAcno1 fiacno2 buAcno2 fiAsDay 
         cbAsMth fiAsYear fiCount fiProcessDate finame1 finame2 fiProcess 
      WITH FRAME frST IN WINDOW Wacr10.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  VIEW FRAME frMain IN WINDOW Wacr10.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW Wacr10.
  ENABLE RECT-407 fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW Wacr10.
  {&OPEN-BROWSERS-IN-QUERY-frTranDate}
  ENABLE RECT-3 RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW Wacr10.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW Wacr10.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess01 Wacr10 
PROCEDURE pdChkProcess01 :
/*------------------------------------------------------------------------------
  Purpose:     2.  ��Ѻ����� Process Statement ��͹�Ф��� (Monthly)
                    ����礡�͹���
                    1.����� As date �ç�Ѻ��� ���ѧ���¡, Type = "01",  process complete = YES   �������� Process
                    2.����� As date �ç�Ѻ��� ���ѧ���¡, Type = "05"   �������� Process
                    
                    �ҡ���ç�Ѻ���͹䢢�ҧ��  �ʴ���� Process ��  
                    ��Щ��� �� process  ��  �����
                    1. ����� As date �ç�Ѻ��� ���ѧ���¡ ��� Type = "01" and "05"   
                        (������� create �ء���ҧ���� )
                    
                    2. ����� As date �ç�Ѻ��� ���ѧ���¡, Type = "01",  process complete =  NO
                    ��͹ Pocess -
                         �ӡ�� ź��������� ੾�з�� As date �ç�Ѻ��� ���ѧ���¡ ��� Record ����� "01"  ��駡�͹
                         ���ͧ�ҡ  process complete = NO  �ҡ��鹨֧ process  ���   
                    �� Record �� "01"
  Parameters:  <none>
  Notes:
------------------------------------------------------------------------------*/
    n_chkprocess = NO.

/*     FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE                */
/*               (acProc_fil.asdat = n_asdat AND acProc_fil.type = "05") OR */
/*               (acProc_fil.asdat = n_asdat AND                            */
/*                acProc_fil.type = "01"     AND                            */
/*      SUBSTRING(acProc_fil.enttim,10,3)  = "YES") NO-ERROR.               */
    
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.asdat = n_asdat  AND
               acProc_fil.type  = "06"     AND
     SUBSTRING(acProc_fil.enttim,10,3)  = "YES"  NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        n_chkprocess = NO.  /* ��� 06 ���� process complete = "YES" */
    END.
    ELSE DO:
        n_chkprocess = YES.  /* ��辺 �  06  ����ö process ��*/
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess05 Wacr10 
PROCEDURE pdChkProcess05 :
/*------------------------------------------------------------------------------
  Purpose:     1. ������� Process Statement �ء�ѹ  (Daily Process Statement)
                            ����礡�͹��Ҷ����  As date  �ç�Ѻ��� ���ѧ���¡, Type = "01"   �������� Process
                            �ҡ���ç�Ѻ���͹䢢�ҧ��  �ʴ���� Process ��
                            
                            ��͹ Pocess - 
                                 �ӡ�� ź��������� ੾�з�� Record ����� "05"  ��駡�͹   ���������¤�ҧ��ء�ѹ �ҡ��鹨֧ process  ���
                            �� Record �� "05"
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_chkprocess = NO.

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
              (acProc_fil.asdat = n_asdat AND acProc_fil.type = "01" ) NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        n_chkprocess = NO.  /* ��  � 01  �������ö process  */
    END.
    ELSE DO:
        n_chkprocess = YES.  /* ��辺 �  01  ����ö process ��*/
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreate Wacr10 
PROCEDURE pdCreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF OUTPUT PARAMETER  n_recid AS RECID.

    DO TRANSACTION :
        CREATE agtprm_fil .
    END.
    
n_recid =  RECID(agtprm_fil).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel01 Wacr10 
PROCEDURE pdDel01 :
/*------------------------------------------------------------------------------
  Purpose:     ��� process ��� �Ѻ asdate ���  � acproc_fil.type = "01"  ����
                      Delete ��������ҡ�͹
                      �ҡ��� �֧ create  ŧ�����
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR vCountOld AS INT.

/*------------- kan. 08/07/2002
FOR  EACH  agtprm_fil USE-INDEX by_trndat_acno WHERE
           agtprm_fil.trndat >=  n_frdate AND
           agtprm_fil.trndat <=  n_todate AND
           agtprm_fil.acno   >=  n_frac  AND
           agtprm_fil.acno   <=  n_toac AND
           agtprm_fil.asdat   =  n_asdat.
    DELETE agtprm_fil.
END.
-------------*/
/* kan. 08/07/2002---*/
FOR  EACH  agtprm_fil USE-INDEX by_acno WHERE
           agtprm_fil.asdat   =  n_asdat  AND
           agtprm_fil.acno   >=  n_frac   AND
           agtprm_fil.acno   <=  n_toac   AND
           agtprm_fil.trndat >=  n_frdate AND
           agtprm_fil.trndat <=  n_todate AND
           agtprm_fil.TYPE    =  "06" .
           
    ACCUM  1 (COUNT).
    
    DISP  "DELETE : " + STRING(agtprm_fil.asdat) + " " + 
               agtprm_fil.acno + "  " +  agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
               agtprm_fil.docno + " " + STRING(agtprm_fil.trndat)   @ fiProcess  WITH FRAME frST .

    DELETE agtprm_fil.
    
END.
/*--- kan.*/

fiCount = "O = " +  STRING(ACCUM count 1 ) .
DISP fiCount WITH FRAME frST.

    FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
              acProc_fil.type  = "06"    AND 
              acProc_fil.asdat = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
       CREATE acProc_fil.
       ASSIGN
           acProc_fil.type     = "06"
           acProc_fil.typdesc  = "PROCESS STATEMENT CLAIM FAC."
           acProc_fil.asdat    = n_asdat
           acProc_fil.trndatfr = n_frdate
           acProc_fil.trndatto = n_todate
           acProc_fil.entdat   = TODAY
           acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
           acProc_fil.usrid    = n_user.
    END.
    IF AVAIL acProc_fil THEN DO:
       ASSIGN
           acProc_fil.type     = "06"
           acProc_fil.typdesc  = "PROCESS STATEMENT CLAIM FAC."
           acProc_fil.asdat    = n_asdat
           acProc_fil.trndatfr = n_frdate
           acProc_fil.trndatto = n_todate
           acProc_fil.entdat   = TODAY
           acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
           acProc_fil.usrid    = n_user.
    END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel05 Wacr10 
PROCEDURE pdDel05 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* check ������ 05 �������  ��������ź */
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
                                            acProc_fil.type = nv_type NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        FOR  EACH  agtprm_fil WHERE agtprm_fil.asdat = acProc_fil.asdat AND agtprm_fil.type = nv_type:
            ACCUM  1 (count).
            DISP  "DELETE : " + STRING(agtprm_fil.asdat) + " " + 
                  agtprm_fil.acno + "  " +  agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                  agtprm_fil.docno + " " + STRING(agtprm_fil.trndat)  
                  @ fiProcess  WITH FRAME  frST .
            DELETE agtprm_fil.
        END.
    END.  /* avail acproc_fil */
    
    fiCount = "O = " +  STRING(ACCUM count 1 ) .
    DISP fiCount WITH FRAME frST.


/* create , update ��� acproc_fil  �� type ��� status ����Ѻ��� process */
    FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
              acProc_fil.type = nv_type NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
            CREATE acProc_fil.
    END.
    
    ASSIGN
        acProc_fil.type     = nv_type
        acProc_fil.typdesc  = "PROCESS PREMIUM STATEMENT (A4) EVERY DAY"
        acProc_fil.asdat    = n_asdat
        acProc_fil.trndatfr = n_frdate
        acProc_fil.trndatto = n_todate
        acProc_fil.entdat   = TODAY
        acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
        acProc_fil.usrid    = n_user.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess Wacr10 
PROCEDURE pdProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_netvat   = 0
        nv_vat      = 0
        nv_tax      = 0
        nv_netamt   = 0
        nv_total    = 0 
        nv_etotal   = 0.

ASSIGN
    vCountRec = 0
    n_type = nv_type.
RUN pdDel01.  /* "06" Delete agtprm_fil  &  Create acproc_fil */

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK  WHERE
          acm001.acno      >=  n_frac   AND
          acm001.acno      <=  n_toac   AND 
          acm001.curcod     =  "BHT"    AND
          acm001.trndat    >=  n_frdate AND
          acm001.trndat    <=  n_todate AND
         (acm001.trnty1     =  "F"      OR
          acm001.trnty1     =  "E")     AND  
         (acm001.bal       <>  0        OR
         (acm001.bal        =  0        AND
          acm001.latdat     >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.

    DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                         acm001.trnty2 + "  " + acm001.docno  FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ 
          @ fiProcess  WITH FRAME  frST.

    ASSIGN
      /*-----A50-0218--- 
      n_add1    =  ""  n_add2    =  ""  n_add3    =  ""
      n_add4    =  ""  n_insur   =  ""    -----------*/ 
      n_clicod  =  ""
      nt_tdat   =  ""  nt_asdat  =  ""  n_xtm600  =  "" 
      n_poldes  =  "" 
      /*---A51-0124---*/ 
      nv_inscod = ""
      nv_insname = "" 
      /*--Lukkana M. A52-0241 28/10/2009--*/
      nv_fee  = 0     nv_fee1 = 0
      nv_exp  = 0     nv_exp1 = 0
      nv_pad  = 0     nv_pad1 = 0
      nv_vat1 = 0 
      nt_pad  = 0     nv_req  = "" 
      reqno   = "" .
      /*--Lukkana M. A52-0241 28/10/2009--*/
   
   nv_req = TRIM(acm001.TRNTY1) + "-" + TRIM(acm001.DOCNO).  /*A50-0218*/
   
   /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    IF xmm600.clicod <> "RA" AND
       xmm600.clicod <> "RB" AND
       xmm600.clicod <> "RD" AND
       xmm600.clicod <> "RF" THEN NEXT loop_acm001.
    
    ASSIGN n_clicod = xmm600.clicod.

    /* keep reinsurance's name & address */
    FIND xtm600 USE-INDEX xtm60001 WHERE
         xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
    IF AVAIL xtm600  THEN DO:
       n_xtm600  = TRIM(xtm600.ntitle + " " + xtm600.name).
       IF xtm600.addr1 <> "" THEN
          ASSIGN
             n_add1 = xtm600.addr1
             n_add2 = xtm600.addr2
             n_add3 = xtm600.addr3
             n_add4 = xtm600.addr4.
       ELSE ASSIGN
             n_add1 = xmm600.addr1
             n_add2 = xmm600.addr2
             n_add3 = xmm600.addr3
             n_add4 = xmm600.addr4.
    END.
    ELSE ASSIGN
          n_xtm600 = TRIM(xmm600.ntitle + " " + xmm600.name)
          n_add1 = xmm600.addr1
          n_add2 = xmm600.addr2
          n_add3 = xmm600.addr3
          n_add4 = xmm600.addr4.
    
       FIND  CLM100  USE-INDEX  CLM10001  WHERE
             CLM100.CLAIM  =  acm001.recno NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL clm100 THEN DO:
          n_losdat = clm100.losdat.
       /*---A51-0124---*/
          IF clm100.ntitle <> "" AND clm100.fname <> "" THEN
            ASSIGN  nv_inscod  = clm100.insref
                    nv_insname = TRIM(clm100.ntitle) + " " +
                         TRIM(clm100.fname)  + " " + clm100.name1.
          ELSE IF clm100.fname <> "" THEN
                 ASSIGN nv_inscod  = clm100.insref
                        nv_insname  = TRIM(clm100.fname)  + " " + clm100.name1.
          ELSE IF clm100.ntitle <> "" THEN
                 ASSIGN  nv_inscod  = clm100.insref
                        nv_insname  = TRIM(clm100.ntitle) + " " + clm100.name1.
          ELSE  ASSIGN  nv_inscod  = clm100.insref
                        nv_insname  = clm100.name1.
       END.
      /*-------------*/
       
       /*-- lukkana M. A52-0241 27/10/2009 �� docno ��� total claim--*/

       FIND FIRST country_fil  WHERE 
                country_fil.ctydes  = nv_req  NO-ERROR. /* �� Req-no Lukkana M. A52-0241 28/12/2009*/ 
       IF AVAIL country_fil THEN DO:
           reqno = country_fil.cntry.
       END.
       ELSE DO: 
           reqno = "".
       END.
                                                 
       FIND FIRST CLM130   USE-INDEX clm13001         WHERE
                  CLM130.TRNTY1 =  SUBSTR(reqno,1,1)  AND 
                  /*clm130.docno  =  SUBSTR(reqno,3,7)  AND*/
                  clm130.docno  =  SUBSTR(reqno,3,10) AND /*A60-0267*/
                  CLM130.claim  =  acm001.recno       AND
                  CLM130.Releas =  Yes                NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL clm130 THEN DO:
          
          FIND clm200 USE-INDEX clm20001      WHERE
               clm200.trnty1 = clm130.trnty1  AND
               clm200.docno  = clm130.docno   NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL clm200 THEN DO:
              FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                         xmm600.acno = clm200.acno NO-LOCK NO-ERROR NO-WAIT.
              IF AVAIL xmm600 THEN
                  IF xmm600.clicod = "EX" OR   /* EX : External Survey */
                     xmm600.clicod = "CV" THEN /* CV : Sub Contractor VAT */
                      ASSIGN nv_totcl  = clm130.netl_d / (1.07)
                             nv_totalb = clm130.netl_d.
                  ELSE ASSIGN nv_totcl  = clm130.netl_d
                              nv_totalb = clm130.netl_d.
          END. /*end clm200*/

          IF nv_totcl = ? THEN
              ASSIGN
                nv_totcl  = 0
                nv_totalb = 0.

          FIND clm120 USE-INDEX clm12001         WHERE
               clm120.claim   =  clm130.claim    AND
               clm120.clmant  =  clm130.clmant   AND
               clm120.clitem  =  clm130.clitem   NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL clm120 THEN DO:
              ASSIGN
                 nv_fee  = 0     nv_fee1 = 0
                 nv_exp  = 0     nv_exp1 = 0
                 nv_pad  = 0     nv_pad1 = 0
                 nv_vat1 = 0 .

              IF clm120.loss = "FE" THEN DO:
                  nv_fee  =  nv_fee  +  nv_totcl.
                  nv_fee1 =  nv_fee1 +  nv_totalb.
                  nv_vat1 =  nv_vat1 + (nv_totalb - nv_totcl).
              END.
              ELSE IF clm120.loss = "EX" THEN DO:
                      nv_exp  =  nv_exp  +  nv_totcl.
                      nv_exp1 =  nv_exp1 +  nv_totalb.
                      nv_vat1 =  nv_vat1 + (nv_totalb - nv_totcl).
                   END.
                   ELSE DO:
                      nv_pad  =  nv_pad  + nv_totcl.
                      nv_pad1 =  nv_pad1 + nv_totalb.
                      nv_vat1 =  nv_vat1 + (nv_totalb - nv_totcl).
                   END.
          END. /*if avail clm120*/
       END.  /*--- end clm130 ---*/
       nt_pad       =  nv_pad + nv_fee + nv_exp + nv_vat1.
       
       FIND FIRST clm300  USE-INDEX  CLM30001    WHERE
                  clm300.claim   =  acm001.recno AND
                  CLM300.Csftq   =  "F"          AND
                  CLM300.rico    =  acm001.acno  NO-ERROR.    /*�Ҥ�� % share */
       IF AVAIL clm300 THEN DO: n_risi_p  = clm300.risi_p.
                                nt_pad_shar    = nt_pad * clm300.risi_p / 100.
       END.
       ELSE n_risi_p =  0 . 
       /*-- lukkana M. A52-0241 27/10/2009 --*/
       
       /*----A50-0281----
       nv_loss = "".

       FIND CLM130  USE-INDEX  CLM13001   WHERE
                  CLM130.claim     =  acm001.recno  AND
                  CLM130.Releas       =  Yes        NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL clm130 THEN DO:
          nv_req = TRIM(CLM130.TRNTY1) + "-" + TRIM(CLM130.DOCNO).
          FIND CLM120 USE-INDEX CLM12001        WHERE
               CLM120.CLAIM  = CLM130.CLAIM    AND
               CLM120.CLMANT = CLM130.CLMANT   AND
               CLM120.CLITEM = CLM130.CLITEM
          NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL CLM120 THEN 
             ASSIGN nv_loss = CLM120.LOSS.
                                       
       END.  /*--- end clm130 ---*/

       FIND FIRST clm300  USE-INDEX  CLM30001   WHERE
                CLM300.rico  =  acm001.acno  AND
                CLM300.Csftq   =  "F"  NO-ERROR.
       IF AVAIL clm300 THEN
           n_risi_p  = clm300.risi_p.

       FIND FIRST COUNTRY_FIL USE-INDEX COUNTRY01 WHERE
                  COUNTRY_FIL.CNTRY  = nv_req       AND
                  COUNTRY_FIL.CDES_T = CLM300.RICO
       NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL COUNTRY_FIL THEN REQNO   = COUNTRY_FIL.CTYDES.

    --end A50-0281--*/

    /*-- lukkana M. A52-0241 27/10/2009

    /*---- A50-0218  Find % Reinsurer----*/
    FIND FIRST clm300  USE-INDEX  CLM30001   WHERE
               CLM300.rico    =  acm001.acno  AND
               CLM300.Csftq   =  "F"  NO-ERROR.
    IF AVAIL clm300 THEN n_risi_p  = clm300.risi_p.
    
    FIND FIRST country_fil  WHERE
             country_fil.curd_r = nv_req  NO-ERROR.
    IF AVAIL country_fil THEN DO:
        reqno = country_fil.cntry.
    END.
    ELSE DO: 
        reqno = "".
    END.
    lukkana M. A52-0241 27/10/2009--*/
    
    /*---------end A50-0218--------------*/
          
    /* keep type of insurance */
    FIND  xmm031 USE-INDEX xmm03101 WHERE 
          xmm031.poltyp = acm001.poltyp
    NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

    ASSIGN
        n_polbrn  = acm001.branch
        n_insur  = TRIM(acm001.ref).
    
    FIND FIRST agtprm_fil USE-INDEX by_trndat_acno   WHERE
               agtprm_fil.trndat = acm001.trndat   AND
               agtprm_fil.acno   = acm001.acno     AND
               agtprm_fil.poltyp = acm001.poltyp   AND
               agtprm_fil.policy = acm001.policy   AND
               agtprm_fil.endno  = acm001.recno    AND
               agtprm_fil.trntyp = v_trntyp12      AND
               agtprm_fil.docno  = acm001.docno    AND
               agtprm_fil.asdat  = n_asdat         NO-LOCK NO-ERROR.
    IF NOT AVAIL agtprm_fil THEN DO:

       RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

    FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
       IF AVAIL agtprm_fil  THEN DO:
          ASSIGN
             agtprm_fil.asdat    =  n_asdat
             agtprm_fil.acno     =  acm001.acno
             agtprm_fil.agent    =  acm001.agent
             agtprm_fil.poltyp   =  acm001.poltyp
             agtprm_fil.polbran  =  n_polbrn
             agtprm_fil.policy   =  acm001.policy
             agtprm_fil.endno    =  acm001.recno
             agtprm_fil.insur    =  n_insur
             agtprm_fil.comm_comp = nt_pad     /*--Lukkana M. A52-0241 27/10/2009 �纤�� total claim--*/
             agtprm_fil.damt     =  nv_vat1    /* Net VAT ����ա���ѡ7% Lukkana M. A52-0241 29/10/2009*/
/*              agtprm_fil.polyear =  n_polyear */
/*              agtprm_fil.polyear =  n_polyear */
/*              agtprm_fil.cedpol =  n_cedpol */
/*              agtprm_fil.prem  =  n_prem           */
/*              agtprm_fil.prem_comp = n_comp        */
/*              agtprm_fil.tax     =  acm001.tax     */
/*              agtprm_fil.stamp = acm001.stamp      */
/*              agtprm_fil.gross = n_gross           */
/*              agtprm_fil.comm =  n_comm            */
/*              agtprm_fil.comm_comp  =  n_comm_comp */
/*              agtprm_fil.credit =  n_day */
/*              agtprm_fil.trntyp =  n_trntyp */
             agtprm_fil.prem    =  acm001.netamt
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat  =  acm001.trndat
             agtprm_fil.trntyp  =  acm001.trnty1
             agtprm_fil.docno   =  acm001.docno
             agtprm_fil.acno_clicod  =  n_clicod
/*              agtprm_fil.vehreg =  acm001.vehreg     */
/*              agtprm_fil.opnpol =  n_opnpol          */
             /*------A51-0124-----*/
             agtprm_fil.vehreg =  nv_inscod  
             agtprm_fil.opnpol =  nv_insname 
             /*-------------------*/

/*              agtprm_fil.prvpol  =  n_prvpol         */
/*              agtprm_fil.wcr    = n_wcr              */
/*              agtprm_fil.damt = n_damt  /* 3 ��ͧ */ */
/*              agtprm_fil.odue = n_odue  /* 3 ��ͧ*/  */
             agtprm_fil.latdat   =  acm001.latdat
             agtprm_fil.addr1    =  n_add1
             agtprm_fil.addr2    =  n_add2
             agtprm_fil.addr3    =  n_add3
             agtprm_fil.addr4    =  n_add4
             agtprm_fil.ac_name  =  n_xtm600
/*              agtprm_fil.odue1 = n_odue1                                                                                          */
/*              agtprm_fil.odue2 = n_odue2                                                                                          */
/*              agtprm_fil.odue3 = n_odue3                                                                                          */
/*              agtprm_fil.odue4 = n_odue4                                                                                          */
/*              agtprm_fil.odue5 = n_odue5                                                                                          */
/*              agtprm_fil.odue6 = n_ltamt   /* credit Limit*/                                                                      */
/*              agtprm_fil.startdat = n_startdat                                                                                    */
/*              agtprm_fil.comdat = n_comdat                                                                                        */
/*              agtprm_fil.duedat  = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */ */
             
             /*agtprm_fil.startdat =  acm001.entdat  ---A50-0218---*/
             /*---A50-0281---*/
             agtprm_fil.startdat =  n_losdat  
             agtprm_fil.cedpol   =  reqno       /*COUNTRY_FIL.CTYDES-req no*/ 
             /*agtprm_fil.credit   =  n_risi_p     /* percent */  �������㹿�Ŵ� wcr ᷹ Lukkana M. A52-0241 04/12/09*/
             agtprm_fil.wcr      =  n_risi_p     /* % share ���¨ҡ��Ŵ� credit ���繿�Ŵ���᷹ lukkana M. A52-0241 04/12/09 */
          /*   agtprm_fil.vehreg   =  nv_loss    /* Nature of Loss */*/
             /*agtprm_fil.damt     =  nv_netamt  /* Net VAT&TAX */*/
              /*---end A50-0218---*/
             agtprm_fil.duedat   =  acm001.trndat
             agtprm_fil.poldes   =  n_poldes
             agtprm_fil.type     =  n_type
             agtprm_fil.comdat   =  acm001.entdat.
       END.
       ASSIGN  nv_inscod  = ""
               nv_insname = "".

    END. /* IF NOT AVAIL agtprm_fil*/

    ASSIGN
       nt_tdat  = STRING(n_todate,"99/99/9999")
       nt_asdat = STRING(n_asdat,"99/99/9999").
       vCountRec = vCountRec + 1 .

    RELEASE agtprm_fil.  /*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessYes Wacr10 
PROCEDURE pdProcessYes :
/*------------------------------------------------------------------------------
  Purpose:     ��� process ������� Process complete = YES
  Parameters:  <none>  
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
              acProc_fil.asdat = n_asdat  AND
              acProc_fil.type  = nv_type  NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        ASSIGN
/*            acProc_fil.type    = "01"*/
           SUBSTRING(acProc_fil.enttim,10,3)  = "YES".
    END. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_acno Wacr10 
PROCEDURE pdProcess_acno :
DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat    AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth   AS INT. /*start date*/
DEF VAR n_sdyear    AS INT.
/* ���ѹ����������  ��ͧ���ѹ����ѹ�ش���¢ͧ��͹��� �*/
DEF VAR vYear       AS INT.
DEF VAR vMonth      AS INT.
DEF VAR vDay        AS INT.
DEF VAR vdueDAY     AS INT.
DEF VAR vdueMONTH   AS INT.
DEF VAR vdueYEAR    AS INT.
DEF VAR vcrperMod   AS INT.
DEF VAR vcrperTrun  AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   ��͹���  ���͹���Ҩӹǹ�ѹ�������͹ */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1   AS INT. /*count num day in over due 1 - 3   �ӹǹ�ѹ ����Թ ����������� credit  3 ��͹ */
DEF VAR n_odDay2   AS INT.
DEF VAR n_odDay3   AS INT.
DEF VAR n_odDay4   AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* �ѹ��� ����Թ�ҡ����������� credit  �Թ� 3 ��͹*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type  AS  CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

ASSIGN
    vCountRec = 0
    n_type = nv_type.

RUN pdDel01.  /* "06" Delete agtprm_fil  &  Create acproc_fil */

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac   AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod   =  "BHT"    AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
         (acm001.trnty1   =  "F" OR
          acm001.trnty1   =  "E" ) AND
         (acm001.bal     <>  0   OR
         (acm001.bal      =  0   AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.     /* A47-0108 */

    DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                         acm001.trnty2 + "  " + acm001.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
         @ fiProcess  WITH FRAME  frST.

    ASSIGN
        n_day      =  0     n_year    =  0      n_mocom    =  0
        n_prem     =  0     n_comp    =  0      n_gross    =  0
        nt_tdat    =  ""    nt_asdat  =  ""     n_xtm600   = ""   
        n_acc      =  ""    n_add1    =  ""     n_add2     = ""
        n_add3     =  ""    n_add4    =  ""     n_insur    = ""
        n_trntyp   =  ""    n_clicod  =  ""     n_poldes   = ""
        n_polyear  =  ""    n_cedpol  =  ""     n_opnpol   = ""
        n_prvpol   =  ""    n_polbrn  =  ""     n_comdat   = ?

        n_comm_comp = 0    n_comm   = 0
        vcom1_t     = 0    vcom2_t  = 0
        n_sdmonth   = 0    n_sdyear = 0
        n_startdat  = ?    n_duedat = ?
        
        n_wcr   = 0         n_odue2 = 0
        n_damt  = 0         n_odue3 = 0
        n_odue  = 0         n_odue4 = 0
        n_odue1 = 0         n_odue5 = 0.


    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    IF xmm600.clicod <> "RD" AND
       xmm600.clicod <> "RF" AND
       xmm600.clicod <> "RB" THEN NEXT loop_acm001.
    
    ASSIGN
/*        n_acc    = xmm600.acno */
       n_day    = xmm600.crper
/*        n_ltamt  = xmm600.ltamt */
       n_clicod = xmm600.clicod.  /* A47-0142 */

    FIND xtm600 USE-INDEX xtm60001 WHERE
         xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
    IF AVAIL xtm600  THEN DO:
       n_xtm600  = TRIM(xtm600.ntitle + " " + xtm600.name).
       IF xtm600.addr1 <> "" THEN
          ASSIGN
             n_add1 = xtm600.addr1
             n_add2 = xtm600.addr2
             n_add3 = xtm600.addr3
             n_add4 = xtm600.addr4.
       ELSE
          ASSIGN
             n_add1 = xmm600.addr1
             n_add2 = xmm600.addr2
             n_add3 = xmm600.addr3
             n_add4 = xmm600.addr4.
    END.
    ELSE
       ASSIGN
          n_xtm600 = TRIM(xmm600.ntitle + " " + xmm600.name)
          n_add1 = xmm600.addr1
          n_add2 = xmm600.addr2
          n_add3 = xmm600.addr3
          n_add4 = xmm600.addr4.
          

    FIND  xmm031 USE-INDEX xmm03101 WHERE 
          xmm031.poltyp = acm001.poltyp
    NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

    ASSIGN
       n_polyear = ""
       n_cedpol  = ""
       n_opnpol  = ""
       n_prvpol  = ""
       n_polbrn  = acm001.branch.
/*        n_comdat  = acm001.comdat. */

/*     n_mocom = 0. */

    /*--- A47-0621 ---
    /* A47-0142 - �Ң�����੾�� ��¡�÷���ա���к����� �/�  M, R */
    IF acm001.policy  <> ""  THEN DO:   

        IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
            FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                       uwm100.policy = acm001.policy AND
                       uwm100.endno  = acm001.recno
            NO-LOCK  NO-ERROR.
            IF AVAIL uwm100  THEN DO:
               ASSIGN
                  n_polyear = uwm100.undyr
                  n_cedpol  = uwm100.cedpol
                  n_opnpol  = uwm100.opnpol
                  n_prvpol  = uwm100.prvpol
                  vcom1_t   = uwm100.com1_t
                  n_polbrn  = uwm100.branch
                  n_comdat  = uwm100.comdat.

               vcom2_t = uwm100.com2_t.
               
               FOR EACH uwd132 USE-INDEX uwd13290 WHERE
                        uwd132.policy = uwm100.policy AND
                        uwd132.rencnt = uwm100.rencnt AND
                        uwd132.endcnt = uwm100.endcnt NO-LOCK .

                  IF uwd132.bencod = "COMP"  OR
                     uwd132.bencod = "COMG"  OR
                     uwd132.bencod = "COMH"  THEN
                     n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  ���� �ú.*/

               END.
            END. /* IF AVAIL uwm100 */
            ELSE DO:
               n_mocom = 0.
            END. /* IF NOT AVAIL uwm100*/

            ASSIGN
               n_prem      = acm001.prem  -  n_mocom        /*Prem  �ѡ���� �ú. ����*/
               n_comp      = n_mocom                        /* ���� �ú. */
               n_comm_comp = vcom2_t                        /*commission  �ú. */               /*uwm100.com2_t*/
               n_comm      = acm001.comm -  vcom2_t.        /*commission  =  uwm100.com1_t*/    /*uwm100.com2_t*/

        END. /* 70 */
        ELSE DO:
            FIND  uwm100 USE-INDEX uwm10001 WHERE
                  uwm100.policy = acm001.policy  AND
                  uwm100.rencnt = acm001.rencnt  AND
                  uwm100.endcnt = acm001.endcnt  NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN
                ASSIGN
                  n_polyear = uwm100.undyr
                  n_cedpol  = uwm100.cedpol
                  n_opnpol  = uwm100.opnpol
                  n_prvpol  = uwm100.prvpol
                  vcom1_t   = uwm100.com1_t
                  n_polbrn  = uwm100.branch
                  n_comdat  = uwm100.comdat.

            IF  ( SUBSTR(acm001.policy,3,2) = "72" OR
                  SUBSTR(acm001.policy,3,2) = "73" )
            THEN DO:
                ASSIGN
                  n_prem      = 0
                  n_comp      = acm001.prem             /*                 ���� �ú.*/ 
                  n_comm_comp = acm001.comm  /* commission  �ú.*/ /*uwm100.com1_t */
                  n_comm      = 0.
             END.
             ELSE DO:      /* �ء Line ¡��� 70 , 72 ,73 */
                ASSIGN
                  n_prem      = acm001.prem
                  n_comp      = 0
                  n_comm_comp = 0
                  n_comm      = acm001.comm.
             END.
             
        END.  /* loop ������ ����� line pol */

    END.   /* �Ң�����੾�� ��¡�÷���ա���к����� �/�  M, R    A47-0142 */
    --- END A47-0621 ---*/

    ASSIGN
        n_gross  = n_prem + n_comp + acm001.stamp + acm001.tax
        n_insur  = SUBSTR(acm001.ref,1,35)
        n_trntyp = acm001.trnty1 + acm001.trnty2
    /*=========== CHECK TRNDAT with in & over due ==========*/
        n_sdmonth  = MONTH(acm001.trndat)
        n_sdyear   = YEAR(acm001.trndat)
        n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
                                       ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*�ѹ���������Ѻ credit*/

    /* ��  n_duedat �ѹ����ش���·������� credit*/
    ASSIGN
       vdueDAY   = 0  vdueMONTH   = 0  vdueYEAR = 0
       vcrperMod = 0  vcrperRound = 0.

    ASSIGN
       vdueDAY     = DAY(n_startdat)
       vdueMONTH   = MONTH(n_startdat)
       vdueYEAR    = YEAR(n_startdat)
       vcrperMod   = n_day mod 30                 /* ��ӹǹ�ѹ*/
       vcrperRound = Round( n_day / 30 , 0). /* ��ӹǹ��͹  �Ѵ��ɢ��*/

    IF n_day = 0 THEN DO:       /* �ó� credit term �� 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO:
        IF n_day mod 30  = 0 THEN DO:   /* �����͹ �����ѹ����ҡ�ش�ͧ��͹��� */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ������  - 1 ź��͹����ͧ���� */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12

                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:    /* �����ǡѹ*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:        /*��������͹�����ѹ��� 15 �ͧ��͹���*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ������ */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12
                    vDay    = 15.
            END.
            ELSE DO:    /* �����ǡѹ*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = 15.
            END.
        END.

            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN �������ѹ����ѹ�ش����*/
         END.     /* if n_day <> 0 */
/**/
/*            n_duedat  = n_startdat + n_day - 1.     /*�ѹ����ش����  credit  (�Ѻ�ѹ�á����) */*/
      /*------------------ �Ҩӹǹ�ѹ� 3 , 6 , 9 , 12 ��͹ --------------------*/
/*           n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
 *            n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
 *            n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
 *            n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
    i = 0. 
    DO i = 0  TO 2 :   /* over due 1 - 3*/
     ASSIGN
        n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
    END.
    i = 0.
    DO i = 0  TO 5 :   /* over due 3 - 6*/
     ASSIGN
        n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
    END.
    i = 0.
    DO i = 0  TO 8 :   /* over due 6 - 9*/
     ASSIGN
        n_odmonth3  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
    END.
    i = 0.
    DO i = 0  TO 11 :   /* over due 9 - 12*/
     ASSIGN
        n_odmonth4  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
    END.
    
    /*-------------- duedat + �ӹǹ�ѹ� 3 , 6 , 9 , 12 ��͹   --------------*/
    ASSIGN
       n_odat1 =  n_duedat  +  n_odDay1  /* ���ѹ����ѹ�ش����㹪�ǧ*/
       n_odat2 =  n_duedat  +  n_odDay2
       n_odat3 =  n_duedat  +  n_odDay3
       n_odat4 =  n_duedat  +  n_odDay4.
    
    /*================== ���º��º�ѹ��� As Date �Ѻ duedat & odat1-4 (over due date) ===*/
    IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* ��º asdate �Ѻ  �ѹ���ش����  ��͹��͹�ش����*/
       n_wcr = n_wcr + acm001.bal.        /* with in credit  ���ú��˹����� */
    END.
    IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*��º asdate �Ѻ�ѹ���㹪�ǧ��͹�ش����*/
       n_damt = n_damt + acm001.bal.   /* due Amout  �ú��˹�����*/
    END.
    /*-------------------------------*/
    IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
            n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
    END.
    IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
            n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
    END.
    IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
            n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
    END.
    IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
            n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
    END.
    IF n_asdat > n_odat4 THEN DO:
            n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
    END.

    n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.

    v_trntyp12 = acm001.trnty1 + acm001.trnty2.
   /*--------------------------------------------------------------------*/

   FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
         agtprm_fil.trndat = acm001.trndat  AND 
         agtprm_fil.acno   = acm001.acno    AND
         agtprm_fil.poltyp = acm001.poltyp  AND 
         agtprm_fil.policy = acm001.policy  AND 
         agtprm_fil.endno  =  acm001.recno  AND
         agtprm_fil.trntyp = v_trntyp12     AND 
         agtprm_fil.docno  = acm001.docno   AND
         agtprm_fil.asdat  = n_asdat        NO-LOCK NO-ERROR.
   IF NOT AVAIL agtprm_fil THEN DO:

      RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

      FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
      IF AVAIL agtprm_fil  THEN DO:
          ASSIGN
             agtprm_fil.asdat   = n_asdat
             agtprm_fil.acno    = acm001.acno
             agtprm_fil.agent   = acm001.agent
             agtprm_fil.poltyp  = acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear = n_polyear
             agtprm_fil.policy  = acm001.policy
             agtprm_fil.endno   = acm001.recno
             agtprm_fil.cedpol  = n_cedpol
             agtprm_fil.insur   = n_insur
             agtprm_fil.prem    = n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     = acm001.tax
             agtprm_fil.stamp   = acm001.stamp
             agtprm_fil.gross   = n_gross
             agtprm_fil.comm    = n_comm        agtprm_fil.comm_comp  =  n_comm_comp
             agtprm_fil.bal     = acm001.bal
             agtprm_fil.trndat  = acm001.trndat
             agtprm_fil.credit  = n_day
             agtprm_fil.trntyp  = n_trntyp
             agtprm_fil.docno   = acm001.docno
             agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/
             agtprm_fil.vehreg  = acm001.vehreg
             agtprm_fil.opnpol  = n_opnpol
             agtprm_fil.prvpol  = n_prvpol
             agtprm_fil.latdat  = acm001.latdat
             agtprm_fil.ac_name = n_xtm600
             agtprm_fil.addr1   = n_add1
             agtprm_fil.addr2   = n_add2
             agtprm_fil.addr3   = n_add3
             agtprm_fil.addr4   = n_add4
             agtprm_fil.odue6   = n_ltamt   /* credit Limit*/
             agtprm_fil.wcr     = n_wcr
             agtprm_fil.damt    = n_damt  /* 3 ��ͧ */
             agtprm_fil.odue    = n_odue  /* 3 ��ͧ*/
             agtprm_fil.odue1   = n_odue1
             agtprm_fil.odue2   = n_odue2
             agtprm_fil.odue3   = n_odue3
             agtprm_fil.odue4   = n_odue4
             agtprm_fil.odue5   = n_odue5
    
             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat   = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
             agtprm_fil.poldes   = n_poldes
             agtprm_fil.type     = n_type
             agtprm_fil.comdat   = n_comdat.
      END.

   END. /* IF NOTAVAIL agtprm_fil*/

   ASSIGN
        n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4 = 0
        n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4   = 0
        n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4    = ?

        nt_tdat  = STRING(n_todate,"99/99/9999")
        nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

   RELEASE agtprm_fil.  /*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_old Wacr10 
PROCEDURE pdProcess_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth AS INT. /*start date*/
DEF VAR n_sdyear AS INT.
/* ���ѹ����������  ��ͧ���ѹ����ѹ�ش���¢ͧ��͹��� �*/
DEF VAR vYear AS INT.
DEF VAR vMonth AS INT.
DEF VAR vDay  AS INT.
DEF VAR vdueDAY  AS INT.
DEF VAR vdueMONTH AS INT.
DEF VAR vdueYEAR AS INT.
DEF VAR vcrperMod AS INT.
DEF VAR vcrperTrun AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   ��͹���  ���͹���Ҩӹǹ�ѹ�������͹ */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1  AS INT. /*count num day in over due 1 - 3   �ӹǹ�ѹ ����Թ ����������� credit  3 ��͹ */
DEF VAR n_odDay2  AS INT.
DEF VAR n_odDay3  AS INT.
DEF VAR n_odDay4  AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* �ѹ��� ����Թ�ҡ����������� credit  �Թ� 3 ��͹*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

ASSIGN
    vCountRec = 0
    n_type = nv_type.

    RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil
                                   "05"  */ 
                                   
loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac    AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod  = "BHT"     AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
          /* kan. A46-0015   ���� type = O, T---*/
         (acm001.trnty1   = "M" OR
          acm001.trnty1   = "R" OR
          acm001.trnty1   = "A" OR
          acm001.trnty1   = "B" OR
          acm001.trnty1   = "Y" OR
          acm001.trnty1   = "Z" OR
          acm001.trnty1   = "C" OR
          acm001.trnty1   = "O" OR
          acm001.trnty1   = "T" ) AND
          /*--- kan.*/
         (acm001.bal     <> 0  OR        
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.     /* A47-0108 */

       DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                  acm001.trnty2 + "  " + acm001.docno    FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
             @ fiProcess  WITH FRAME  frST.
        ASSIGN
            n_day      =  0
            nt_tdat    =  ""    nt_asdat   =  ""    n_xtm600    = ""     n_clicod = ""
            n_acc      =  ""    n_add1     =  ""    n_add2      = ""
            n_add3     =  ""    n_add4     =  ""    n_insur     = ""
            n_trntyp   =  ""    n_mocom    =  0     n_prem      = 0 
            n_comp     =  0     n_gross    =  0     n_year      = 0 
            n_polyear  =  ""    n_cedpol   =  ""    n_opnpol    = ""
            n_prvpol   =  ""    n_polbrn   =  ""    n_comdat    = ?

            n_comm_comp  = 0    n_comm     = 0
            vcom1_t      = 0    vcom2_t    = 0
            n_startdat   = ?    n_duedat   = ?
            n_sdmonth    = 0    n_sdyear   = 0
            n_poldes     = ""

            n_wcr   = 0
            n_damt  = 0
            n_odue  = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0.

        FIND  xmm031 WHERE xmm031.poltyp = acm001.poltyp
        NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

        
        FIND  xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno  = acm001.acno
              /* (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") */
        NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm600 THEN NEXT.
        IF xmm600.acccod <> "AG"  THEN DO:
            IF  xmm600.acccod <> "BR" THEN NEXT.
        END.
        ASSIGN
            n_acc    = xmm600.acno
            n_day    = xmm600.crper
            n_ltamt  = xmm600.ltamt
            n_clicod = xmm600.clicod.  /* A47-0142 */

        FIND xtm600 USE-INDEX xtm60001 WHERE
             xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = TRIM(xtm600.ntitle + " " + xtm600.name).
           IF xtm600.addr1 <> "" THEN
              ASSIGN
                 n_add1 = xtm600.addr1
                 n_add2 = xtm600.addr2
                 n_add3 = xtm600.addr3
                 n_add4 = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1 = xmm600.addr1
                 n_add2 = xmm600.addr2
                 n_add3 = xmm600.addr3
                 n_add4 = xmm600.addr4.

        END.
        ELSE
           ASSIGN
              n_xtm600 = TRIM(xmm600.ntitle + " " + xmm600.name) 
              n_add1 = xmm600.addr1
              n_add2 = xmm600.addr2
              n_add3 = xmm600.addr3
              n_add4 = xmm600.addr4.
              

           ASSIGN
              n_polyear = ""
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = ""
              n_polbrn = acm001.branch
              n_comdat = acm001.comdat.

        n_mocom = 0.

        /* A47-0142 - �Ң�����੾�� ��¡�÷���ա���к����� �/�  M, R */
        IF acm001.policy  <> ""  THEN DO:   
            IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
                FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                           uwm100.policy = acm001.policy AND
                           uwm100.endno  = acm001.recno
                NO-LOCK  NO-ERROR.
                IF AVAIL uwm100  THEN DO:
                    ASSIGN
                        n_polyear = uwm100.undyr
                        n_cedpol  = uwm100.cedpol
                        n_opnpol  = uwm100.opnpol
                        n_prvpol   = uwm100.prvpol
                        vcom1_t    = uwm100.com1_t
                        n_polbrn   = uwm100.branch
                        n_comdat = uwm100.comdat.
    
                    vcom2_t = uwm100.com2_t.
                   FOR EACH uwd132  WHERE
                            uwd132.policy  = uwm100.policy AND
                            uwd132.rencnt  = uwm100.rencnt AND
                            uwd132.endcnt  = uwm100.endcnt NO-LOCK .
    
                       IF uwd132.bencod = "COMP" OR
                          uwd132.bencod = "COMG"  OR
                          uwd132.bencod = "COMH"  THEN
                          n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  ���� �ú.*/
    
                   END.
                END. /* IF AVAIL uwm100 */
                ELSE DO:
                   n_mocom = 0.
                END. /* IF NOT AVAIL uwm100*/
    
                ASSIGN
                   n_prem    = acm001.prem  -  n_mocom   /*Prem  �ѡ���� �ú. ����*/
                   n_comp    = n_mocom                               /*               ���� �ú. */
                   n_comm_comp = vcom2_t                        /*commission  �ú. */ /*uwm100.com2_t*/
                   n_comm   = acm001.comm -  vcom2_t. /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/
    
            END. /* 70 */
            ELSE DO:
                FIND  uwm100 USE-INDEX uwm10001 WHERE
                       uwm100.policy  = acm001.policy  AND
                       uwm100.rencnt  = acm001.rencnt  AND
                       uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
                IF AVAIL uwm100 THEN
                    ASSIGN
                     n_polyear = uwm100.undyr
                     n_cedpol  = uwm100.cedpol
                     n_opnpol  = uwm100.opnpol
                     n_prvpol   = uwm100.prvpol
                     vcom1_t    = uwm100.com1_t
                     n_polbrn   = uwm100.branch
                     n_comdat  = uwm100.comdat.
    
                IF   (SUBSTR(acm001.policy,3,2) = "72" OR
                        SUBSTR(acm001.policy,3,2) = "73" )
                THEN DO:
                    ASSIGN
                      n_prem    =  0
                      n_comp    = acm001.prem             /*                 ���� �ú.*/ 
                      n_comm_comp = acm001.comm  /* commission  �ú.*/ /*uwm100.com1_t */
                      n_comm   = 0.
                 END.
                 ELSE DO:      /* �ء Line ¡��� 70 , 72 ,73 */
                    ASSIGN
                      n_prem   = acm001.prem
                      n_comp   = 0
                      n_comm_comp =  0
                      n_comm  = acm001.comm.
                 END.
                 
            END.  /* loop ������ ����� line pol */

        END.   /* �Ң�����੾�� ��¡�÷���ա���к����� �/�  M, R    A47-0142 */
                
    ASSIGN
        n_gross    = n_prem + n_comp + acm001.stamp + acm001.tax
        n_insur = SUBSTR(acm001.ref,1,35)
        n_trntyp   = acm001.trnty1 + acm001.trnty2
    /*=========== CHECK TRNDAT with in & over due ==========*/
        n_sdmonth = MONTH(acm001.trndat)
        n_sdyear  = YEAR(acm001.trndat)
        n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
                                       ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*�ѹ���������Ѻ credit*/
/* ��  n_duedat �ѹ����ش���·������� credit*/
ASSIGN
    vdueDAY = 0   vdueMONTH = 0  vdueYEAR = 0
    vcrperMod = 0 vcrperRound = 0.

         ASSIGN
            vdueDAY = DAY(n_startdat) 
            vdueMONTH = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)

            vcrperMod    = n_day mod 30                 /* ��ӹǹ�ѹ*/
            vcrperRound = Round( n_day / 30 , 0). /* ��ӹǹ��͹  �Ѵ��ɢ��*/

    IF n_day = 0 THEN DO:       /* �ó� credit term �� 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO:
        IF n_day mod 30  = 0 THEN DO:   /* �����͹ �����ѹ����ҡ�ش�ͧ��͹��� */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ������  - 1 ź��͹����ͧ���� */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12

                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:    /* �����ǡѹ*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:        /*��������͹�����ѹ��� 15 �ͧ��͹���*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ������ */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12
                    vDay    = 15.
            END.
            ELSE DO:    /* �����ǡѹ*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = 15.
            END.
        END.

            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN �������ѹ����ѹ�ش����*/
       END.
/**/
/*            n_duedat  = n_startdat + n_day - 1.     /*�ѹ����ش����  credit  (�Ѻ�ѹ�á����) */*/
      /*------------------ �Ҩӹǹ�ѹ� 3 , 6 , 9 , 12 ��͹ --------------------*/
/*           n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
 *            n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
 *            n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
 *            n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
           i = 0. 
           DO i = 0  TO 2 :   /* over due 1 - 3*/
            ASSIGN
                 n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 5 :   /* over due 3 - 6*/
            ASSIGN
                 n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 8 :   /* over due 6 - 9*/
            ASSIGN
                 n_odmonth3  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 11 :   /* over due 9 - 12*/
            ASSIGN
                 n_odmonth4  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
           END.
     /*-------------- duedat + �ӹǹ�ѹ� 3 , 6 , 9 , 12 ��͹   --------------*/
     ASSIGN
           n_odat1 =  n_duedat  +  n_odDay1  /* ���ѹ����ѹ�ش����㹪�ǧ*/
           n_odat2 =  n_duedat  + n_odDay2
           n_odat3 =  n_duedat  + n_odDay3
           n_odat4 =  n_duedat  + n_odDay4.
     /*================== ���º��º�ѹ��� As Date �Ѻ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* ��º asdate �Ѻ  �ѹ���ش����  ��͹��͹�ش����*/
                n_wcr = n_wcr + acm001.bal.        /* with in credit  ���ú��˹����� */
            END.
            IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*��º asdate �Ѻ�ѹ���㹪�ǧ��͹�ش����*/
                n_damt = n_damt + acm001.bal.   /* due Amout  �ú��˹�����*/
            END.
           /*-------------------------------*/
            IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
            END.

            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.

    v_trntyp12 = acm001.trnty1 + acm001.trnty2.
   /*--------------------------------------------------------------------*/

       FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = acm001.trndat   AND
             agtprm_fil.acno   = acm001.acno     AND
             agtprm_fil.poltyp = acm001.poltyp   AND
             agtprm_fil.policy = acm001.policy   AND
             agtprm_fil.endno  =  acm001.recno   AND 
             agtprm_fil.trntyp = v_trntyp12      AND
             agtprm_fil.docno  = acm001.docno    AND  
             agtprm_fil.asdat  = n_asdat
       NO-LOCK NO-ERROR.
       IF NOT AVAIL agtprm_fil THEN DO:

          RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

          FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
          IF  AVAIL agtprm_fil  THEN DO:
           ASSIGN
             agtprm_fil.asdat   =  n_asdat
             agtprm_fil.acno    =  acm001.acno
             agtprm_fil.agent   =  acm001.agent
             agtprm_fil.poltyp  =  acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear =  n_polyear
             agtprm_fil.policy  =  acm001.policy
             agtprm_fil.endno   =  acm001.recno
             agtprm_fil.cedpol  =  n_cedpol
             agtprm_fil.insur   =  n_insur
             agtprm_fil.prem    =  n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     =  acm001.tax
             agtprm_fil.stamp   = acm001.stamp
             agtprm_fil.gross   = n_gross
             agtprm_fil.comm    =  n_comm        agtprm_fil.comm_comp  =  n_comm_comp
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat  =  acm001.trndat
             agtprm_fil.credit  =  n_day
             agtprm_fil.trntyp  =  n_trntyp
             agtprm_fil.docno   =  acm001.docno
             agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/

             agtprm_fil.vehreg  =  acm001.vehreg
             agtprm_fil.opnpol  =  n_opnpol
             agtprm_fil.prvpol  =  n_prvpol
             agtprm_fil.latdat  =  acm001.latdat
             agtprm_fil.ac_name =  n_xtm600
             agtprm_fil.addr1   =  n_add1
             agtprm_fil.addr2   =  n_add2
             agtprm_fil.addr3   =  n_add3
             agtprm_fil.addr4   =  n_add4
             agtprm_fil.odue6   =  n_ltamt   /* credit Limit*/
             agtprm_fil.wcr     = n_wcr
             agtprm_fil.damt    = n_damt  /* 3 ��ͧ */
             agtprm_fil.odue    = n_odue  /* 3 ��ͧ*/

             agtprm_fil.odue1   = n_odue1
             agtprm_fil.odue2   = n_odue2
             agtprm_fil.odue3   = n_odue3
             agtprm_fil.odue4   = n_odue4
             agtprm_fil.odue5   = n_odue5

             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat   = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
             agtprm_fil.poldes   = n_poldes
             agtprm_fil.type     = n_type
             agtprm_fil.comdat   = n_comdat.
          END.

        END. /* IF NOTAVAIL agtprm_fil*/

       ASSIGN
            n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4  = 0
            n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4    = 0
            n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4     = ?

            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

release agtprm_fil.
/*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear Wacr10 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR vLeapYear  AS LOGICAL.

vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0)) 
                       THEN True ELSE False.


  RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay Wacr10 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR tday       AS INT FORMAT "99".
DEF VAR tmon       AS INT FORMAT "99".
DEF VAR tyear      AS INT FORMAT "9999".
DEF VAR maxday     AS INT FORMAT "99".
  
ASSIGN 
   tday  = DAY(vDate)
   tmon  = MONTH(vDate)
   tyear = YEAR(vDate).
   /*  ������ѹ����٧�ش�ͧ��͹������*/
   maxday = DAY(  DATE(tmon,28,tyear) + 4  - DAY(DATE(tmon,28,tyear) + 4)  ).
               
               
   RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumDay Wacr10 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF  MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
        MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
        MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
        MONTH(vDate) = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
         MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth Wacr10 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF vMonth = 1   OR  vMonth = 3    OR
        vMonth = 5   OR  vMonth = 7    OR
        vMonth = 8   OR  vMonth = 10   OR
        vMonth = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  vMonth = 4   OR  vMonth = 6    OR
         vMonth = 9   OR  vMonth = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  vMonth = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

