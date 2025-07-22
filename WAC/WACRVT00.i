/***************************************/
/* TOTAL */
DEF VAR nv_tot_prem   AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_prem_comp  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_stamp  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_tax    AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_prem1  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_stamp1  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_vat1    AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_gross  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_comm   AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_comm_comp AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_net       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_bal       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_retc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_susp   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_netar  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_netoth AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_wcr    AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR nv_tot_damt   AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR nv_tot_odue   AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF VAR nv_tot_odue1  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue2  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue3  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue4  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue5  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".

/* GRAND TOTAL */
DEF VAR nv_gtot_prem      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_prem_comp AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_stamp     AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_tax       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_prem1 AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_stamp1     AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_vat1       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_gross     AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_comm      AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_comm_comp AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_net       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_bal       AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_retc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_susp   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_netar  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_netoth AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_wcr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-". /*with in credit*/
DEF VAR nv_gtot_damt   AS DECI FORMAT ">>,>>>,>>>,>>9.99-". /*due amount */
DEF VAR nv_gtot_odue   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF VAR nv_gtot_odue1  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_odue2  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_odue3  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_odue4  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_odue5  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_asdatAging  AS DATE FORMAT "99/99/9999".

/*** ������ͧ����к� type ***/
DEF VAR nv_Trntyp1  AS CHAR INIT "M,R,A,B,C,Y,Z,O,T".

DEF VAR nv_typ1  AS CHAR.
DEF VAR nv_typ2  AS CHAR.
DEF VAR nv_typ3  AS CHAR.
DEF VAR nv_typ4  AS CHAR.
DEF VAR nv_typ5  AS CHAR.
DEF VAR nv_typ6  AS CHAR.
DEF VAR nv_typ7  AS CHAR.
DEF VAR nv_typ8  AS CHAR.
DEF VAR nv_typ9  AS CHAR.
DEF VAR nv_typ10  AS CHAR.
DEF VAR nv_typ11  AS CHAR.
DEF VAR nv_typ12  AS CHAR.
DEF VAR nv_typ13  AS CHAR.
DEF VAR nv_typ14  AS CHAR.
DEF VAR nv_typ15  AS CHAR.

/*** �¡ Report ***/
DEF VAR nv_RptTyp    AS CHAR .
DEF VAR nv_RptName   AS CHAR.
DEF VAR nv_RptName2  AS CHAR.

DEF VAR nv_poltypFr AS CHAR.
DEF VAR nv_poltypTo AS CHAR.

/*** �ӹǹ�ѹ ***/
DEF VAR n_due AS DATE FORMAT "99/99/9999".
DEF VAR n_day AS INTE FORMAT ">>>>9".

DEF VAR i    AS INTE INIT 0.
DEF VAR lip  AS INTE INIT 0.  /* Period */

DEF VAR ntax% AS DECI FORMAT "->>9.99" INIT 0.

DEF VAR nv_YZ AS CHAR INIT "YS,ZS". /* �֧�ʹ bal ���ҧ���� */
DEF VAR nv_CB AS CHAR INIT "C,B".
DEF VAR nv_MR AS CHAR INIT "M,R".
/***---  (within, due date) = current ,1 m = �Թ��˹��� 1 ��͹, ... , 12, 12 ��͹���� ��� 15 ��ͧ �����Թ���  16  ---***/
DEF VAR n_odmonth   AS INT EXTENT 16.   /*month  not over  12   ��͹��� (��͹ ��. = 01 �� 31 �ѹ )  ���͹���Ҩӹǹ�ѹ�������͹ */
DEF VAR n_odDay     AS INT EXTENT 16.   /*count num day in over due �ӹǹ�ѹ ����Թ ����������� credit 0 �֧ +12  ��͹ */
DEF VAR n_odat      AS DATE FORMAT "99/99/9999" EXTENT 16. /* �ѹ��� ����Թ�ҡ����������� credit  �Թ� 0 �֧ +12  ��͹*/
DEF VAR n_odatInday AS DATE FORMAT "99/99/9999".

DEF VAR nv_balDet      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_tot_balDet  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_gtot_balDet AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/***------------ ����÷���Ѻ���  ���ǹ�� Export file Detail --------------***/
DEF VAR nv_premCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_commCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_totalCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_net      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_premA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_taxA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_vatA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sbtA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_stampA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_totalA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_commA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_retcA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_suspA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_balA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netarA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netothA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

/***--------------------- "Summary of : " -------------------***/
/* ��ͧ 1 - 15  column 2 - 16 */
DEF VAR nv_Tprem    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Ttax     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tvat     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tprem1   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tstamp1  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tvat1    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tsbt     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tstamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Ttotal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tretc    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tsusp    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnetar   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnetoth  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/*����� 15 ��ͧ  column 1 */
DEF VAR nv_TTprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTtax    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTvat    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTprem1   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTstamp1    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTvat1    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTsbt    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTstamp  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTtotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTretc   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTsusp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnetar  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnetoth AS DECI FORMAT "->>,>>>,>>>,>>9.99".

/***------------------- "G R A N D  T O T A L" -----------------***/
/* ��ͧ 1 - 15 column 2 -16 */
DEF VAR nv_GTprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTtax    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTvat    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTprem1   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTstamp1    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTvat1    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTsbt    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTstamp  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTtotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTretc   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTsusp   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnetar  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnetoth AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/*����� 15 ��ͧ column 1 */
DEF VAR nv_GTTprem    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTtax     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTvat     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTprem1    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTstamp1     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTvat1     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTsbt     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTstamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTtotal   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTretc    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTsusp    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnetar   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnetoth  AS DECI FORMAT "->>,>>>,>>>,>>9.99".

/***--------------------------------------------------------***/

DEF VAR nv_blankH AS CHAR INIT " " EXTENT 20.
DEF VAR nv-1 AS CHAR.
DEF VAR nv-2 AS CHAR.
DEF VAR nv-3 AS CHAR.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_Linedes AS CHAR.
DEF VAR nv_acname AS CHAR.

/* SUB TOTAL */
DEF VAR nv_sub_prem       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_prem_comp  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_stamp      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_tax        AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_prem1      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_stamp1     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_tax1       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_gross      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_comm       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_comm_comp  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_net        AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_bal        AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_baldet     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_sub_retc       AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sub_susp       AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sub_netar      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_netoth     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

/*------ group table for grpcode in acno  ---*/
DEF TEMP-TABLE  wtGrpCode          /* workfile ��ª��� group code �ͧ���е��᷹  ������� + "G" */
    FIELD wtgpage   AS CHAR
    FIELD wtgpName  AS CHAR
    FIELD wtacno    AS CHAR
    FIELD wtname    AS CHAR
INDEX  wtGrpCode1 IS UNIQUE PRIMARY wtgpage wtacno  ASCENDING
INDEX  wtGrpCode2  wtacno.

DEF  TEMP-TABLE wtGrpSum          /* workfile ����Ѻ ��� group code  ������� + "Gp" */
    FIELD wtGTrptname   AS CHAR
    FIELD wtGTgpcode    AS CHAR
    FIELD wtGTgpname    AS CHAR
    FIELD wtGTacno      AS CHAR
    FIELD wtGTacname    AS CHAR
    FIELD wtGTprem      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTtax       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTvat       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTprem1     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTstamp1    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTvat1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTsbt       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTstamp     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTtotal     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTcomm      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnet       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTretc      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTsusp      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnetar     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTbal       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnetoth    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
/**/
    FIELD wtGTTprem     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTtax      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTvat      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTprem1     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTstamp1      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTvat1      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTsbt      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTstamp    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTtotal    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTcomm     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnet      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTretc     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTsusp     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnetar    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTbal      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnetoth   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
INDEX wtGrpSum1 IS UNIQUE PRIMARY  wtGTacno
INDEX wtGrpSum2  wtGTgpcode.

/* ����� display � report summary */
DEF VAR nv_RptTyp1 AS CHAR INIT "".
DEF VAR nv_RptTyp2 AS CHAR INIT "".

DEF VAR n_trnty1 AS CHAR  FORMAT "X" .
DEF VAR n_trnty2 AS CHAR  FORMAT "X" .
DEF VAR nv_prm  LIKE ACM001.PREM .  /* Net Premium */
DEF VAR nv_com  LIKE ACM001.PREM .
DEF VAR nv_sup  LIKE  ACM001.PREM .

DEF VAR nv_pprm  LIKE Acm001.Prem.  /* Prem Amount before TAX, STAMP */
DEF VAR nv_stamp LIKE Acm001.Stamp. 
DEF VAR nv_tax   LIKE Acm001.TAX.   /* < 4% of Prem is SBT Else Vat */
DEF VAR nv_prem1  LIKE Acm001.Prem. 
DEF VAR nv_stamp1 LIKE Acm001.Stamp. 
DEF VAR nv_vat1   LIKE Acm001.TAX.  

DEF VAR nv_netamt LIKE ACM001.PREM.
DEF VAR nv_sumsup LIKE ACM001.PREM.
DEF VAR nv_sumprm LIKE ACM001.PREM.
DEF VAR nv_sumcom LIKE ACM001.PREM.
DEF VAR nv_spcp   LIKE ACM001.PREM.

DEF VAR nv_DetSum AS CHAR .
DEF VAR n_processdate  AS DATE.

DEF VAR nv_reccnt AS INT.
DEF VAR nv_next   AS INT.
DEF VAR n_trndatfrOld AS DATE FORMAT "99/99/9999".
DEF VAR n_trndattoOld AS DATE FORMAT "99/99/9999".

DEF VAR nv_invdat LIKE vat100.invdat.
DEF VAR nv_invoice LIKE vat100.invoice.
DEF VAR nv_invsts  AS LOGICAL INIT NO.
