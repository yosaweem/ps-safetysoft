&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
DEF NEW  SHARED VAR n_User     AS CHAR.
DEF NEW  SHARED VAR n_Passwd   AS CHAR.  
DEF             VAR nv_User    AS CHAR NO-UNDO. 
DEF             VAR nv_pwd     LIKE _password NO-UNDO.
/* Definitons  Report -------                                               */
DEF  VAR report-library        AS CHAR INIT "wAC/wprl/wacr03.prl".   /*A47-0035  wac_sm02.prl */
DEF  VAR report-name           AS CHAR INIT "STATEMENT A4 SUMMARY".
DEF  VAR RB-DB-CONNECTION      AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS    AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER             AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE          AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION  AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME       AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT       AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE        AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES      AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE         AS INTE INIT 0.
DEF  VAR RB-END-PAGE           AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN       AS LOG  INIT no.
DEF  VAR RB-WINDOW-TITLE       AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS     AS LOG  INIT yes.
DEF  VAR RB-DISPLAY-STATUS     AS LOG  INIT yes.
DEF  VAR RB-NO-WAIT            AS LOG  INIT no.
DEF  VAR RB-OTHER-PARAMETERS   AS CHAR INIT "".
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".
Def            VAR n_name     As Char Format "x(50)". /*acno name*/
Def            VAR n_chkname  As Char format "x(1)".  /* Acno-- chk button 1-2 */
Def            VAR n_bdes     As Char Format "x(50)". /*branch name*/
Def            VAR n_chkBname As Char format "x(1)".  /* branch-- chk button 1-2 */
Def            VAR n_itmdes   As Char Format "x(40)". /*Table-Code Description*/
/* Local Variable Definitions ---                                       */
DEF VAR nv_asmth    AS INTE INIT 0.
DEF VAR nv_frmth    AS INTE INIT 0.
DEF VAR nv_tomth    AS INTE INIT 0.
DEF VAR cv_mthlistT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".
DEF VAR n_asdat     AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr      AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr      AS   CHAR   FORMAT "x(2)".
DEF VAR n_frac      AS   CHAR   FORMAT "x(10)".
DEF VAR n_toac      AS   CHAR   FORMAT "x(10)".
DEF VAR n_typ       AS   CHAR   FORMAT "X".
DEF VAR n_typ1      AS   CHAR   FORMAT "X".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".
DEF VAR n_chkCopy     AS INTEGER.
DEF VAR n_OutputTo    AS INTEGER.
DEF VAR n_OutputFile  AS Char.
DEF VAR vCliCod       AS CHAR.
DEF VAR vCliCodAll    AS CHAR.
DEF VAR vCountRec     AS INT.
DEF VAR vAcProc_fil   AS CHAR.
DEF VAR vBranchName   AS CHAR.
/*--------------------------------------- A46-0092 -----------------------------*/
DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_Trntyp1  AS CHAR INIT "M,R,A,B,C,Y,Z,O,T".
DEF VAR nv_typ1   AS CHAR.
DEF VAR nv_typ2   AS CHAR.
DEF VAR nv_typ3   AS CHAR.
DEF VAR nv_typ4   AS CHAR.
DEF VAR nv_typ5   AS CHAR.
DEF VAR nv_typ6   AS CHAR.
DEF VAR nv_typ7   AS CHAR.
DEF VAR nv_typ8   AS CHAR.
DEF VAR nv_typ9   AS CHAR.
DEF VAR nv_typ10  AS CHAR.
DEF VAR nv_typ11  AS CHAR.
DEF VAR nv_typ12  AS CHAR.
DEF VAR nv_typ13  AS CHAR.
DEF VAR nv_typ14  AS CHAR.
DEF VAR nv_typ15  AS CHAR.
/******************** output to file*******************/
DEF VAR n_net       AS DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_wcr       AS DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt      AS DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue      AS DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF VAR n_odue1     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 1-15 days*/
DEF VAR n_odue2     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 16-30 days*/
DEF VAR n_odue3     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 31-45 days*/
DEF VAR n_odue4     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 46-60 days*/
DEF VAR n_odue5     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 61-90 days*/
DEF VAR n_odue6     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 91-180 days*/
DEF VAR n_odue7     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 181-270 days*/
DEF VAR n_odue8     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 271-365 days*/
DEF VAR n_odue9     AS DECI   FORMAT ">>,>>>,>>9.99-".  /*over 365 days*/
DEF VAR n_odmonth1  AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2  AS INT.
DEF VAR n_odmonth3  AS INT.
DEF VAR n_odmonth4  AS INT.
DEF VAR n_odmonth5  AS INT.
DEF VAR n_odmonth6  AS INT.
DEF VAR n_odmonth7  AS INT.
DEF VAR n_odmonth8  AS INT.
DEF VAR n_odmonth9  AS INT.
DEF VAR n_odDay1    AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2    AS INT.
DEF VAR n_odDay3    AS INT.
DEF VAR n_odDay4    AS INT.
DEF VAR n_odDay5    AS INT.
DEF VAR n_odDay6    AS INT.
DEF VAR n_odDay7    AS INT.
DEF VAR n_odDay8    AS INT.
DEF VAR n_odDay9    AS INT.
DEF VAR n_odat1     AS DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat3     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat4     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat5     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat6     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat7     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat8     AS DATE FORMAT "99/99/9999".
DEF VAR n_odat9     AS DATE FORMAT "99/99/9999".
/* TOTAL */
DEF  VAR nv_tot_prem        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_prem_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_stamp       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_tax         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_gross       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_net         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_bal         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_wcr         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_tot_damt        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_tot_odue        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue1       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue2       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue3       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue4       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue5       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nv_tot_odue6       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue7       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue8       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_tot_odue9       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/* SUM BRANCH TOTAL */      
DEF  VAR nv_brtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_brtot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_brtot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_brtot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue6     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue7     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue8     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_brtot_odue9     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/* SUM Agent TOTAL */
DEF  VAR nv_agtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_agtot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_agtot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue6     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_agtot_odue7     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_odue8     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_agtot_odue9     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".
/* GRAND TOTAL */
DEF  VAR nv_gtot_prem       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_prem_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_stamp      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_tax        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_gross      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_net        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_bal        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_wcr        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_gtot_damt       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_gtot_odue       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nv_gtot_odue1      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue2      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue3      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue4      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue5      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/*---A53-0159---*/
DEF  VAR nv_gtot_odue6      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nv_gtot_odue7      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue8      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_gtot_odue9      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF VAR nv_asdatAging       AS DATE FORMAT "99/99/9999".
/* A47-0014 */ /*------ temp table for fncode in acno  ---*/
DEF  TEMP-TABLE  wtgp          /* workfile for    group code statement   รายชื่อผูดูแลแต่ละตัวแทน */
    FIELD wtgpstmt  AS CHAR FORMAT "X(10)" /*--- A500178 ---*/
    FIELD wtgpname  AS CHAR
    FIELD wtacno    AS CHAR FORMAT "X(10)" /*--- A500178 ---*/
    FIELD wtname    AS CHAR
INDEX  wtgp1 IS UNIQUE PRIMARY wtgpstmt wtacno  ASCENDING
INDEX  wtgp2  wtacno.
DEF VAR nv_frac     AS CHAR.
DEF VAR nv_toac     AS CHAR.
DEF  TEMP-TABLE wtSum          /* workfile for สำหรับ เก็บ summary ของแต่ละ acno */
    FIELD wtgpstmt AS CHAR
    FIELD wtacno    AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format X(10)---*/
    FIELD wtagent   AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format X(10)---*/
    FIELD wtacname  AS CHAR
    FIELD wtbranch  AS CHAR
    FIELD wtcredit  AS INT
    FIELD wtltamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtwcr     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtdamt    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue5   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue6   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue7   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtodue9   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtcomm_comp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD clientco  AS CHAR FORMAT "X(2)" INIT " "    /*** Client Code Note add ***/
    FIELD wtpolgrp  AS CHAR FORMAT "X(6)"
    FIELD wtgrptyp  AS CHAR FORMAT "X(3)"
INDEX wtSum1 IS UNIQUE PRIMARY  wtacno wtbranch wtagent 
INDEX wtSum2 wtbranch wtgpstmt  wtacno
INDEX wtSum3 wtgpstmt wtacno
INDEX wtSum4 wtagent  wtacno  wtpolgrp wtgrptyp.   /*A53-0159*/
DEF VAR nv_clicod   AS CHAR FORMAT "x(2)" INIT ""  .            /*** Client Code Note Add ***/
DEF VAR nv_gpstmt   AS CHAR FORMAT "X(10)". /*--- A500178 --- เพิ่ม format X(10)---*/
DEF VAR nv_gpname   AS CHAR.
DEF BUFFER bxmm600  FOR xmm600.
/* A47-0500 */
DEF VAR nv_agent    AS CHAR FORMAT "X(10)". /*--- A500178 --- เพิ่ม format X(10)---*/
DEF VAR nv_agent2   AS CHAR FORMAT "X(10)". /*--- A500178 --- เพิ่ม format X(10)---*/
/* A47-9999 */
DEF VAR nv_out      AS LOGICAL.
DEF VAR vAcno AS CHAR INIT "".
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR n_type      AS CHAR FORMAT "X(10)".
DEF VAR nv_grptyp      AS CHAR FORMAT "X(3)".
DEF VAR nv_type      AS CHAR FORMAT "X(1)".
DEF VAR nv_insref AS CHAR FORMAT "X" INIT "".
DEF VAR nv_dir    AS CHAR FORMAT "X(3)" INIT "".
DEF VAR nv_polgrp AS CHAR FORMAT "X(6)" INIT "".
DEF VAR nv_polgrpdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_grptypdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_comdat AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat AS DATE FORMAT "99/99/9999".
DEF VAR n_acmbal  LIKE acm001.bal.
DEF VAR n_acmrec  AS LOGICAL INIT NO.
DEF  TEMP-TABLE wtBSum         
    FIELD wtBgpstmt AS CHAR
    FIELD wtBacno    AS CHAR FORMAT "X(10)" 
    FIELD wtBagent   AS CHAR FORMAT "X(10)"  
    FIELD wtBacname  AS CHAR
    FIELD wtBbranch  AS CHAR
    FIELD wtBcredit  AS INT
    FIELD wtBltamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBwcr     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBdamt    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue5   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue6   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue7   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBodue9   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtBcomm_comp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD Bclientco  AS CHAR FORMAT "X(2)" INIT " "  
    FIELD wtBpolgrp  AS CHAR FORMAT "X(6)"
    FIELD wtBgrptyp  AS CHAR FORMAT "X(3)"
    FIELD wtBpoltyp  AS CHAR FORMAT "X(3)"
INDEX wtBSum1 IS UNIQUE PRIMARY  wtBacno wtBbranch wtBagent wtBpoltyp
INDEX wtBSum2 wtBbranch wtBpoltyp.
DEF  TEMP-TABLE wtTSum         
    FIELD wtTgpstmt AS CHAR
    FIELD wtTbranch  AS CHAR
    FIELD wtTcredit  AS INT
    FIELD wtTltamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTwcr     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTdamt    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue5   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue6   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue7   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTodue9   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtTcomm_comp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD Tclientco  AS CHAR FORMAT "X(2)" INIT " "  
    FIELD wtTpolgrp  AS CHAR FORMAT "X(6)"
    FIELD wtTgrptyp  AS CHAR FORMAT "X(3)"
    FIELD wtTpoltyp  AS CHAR FORMAT "X(3)"
INDEX wtTSum1 IS UNIQUE PRIMARY  wtTbranch wtTpoltyp.
DEF VAR nn_polbran  AS CHAR FORMAT "X(4)".
DEF VAR nn_poltyp   AS CHAR FORMAT "X(3)".
DEF  TEMP-TABLE wtGSum 
    FIELD wtGltamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGwcr     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGdamt    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue3   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue4   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue5   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue6   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue7   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue8   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGodue9   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGcomm_comp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGpoltyp  AS CHAR FORMAT "X(3)".
DEF VAR nv_poltyp AS CHAR FORMAT "X(256)".
DEF VAR mday AS INT INIT 0.   /*A55-0231*/
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00a.i NEW}. 
{wuw\wuwppic01a.i}
{wuw\wuwppic02a.i}
/*END Saharat S. A62-0279*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcproc_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE brAcproc_fil                                  */
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat ~
acproc_fil.type IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") ~
acproc_fil.entdat acproc_fil.enttim SUBSTRING (acproc_fil.enttim,10,3) ~
acproc_fil.trndatfr acproc_fil.trndatto acproc_fil.typdesc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 112.5 BY 22.71.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 2.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 18.5 BY 4.43
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3
     SIZE 12.5 BY 3
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "wacr03.prl" 
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiagent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiagent2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 22 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 26.33 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 26.33 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 43 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE fiTyp1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp10 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp11 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp12 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp13 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp14 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp15 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp2 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp3 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp4 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp5 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp6 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp7 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp8 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp9 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE rsType AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Motor", 1,
"Non Motor", 2,
"All", 3
     SIZE 17 BY 2.91
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE reBranch2
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 51.5 BY 3.14
     BGCOLOR 8 FGCOLOR 8 .

DEFINE RECTANGLE RECT-87
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 51.5 BY 3.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-89
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 51 BY 6.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-96
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 3.43.

DEFINE RECTANGLE reReports2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 96.5 BY 8.1.

DEFINE RECTANGLE reReprots
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 103 BY 8.71
     BGCOLOR 8 .

DEFINE RECTANGLE reTrntyp1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 46 BY 4.95.

DEFINE VARIABLE toOut AS LOGICAL INITIAL no 
     LABEL "ส่งกรม" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .76
     BGCOLOR 8 FGCOLOR 0 FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil C-Win _STRUCTURED
  QUERY brAcproc_fil DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Ty" FORMAT "X(2)":U
      IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") COLUMN-LABEL "Detail"
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.enttim COLUMN-LABEL "Time" FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "Sta" FORMAT "X(1)":U
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
      acproc_fil.typdesc FORMAT "X(60)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 89.5 BY 3.91
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.04
         BGCOLOR 18 .

DEFINE FRAME frMain
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 12 ROW 1.78
         SIZE 113 BY 22.96.

DEFINE FRAME frOutput
     rsOutput AT ROW 2.29 COL 2.5 NO-LABEL
     cbPrtList AT ROW 3.33 COL 17.5 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.43 COL 17.5 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 49 BY .95 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 4 ROW 18.5
         SIZE 49 BY 5
         BGCOLOR 3 .

DEFINE FRAME frST
     rsType AT ROW 2.86 COL 80.5 NO-LABEL
     toOut AT ROW 2.86 COL 65
     cbRptList AT ROW 2.86 COL 25.83 COLON-ALIGNED NO-LABEL
     brAcproc_fil AT ROW 6.29 COL 9
     buBranch AT ROW 11.52 COL 18
     fiagent AT ROW 14.57 COL 11 COLON-ALIGNED NO-LABEL
     fiagent2 AT ROW 15.62 COL 11 COLON-ALIGNED NO-LABEL
     fiTyp1 AT ROW 12.33 COL 66 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 12.33 COL 71 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 12.33 COL 76 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 12.33 COL 81 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 12.33 COL 86 COLON-ALIGNED NO-LABEL
     fiBranch AT ROW 11.52 COL 11 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 12.62 COL 11 COLON-ALIGNED NO-LABEL
     buBranch2 AT ROW 12.62 COL 18
     fiTyp6 AT ROW 13.62 COL 66 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 13.62 COL 71 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 13.62 COL 76 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 13.62 COL 81 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 13.62 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 14.91 COL 66 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 14.91 COL 71 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 14.91 COL 76 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 14.91 COL 81 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 14.91 COL 86 COLON-ALIGNED NO-LABEL
     fiAsdat AT ROW 4.14 COL 25.83 COLON-ALIGNED
     fiProcessDate AT ROW 4.14 COL 62.33 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 11.1 COL 81 COLON-ALIGNED
     fibdes AT ROW 11.52 COL 19.33 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 12.62 COL 19.33 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 14.57 COL 23.5 COLON-ALIGNED
     fiProcess AT ROW 15.95 COL 58
     finame2 AT ROW 15.62 COL 23.5 COLON-ALIGNED
     "                                               STATEMENT A4 SUMMARY (CBC)":100 VIEW-AS TEXT
          SIZE 106 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "To":10 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "ถึงสาขา" AT ROW 12.67 COL 7.5
          BGCOLOR 8 FGCOLOR 0 FONT 6
     " Process Date":30 VIEW-AS TEXT
          SIZE 17.5 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 4.14 COL 45.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " As of Date":30 VIEW-AS TEXT
          SIZE 17.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 4.14 COL 9.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Include Type All":50 VIEW-AS TEXT
          SIZE 28.5 BY 1 AT ROW 11.1 COL 54.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Br. From":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 11.43 COL 4
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "To":20 VIEW-AS TEXT
          SIZE 3.5 BY .95 TOOLTIP "รหัสตัวแทน" AT ROW 15.62 COL 9.5
          BGCOLOR 8 FGCOLOR 0 FONT 6
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 17.5 BY .95 TOOLTIP "ประเภทรายงาน" AT ROW 2.86 COL 9.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Agent Fr":20 VIEW-AS TEXT
          SIZE 8.5 BY .95 TOOLTIP "รหัสตัวแทน" AT ROW 14.57 COL 4
          BGCOLOR 8 FGCOLOR 0 FONT 6
     reBranch2 AT ROW 14.24 COL 2
     RECT-87 AT ROW 11.1 COL 2
     RECT-89 AT ROW 11.1 COL 54
     reReports2 AT ROW 2.43 COL 5.5
     reReprots AT ROW 2.19 COL 2
     reTrntyp1 AT ROW 12.05 COL 56.5
     RECT-96 AT ROW 2.57 COL 79.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.52
         SIZE 106.5 BY 16.7
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 88.5 ROW 18.5
         SIZE 22 BY 5
         BGCOLOR 3 .


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
         TITLE              = "wacr13 - STATEMENT A4 SUMMARY (CBC)"
         HEIGHT             = 23.62
         WIDTH              = 131.67
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133
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
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frST
   Custom                                                               */
/* BROWSE-TAB brAcproc_fil cbRptList frST */
/* SETTINGS FOR FILL-IN fiAsdat IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fiInclude IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN finame2 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr13 - STATEMENT A4 SUMMARY (CBC) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr13 - STATEMENT A4 SUMMARY (CBC) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcproc_fil
&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:
/*  
    IF NOT CAN-FIND (FIRST docno_fil WHERE poltyp BEGINS "R")THEN DO:
       DISABLE ALL WITH FRAME frDetail.
    END.
    ELSE DO:
      FIND CURRENT docno_fil NO-LOCK.
      RUN ProcDisp IN THIS-PROCEDURE.
    END.
*/

DO WITH FRAME frST:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" )) THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate .
    END.
END. /**/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST cbRptList cbRptList

            FRAME frST fiAsdat  fiAsdat
            FRAME frST fityp1   fityp1
            FRAME frST fityp2   fityp2
            FRAME frST fityp3   fityp3
            FRAME frST fityp4   fityp4
            FRAME frST fityp5   fityp5
            FRAME frST fityp6   fityp6
            FRAME frST fityp7   fityp7
            FRAME frST fityp8   fityp8
            FRAME frST fityp9   fityp9
            FRAME frST fityp10  fityp10
            FRAME frST fityp11  fityp11
            FRAME frST fityp12  fityp12
            FRAME frST fityp13  fityp13
            FRAME frST fityp14  fityp14
            FRAME frST fityp15  fityp15
            FRAME frST toOut    toOut   /* A47-9999 */
            FRAME frST rsType   rsType     /*A53-0159*/
    
            FRAME frOutput rsOutput  rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name
            

            n_branch  = fiBranch
            n_branch2 = fiBranch2
            n_asdat   = fiasdat /*DATE( INPUT cbAsDat) */
            
            nv_out    = toOut
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name

            nv_typ1   = fityp1
            nv_typ2   = fityp2
            nv_typ3   = fityp3
            nv_typ4   = fityp4
            nv_typ5   = fityp5
            nv_typ6   = fityp6
            nv_typ7   = fityp7
            nv_typ8   = fityp8
            nv_typ9   = fityp9
            nv_typ10  = fityp10
            nv_typ11  = fityp11
            nv_typ12  = fityp12
            nv_typ13  = fityp13
            nv_typ14  = fityp14
            nv_typ15  = fityp15.
            /*A53-0159*/
            IF rsType = 1 THEN ASSIGN n_type = "Motor"
                                      mday = 15. 
            ELSE IF rsType = 2 THEN ASSIGN n_type = "Non" 
                                      mday = 0.
            ELSE n_type = "All".
      
ASSIGN
            nv_trntyp1 = IF fityp1  <> "" THEN fityp1 ELSE ""
            nv_trntyp1 = IF fityp2  <> "" THEN nv_trntyp1 + "," + fityp2 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp3  <> "" THEN nv_trntyp1 + "," + fityp3 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp4  <> "" THEN nv_trntyp1 + "," + fityp4 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp5  <> "" THEN nv_trntyp1 + "," + fityp5 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp6  <> "" THEN nv_trntyp1 + "," + fityp6 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp7  <> "" THEN nv_trntyp1 + "," + fityp7 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp8  <> "" THEN nv_trntyp1 + "," + fityp8 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp9  <> "" THEN nv_trntyp1 + "," + fityp9 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp10 <> "" THEN nv_trntyp1 + "," + fityp10 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp11 <> "" THEN nv_trntyp1 + "," + fityp11 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp12 <> "" THEN nv_trntyp1 + "," + fityp12 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp13 <> "" THEN nv_trntyp1 + "," + fityp13 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp14 <> "" THEN nv_trntyp1 + "," + fityp14 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp15 <> "" THEN nv_trntyp1 + "," + fityp15 ELSE nv_trntyp1.            /* nv_trntyp1 = REPLACE(nv_trntyp1,", ","")*/        

    ASSIGN
            nv_filter1 = IF fityp1  <> "" THEN "(agtprm_fil.trntyp BEGINS '" + fityp1 + "') "  ELSE ""
            nv_filter1 = IF fityp2  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp2 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp3  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp3 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp4  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp4 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp5  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp5 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp6  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp6 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp7  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp7 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp8  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp8 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp9  <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp9 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp10 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp10 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp11 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp11 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp12 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp12 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp13 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp13 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp14 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp14 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp15 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp15 + "') "  ELSE nv_filter1.

   END.
        
   /*--- A500178 ---
   IF  n_frac = "" THEN  n_frac = "A000000".
   IF  n_toac = "" THEN  n_toac = "B999999". 
   -----*/
   IF  n_frac = "" THEN  n_frac = "A000000".
   IF  n_toac = "" THEN  n_toac = "B999999999". 

   IF  nv_agent = ""    THEN  nv_agent  = "".
   IF  nv_agent2 = ""   THEN  nv_agent2 = "Z". 

   IF ( n_branch > n_branch2)   THEN DO:
        MESSAGE  "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                  "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
        APPLY "Entry" To fibranch.
        RETURN NO-APPLY.
   END.   
   IF ( nv_agent > nv_agent2)   THEN DO:
        MESSAGE  "ข้อมูล Agent code from - to  ผิดพลาด" SKIP
              "รหัสเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
        APPLY  "Entry" To fiagent.
        RETURN  NO-APPLY.       
   END.
   IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name .
         Return No-Apply.       
   END.

/* kan connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn"
                        NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd = "?".
                     RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_user + " -P " + n_passwd. /*--A49-0139--*/
          END.
      END.
/*---kan*/

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                     : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                "Acno                    : "  n_frac " ถึง " n_toac SKIP (1)
                "Agent                   : "  nv_agent " ถึง " nv_agent2 SKIP (1)                
                "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") SKIP(1)
                "Include Type       : " nv_trntyp1 SKIP(1)
                "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            RUN  pdBranchName.
        
            ASSIGN
                    nv_User   =   n_user
                    nv_pwd    =   n_passwd
                    report-name  =  cbRptList
                    report-library = "wAC/wprl/wacr03.prl".

            vFirstTime =  STRING(TIME, "HH:MM AM").
            /******************/

            RUN pdOutput.  /*A53-0159*/
                           
            DISP "" @ fiProcess WITH FRAME  frST.
            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date     : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                               "ตัวแทน          : "  n_frac " ถึง " n_toac SKIP (1)
                               "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.

        END. /* TRUE */
        WHEN FALSE THEN    DO:
                RETURN NO-APPLY. 
        END.
        END CASE.    
        
    END.   /* IF  asdat  <> ? */
END.

/*
/**/
                IF report-name = "Check List ST(A4) By Branch" THEN 
                        RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND " +
                                          "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                          "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                          " AND " +
                                          "( SUBSTRING(agtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'B' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'C' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'O' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'T' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )" .
                ELSE                /* "STATEMENT A4 SUMMARY" */
                        RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND " +
                                          "( SUBSTRING(agtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'B' " + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'C' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'O' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = 'T' " + " OR " +
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
                                          "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )" .
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME frST /* ... */
DO:

   n_chkBName = "1". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  Disp fibranch fibdes  with Frame {&Frame-Name}      .
 
 n_branch =  fibranch .

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME frST /* ... */
DO:
   n_chkBName = "2". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch2 = n_branch2
        fibdes2   = n_bdes.
       
  Disp fibranch2 fibdes2  with Frame {&Frame-Name}      .
 
 n_branch2 =  fibranch2.

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbRptList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList C-Win
ON RETURN OF cbRptList IN FRAME frST
DO:

       APPLY "ENTRY" TO fiTyp1 IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList C-Win
ON VALUE-CHANGED OF cbRptList IN FRAME frST
DO:
  cbRptList = INPUT cbRptList.
  report-name = cbRptList.
    
    IF report-name = "Summary by Branch" THEN DO:
        ENABLE fiBranch fiBranch2 buBranch buBranch2 WITH FRAME frST.
        RUN pdSym100.
    END.
    ELSE DO:
        DISABLE fiBranch fiBranch2 buBranch buBranch2 WITH FRAME frST. 
    END.
    
    IF report-name = "Summary by Agent" THEN DO:
        ENABLE 
            fiagent fiagent2 
            toOut
            WITH FRAME frST.    
    END.
    ELSE DO:
        DISABLE 
            fiagent fiagent2 
            toOut
            WITH FRAME frST.    
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiagent C-Win
ON LEAVE OF fiagent IN FRAME frST
DO:
    ASSIGN
        fiagent     = INPUT fiagent
        nv_agent    = fiagent.
    
    DISP CAPS(fiagent) @ fiagent WITH FRAME frST.
            
    IF fiagent <> "" THEN DO:
     
        FIND   xmm600 WHERE xmm600.acno   = nv_agent  AND
                            xmm600.gpstmt = nv_agent NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            ASSIGN
                fiagent = xmm600.acno
                finame1 = xmm600.name.
        END.
        ELSE DO:
            ASSIGN
                fiagent = ""
                finame1 = "" .
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
        
        DISP finame1 WITH FRAME frST.
    END.
    
    DISP CAPS (fiagent) @ fiagent WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiagent2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiagent2 C-Win
ON LEAVE OF fiagent2 IN FRAME frST
DO:
    ASSIGN
        fiagent2     = INPUT fiagent2
        nv_agent2    = fiagent2.
    
    DISP CAPS(fiagent2) @ fiagent2 WITH FRAME frST.
            
    IF fiagent <> "" THEN DO:
     
        FIND   xmm600 WHERE xmm600.acno   = nv_agent2  AND
                            xmm600.gpstmt = nv_agent2 NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            ASSIGN
                fiagent2    = xmm600.acno
                finame2     = xmm600.name.
        END.
        ELSE DO:
            ASSIGN
                fiagent2    = ""
                finame2     = "" .
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
        
        DISP finame1 WITH FRAME frST.
    END.
    
    DISP CAPS (fiagent2) @ fiagent2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frST
DO:
  ASSIGN
         fibranch = INPUT fibranch
         n_branch = fibranch.

    DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME frST
DO:
  ASSIGN
    fibranch = input fibranch
    n_branch  = fibranch.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     ASSIGN
         fibranch2 = INPUT fibranch2
         n_branch2  = fibranch2.
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME frST
DO:
    ASSIGN
        fibranch2 = INPUT fibranch2
        n_branch2  = fibranch2.
    
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
            fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
    END.        
    ELSE DO:
            fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 C-Win
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 C-Win
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 C-Win
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 C-Win
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 C-Win
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 C-Win
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp15 C-Win
ON LEAVE OF fiTyp15 IN FRAME frST
DO:
    fiTyp15 = CAPS(INPUT fiTyp15).
    DISP fiTyp15 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 C-Win
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 C-Win
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 C-Win
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 C-Win
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 C-Win
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 C-Win
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 C-Win
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 C-Win
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
           cbPrtList:SENSITIVE   = No
           fiFile-Name:SENSITIVE = No.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No.
        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes. 
          APPLY "ENTRY" TO fiFile-Name.
        END.
  END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME rsType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsType C-Win
ON VALUE-CHANGED OF rsType IN FRAME frST
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOut
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOut C-Win
ON VALUE-CHANGED OF toOut IN FRAME frST /* ส่งกรม */
DO:

  toOut = INPUT toOut.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/************   Program   **************
Wac
        -Wacr13.w            /*PRINT PREMIUM STATEMENT (A4)*/
WPrl
        -Wac_sm02.prl     /* output to screen, printer                  */ 
        -Wac_sm04.prl     /* output to                    file => report ; */
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p
*****************************************/
/* CREATE BY :  Sayamol N. 13/07/2010 */
/* Dupplicate from : WACR03.W   */

/*
Modify : Sayamol N.  17/07/2012  A55-0231 
   - แก้ไขหัวคอลัมน์ 90-365 days เป็น 91-365 days
   - กรณี As Date <= Due Date ให้ยอดเงินอยู่ในช่อง within
     add Parameter mday for calculate Motor (บวกเพิ่มอีก 15 วัน)
   - งาน Motor ไม่แยก Compulsory
*/

    
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

  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/

  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :
        reReports2:MOVE-TO-TOP().
        reBranch2:MOVE-TO-TOP().
        reTrntyp1:MOVE-TO-TOP().
        
        RUN ProcGetRptList.
        RUN ProcGetPrtList.  
        
        RUN pdInitData.  
        RUN pdSym100.
        RUN pdUpdateQ.

        DISABLE toOut.
            
            ASSIGN
                fiInclude =  nv_Trntyp1
                fityp1 = "M"
                fityp2 = "R"
                fityp3 = "A"
                fityp4 = "B"
                fityp5 = "C"
                rsType = 1.   /*A53-0159*/

                
            DISPLAY fiasdat
                    fiInclude   fityp1 fityp2 fityp3 fityp4 fityp5 
                    rsType.   /*A53-0159*/

        IF report-name = "Check List ST(A4) By Branch" THEN DO:
            ENABLE fiBranch fiBranch2 buBranch buBranch2 WITH FRAME frST.
            RUN pdSym100.
        END.
        ELSE DO:
            DISABLE fiBranch fiBranch2 buBranch buBranch2 WITH FRAME frST. 
        END.

        IF report-name = "Summary by Agent" THEN DO:
            ENABLE fiagent fiagent2 WITH FRAME frST.
        END.
        ELSE DO:
            DISABLE fiagent fiagent2 WITH FRAME frST.    
        END.

       APPLY "ENTRY" TO cbRptList .

    END.
    
  DO WITH FRAME frTranDate:
       ASSIGN  
         rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
         rsOutput = 2
          
         cbPrtList:SENSITIVE    = Yes
         fiFile-Name:SENSITIVE  = No.
      DISPLAY rsOutput WITH FRAME frOutput .    
        
        RUN pdAcProc_fil.
  END.

  ASSIGN
        nv_frac  = "A000000"
        nv_toac  = "B999999999"
        nv_agent = "" 
        
        nv_out  = FALSE.
           
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
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rsType toOut cbRptList fiagent fiagent2 fiTyp1 fiTyp2 fiTyp3 fiTyp4 
          fiTyp5 fiBranch fiBranch2 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 
          fiTyp12 fiTyp13 fiTyp14 fiTyp15 fiAsdat fiProcessDate fiInclude fibdes 
          fibdes2 finame1 fiProcess finame2 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE rsType toOut cbRptList brAcproc_fil buBranch fiagent fiagent2 fiTyp1 
         fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiBranch fiBranch2 buBranch2 fiTyp6 fiTyp7 
         fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 fiTyp14 fiTyp15 fiAsdat 
         fiProcessDate fiInclude fibdes fibdes2 finame1 fiProcess finame2 
         reBranch2 RECT-87 RECT-89 reReports2 reReprots reTrntyp1 RECT-96 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcProc_fil C-Win 
PROCEDURE pdAcProc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
  vAcProc_fil = "" .
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  
                                        WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05")
                                        BY asdat DESC  :
        ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME frST = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
    
  DISP cbAsDat WITH FRAME frST .
  
    FIND LAST acproc_fil WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05") AND
                                                         acproc_fil.asdat = DATE(cbAsdat)   NO-LOCK NO-ERROR.
    IF AVAIL acproc_fil THEN DO:
        ASSIGN
            n_trndatto   = AcProc_fil.trndatto
            nv_ProcessDate = acproc_fil.entdat.
    END.
    
    fiProcessDate = nv_ProcessDate.
    
    DISP fiProcessDate WITH FRAME frST.  
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBranchName C-Win 
PROCEDURE pdBranchName :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    vBranchName = "".
    
    FOR EACH  xmm023 NO-LOCK .
        vBranchName = vBranchName + TRIM(xmm023.branch) + 
                                    "(" + STRING(xmm023.bdes,"X(20)") + "),". 
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBrcrtwtB C-Win 
PROCEDURE pdBrcrtwtB :
/*------------------------------------------------------------------------------
  Purpose:     Create Workfile for Summary By Branch แยก Motor / Non Motor
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* TOTAL */
DEF  VAR nv_tprem        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tprem_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tstamp       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_ttax         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tgross       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tcomm        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tcomm_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tnet         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tbal         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_twcr         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_tdamt        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_todue        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue1       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue2       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue3       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue4       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue5       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nv_todue6       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue7       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue8       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nv_todue9       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  


   ASSIGN  n_odat1 = ?
           n_odat2 = ?
           n_odat3 = ?
           n_odat4 = ?
           n_odat5 = ?
           n_odat6 = ?
           n_odat7 = ?
           n_odat8 = ?
           n_odat9 = ?
                   
           n_odue1 = 0
           n_odue2 = 0
           n_odue3 = 0 
           n_odue4 = 0 
           n_odue5 = 0 
           n_odue6 = 0 
           n_odue7 = 0 
           n_odue8 = 0 
           n_odue9 = 0
           n_wcr   = 0
           n_damt  = 0.

           n_duedat = agtprm_fil.duedat .   /*nv_comdat.*/
                    
   ASSIGN  n_odat1 =  n_duedat  +  15
           n_odat2 =  n_duedat  +  30
           n_odat3 =  n_duedat  +  45
           n_odat4 =  n_duedat  +  60
           n_odat5 =  n_duedat  +  90
           n_odat6 =  n_duedat  +  180
           n_odat7 =  n_duedat  +  270
           n_odat8 =  n_duedat  +  365. 

           IF n_asdat <= (n_duedat - fuMaxDay(n_duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย */
           nv_twcr =  agtprm_fil.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
           END.
           IF n_asdat > (n_duedat - fuMaxDay(n_duedat) + mday) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
            nv_tdamt =  agtprm_fil.bal.   /* due Amout  ครบกำหนดชำระ*/
           END.
        
           IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
           nv_todue1 =  agtprm_fi.bal.    /*  overdue 1 - 15 days*/
           END.
           IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
           nv_todue2 =   agtprm_fi.bal.    /*  overdue 16 - 30 days*/
           END.
           IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
           nv_todue3 = agtprm_fi.bal.    /*  overdue 31 - 45 days*/
           END.
           IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
           nv_todue4 =  agtprm_fi.bal.    /*  overdue 46 - 60 days*/
           END.
           IF n_asdat > n_odat4 AND n_asdat <= n_odat5 THEN DO:
           nv_todue5 =  agtprm_fi.bal.    /*  overdue 61 - 90 days*/
           END.
           IF n_asdat > n_odat5 AND n_asdat <= n_odat6 THEN DO:
           nv_todue6 =  agtprm_fi.bal.    /*  overdue 91 - 180 days*/
           END.
           IF n_asdat > n_odat6 AND n_asdat <= n_odat7 THEN DO:
           nv_todue7 =  agtprm_fi.bal.    /*  overdue 181 - 270 days*/
           END.
           IF n_asdat > n_odat7 AND n_asdat <= n_odat8 THEN DO:
           nv_todue8 =  agtprm_fi.bal.    /*  overdue 271 - 365 days*/
           END.
           IF n_asdat > n_odat8   THEN DO:
           nv_todue9 =   agtprm_fi.bal.    /*  overdue Over 365 days*/
           END.
        
           nv_todue = nv_todue1 + nv_todue2 + nv_todue3 + nv_todue4 + nv_todue5 +
                 nv_todue6 + nv_todue7 + nv_todue8 + nv_todue9.
                    
                    ASSIGN nv_tbal       =       agtprm_fil.bal
                           nv_tgross     =    agtprm_fil.gross
                           nv_tcomm      =       agtprm_fil.comm
                           nv_tcomm_comp =  agtprm_fil.comm_comp.


FIND FIRST wtBSum USE-INDEX wtBSum1 
    WHERE wtBsum.wtBacno = agtprm_fil.acno AND
          wtBsum.wtBbran   = agtprm_fil.polbran AND 
          wtBsum.wtBpoltyp = SUBSTR(nv_polgrp,1,3) NO-ERROR.  
IF NOT AVAIL wtBSum THEN DO:

    FIND FIRST xmm600 USE-INDEX xmm60001
                        WHERE (xmm600.acno = agtprm_fil.acno) NO-LOCK NO-ERROR NO-WAIT.
    /*** start note modi ***/
    IF AVAIL xmm600 THEN DO:  
        ASSIGN
        nv_gpstmt = xmm600.gpstmt
        nv_clicod = xmm600.clicod. /*note add*/
    END.

    CREATE wtBsum.
    ASSIGN 
           wtBsum.wtBgpstmt  = nv_gpstmt
           wtBsum.wtBacno    = agtprm_fil.acno
           wtBsum.wtBpoltyp  = SUBSTR(nv_polgrp,1,3)
           wtBsum.wtBacname  = agtprm_fil.ac_name
           wtBsum.wtBbranch  = agtprm_fil.polbran
           wtBsum.wtBcredit  = agtprm_fil.credit
           wtBsum.wtBltamt   = agtprm_fil.odue6
           wtBsum.wtBbal     = nv_tbal  
           wtBsum.wtBwcr     = nv_twcr  
           wtBsum.wtBdamt    = nv_tdamt 
           wtBsum.wtBodue    = nv_todue 
           wtBsum.wtBodue1   = nv_todue1 
           wtBsum.wtBodue2   = nv_todue2 
           wtBsum.wtBodue3   = nv_todue3 
           wtBsum.wtBodue4   = nv_todue4 
           wtBsum.wtBodue5   = nv_todue5 
           wtBsum.wtBodue6   = nv_todue6 
           wtBsum.wtBodue7   = nv_todue7 
           wtBsum.wtBodue8   = nv_todue8 
           wtBsum.wtBodue9   = nv_todue9 
           wtBsum.Bclientco  = nv_clicod /*note add ja*/
           /*---A53-0159---*/
           wtBsum.wtBgrptyp    = SUBSTR(nv_dir,3,1)    /*   P, C , Non    */
           wtBsum.wtBpolgrp    = nv_polgrp              /*   MOTDiC, MOTDiP, MOTBrC, MOTBrP, MOTCOC NON      */ 
           .      
END.

ELSE DO:
    ASSIGN
           wtBsum.wtBltamt   = agtprm_fil.odue6
           wtBsum.wtBbal     = wtBsum.wtBbal    +  nv_tbal        
           wtBsum.wtBwcr     = wtBsum.wtBwcr    +  nv_twcr        
           wtBsum.wtBdamt    = wtBsum.wtBdamt   +  nv_tdamt       
           wtBsum.wtBodue    = wtBsum.wtBodue   +  nv_todue       
           wtBsum.wtBodue1   = wtBsum.wtBodue1  +  nv_todue1      
           wtBsum.wtBodue2   = wtBsum.wtBodue2  +  nv_todue2      
           wtBsum.wtBodue3   = wtBsum.wtBodue3  +  nv_todue3      
           wtBsum.wtBodue4   = wtBsum.wtBodue4  +  nv_todue4      
           wtBsum.wtBodue5   = wtBsum.wtBodue5  +  nv_todue5      
           wtBsum.wtBodue6   = wtBsum.wtBodue6  +  nv_todue6      
           wtBsum.wtBodue7   = wtBsum.wtBodue7  +  nv_todue7      
           wtBsum.wtBodue8   = wtBsum.wtBodue8  +  nv_todue8      
           wtBsum.wtBodue9   = wtBsum.wtBodue9  +  nv_todue9.     
                                                    
END.    


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBrCrtWTG C-Win 
PROCEDURE pdBrCrtWTG :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---Total for Mot Non CMP of Branch ---*/
FIND FIRST wtGSum WHERE
          wtGsum.wtGpoltyp = wtTsum.wtTpoltyp NO-ERROR.  
IF NOT AVAIL wtGSum THEN DO:
    CREATE wtGsum.
    ASSIGN 
           wtGsum.wtGpoltyp  = wtTsum.wtTpoltyp                                                          
           wtGsum.wtGltamt   = wtTsum.wtTltamt                                                                    
           wtGsum.wtGbal     = wtTsum.wtTbal                                                                      
           wtGsum.wtGwcr     = wtTsum.wtTwcr                                                                      
           wtGsum.wtGdamt    = wtTsum.wtTdamt                                                                     
           wtGsum.wtGodue    = wtTsum.wtTodue                                                                     
           wtGsum.wtGodue1   = wtTsum.wtTodue1                                                                    
           wtGsum.wtGodue2   = wtTsum.wtTodue2                                                                    
           wtGsum.wtGodue3   = wtTsum.wtTodue3                                                                    
           wtGsum.wtGodue4   = wtTsum.wtTodue4                                                                    
           wtGsum.wtGodue5   = wtTsum.wtTodue5                                                                    
           wtGsum.wtGodue6   = wtTsum.wtTodue6                                                                    
           wtGsum.wtGodue7   = wtTsum.wtTodue7                                                                    
           wtGsum.wtGodue8   = wtTsum.wtTodue8                                                                    
           wtGsum.wtGodue9   = wtTsum.wtTodue9                                                                    
           .      
END.
ELSE DO:
    ASSIGN
           wtGsum.wtGltamt   =  wtGsum.wtGltamt   +  wtTsum.wtTltamt                   
           wtGsum.wtGbal     =  wtGsum.wtGbal     +  wtTsum.wtTbal                     
           wtGsum.wtGwcr     =  wtGsum.wtGwcr     +  wtTsum.wtTwcr                     
           wtGsum.wtGdamt    =  wtGsum.wtGdamt    +  wtTsum.wtTdamt                    
           wtGsum.wtGodue    =  wtGsum.wtGodue    +  wtTsum.wtTodue                    
           wtGsum.wtGodue1   =  wtGsum.wtGodue1   +  wtTsum.wtTodue1                   
           wtGsum.wtGodue2   =  wtGsum.wtGodue2   +  wtTsum.wtTodue2                   
           wtGsum.wtGodue3   =  wtGsum.wtGodue3   +  wtTsum.wtTodue3                   
           wtGsum.wtGodue4   =  wtGsum.wtGodue4   +  wtTsum.wtTodue4                   
           wtGsum.wtGodue5   =  wtGsum.wtGodue5   +  wtTsum.wtTodue5                   
           wtGsum.wtGodue6   =  wtGsum.wtGodue6   +  wtTsum.wtTodue6                   
           wtGsum.wtGodue7   =  wtGsum.wtGodue7   +  wtTsum.wtTodue7                   
           wtGsum.wtGodue8   =  wtGsum.wtGodue8   +  wtTsum.wtTodue8                   
           wtGsum.wtGodue9   =  wtGsum.wtGodue9   +  wtTsum.wtTodue9 .                  
END.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBrCrtWTT C-Win 
PROCEDURE pdBrCrtWTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---Total for Mot Non CMP of Branch ---*/
FIND FIRST wtTSum USE-INDEX wtTSum1 WHERE
          wtTsum.wtTbran   = nn_polbran AND 
          wtTsum.wtTpoltyp = nn_poltyp NO-ERROR.  
IF NOT AVAIL wtTSum THEN DO:
    CREATE wtTsum.
    ASSIGN 
           wtTsum.wtTgpstmt  = wtBsum.wtBgpstmt                        
           wtTsum.wtTpoltyp  = wtBsum.wtBpoltyp                                                          
           wtTsum.wtTbranch  = wtBsum.wtBbranch                                                           
           wtTsum.wtTcredit  = wtBsum.wtBcredit                                                                   
           wtTsum.wtTltamt   = wtBsum.wtBltamt                                                                    
           wtTsum.wtTbal     = wtBsum.wtBbal                                                                      
           wtTsum.wtTwcr     = wtBsum.wtBwcr                                                                      
           wtTsum.wtTdamt    = wtBsum.wtBdamt                                                                     
           wtTsum.wtTodue    = wtBsum.wtBodue                                                                     
           wtTsum.wtTodue1   = wtBsum.wtBodue1                                                                    
           wtTsum.wtTodue2   = wtBsum.wtBodue2                                                                    
           wtTsum.wtTodue3   = wtBsum.wtBodue3                                                                    
           wtTsum.wtTodue4   = wtBsum.wtBodue4                                                                    
           wtTsum.wtTodue5   = wtBsum.wtBodue5                                                                    
           wtTsum.wtTodue6   = wtBsum.wtBodue6                                                                    
           wtTsum.wtTodue7   = wtBsum.wtBodue7                                                                    
           wtTsum.wtTodue8   = wtBsum.wtBodue8                                                                    
           wtTsum.wtTodue9   = wtBsum.wtBodue9                                                                    
           wtTsum.Tclientco  = wtBsum.Bclientco                                                                   
           /*--A53-0159---*/                                                                                                 
           wtTsum.wtTgrptyp  = wtBsum.wtBgrptyp    /*   P, C , Non    */                                                 
           wtTsum.wtTpolgrp  = wtBsum.wtBpolgrp     /*   MOTDiC, MOTDiP, MOTBrC, MOTBrP, MOTCOC NON      */              
           .      
END.
ELSE DO:
    ASSIGN
           wtTsum.wtTltamt   =  wtTsum.wtTltamt   +  wtBsum.wtBltamt                   
           wtTsum.wtTbal     =  wtTsum.wtTbal     +  wtBsum.wtBbal                     
           wtTsum.wtTwcr     =  wtTsum.wtTwcr     +  wtBsum.wtBwcr                     
           wtTsum.wtTdamt    =  wtTsum.wtTdamt    +  wtBsum.wtBdamt                    
           wtTsum.wtTodue    =  wtTsum.wtTodue    +  wtBsum.wtBodue                    
           wtTsum.wtTodue1   =  wtTsum.wtTodue1   +  wtBsum.wtBodue1                   
           wtTsum.wtTodue2   =  wtTsum.wtTodue2   +  wtBsum.wtBodue2                   
           wtTsum.wtTodue3   =  wtTsum.wtTodue3   +  wtBsum.wtBodue3                   
           wtTsum.wtTodue4   =  wtTsum.wtTodue4   +  wtBsum.wtBodue4                   
           wtTsum.wtTodue5   =  wtTsum.wtTodue5   +  wtBsum.wtBodue5                   
           wtTsum.wtTodue6   =  wtTsum.wtTodue6   +  wtBsum.wtBodue6                   
           wtTsum.wtTodue7   =  wtTsum.wtTodue7   +  wtBsum.wtBodue7                   
           wtTsum.wtTodue8   =  wtTsum.wtTodue8   +  wtBsum.wtBodue8                   
           wtTsum.wtTodue9   =  wtTsum.wtTodue9   +  wtBsum.wtBodue9 .                  
END.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCalComdat C-Win 
PROCEDURE pdCalComdat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  n_odat1 = ?
        n_odat2 = ?
        n_odat3 = ?
        n_odat4 = ?
        n_odat5 = ?
        n_odat6 = ?
        n_odat7 = ?
        n_odat8 = ?
        n_odat9 = ?

        n_odue1 = 0
        n_odue2 = 0
        n_odue3 = 0 
        n_odue4 = 0 
        n_odue5 = 0 
        n_odue6 = 0 
        n_odue7 = 0 
        n_odue8 = 0 
        n_odue9 = 0
        n_wcr   = 0
        n_damt  = 0.

FIND FIRST uwm100 USE-INDEX uwm10090 WHERE uwm100.trty11 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                                           uwm100.docno1 = agtprm_fil.docno NO-ERROR.
IF AVAIL uwm100 THEN DO:
    IF uwm100.endcnt > 000 THEN nv_comdat = uwm100.enddat.
    ELSE nv_comdat = uwm100.comdat. 
END.

n_duedat = nv_comdat.

ASSIGN  n_odat1 =  n_duedat  +  15
        n_odat2 =  n_duedat  +  30
        n_odat3 =  n_duedat  +  45
        n_odat4 =  n_duedat  +  60
        n_odat5 =  n_duedat  +  90
        n_odat6 =  n_duedat  +  180
        n_odat7 =  n_duedat  +  270
        n_odat8 =  n_duedat  +  365. 

IF n_asdat <= (n_duedat - fuMaxDay(n_duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย */
   n_wcr = n_wcr + agtprm_fil.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
END.
IF n_asdat > (n_duedat - fuMaxDay(n_duedat) + mday) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
    n_damt = n_damt + agtprm_fil.bal.   /* due Amout  ครบกำหนดชำระ*/
END.

IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
   n_odue1 = n_odue1 + agtprm_fi.bal.    /*  overdue 1 - 15 days*/
END.
IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
   n_odue2 =  n_odue2 + agtprm_fi.bal.    /*  overdue 16 - 30 days*/
END.
IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
   n_odue3 = n_odue3 + agtprm_fi.bal.    /*  overdue 31 - 45 days*/
END.
IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
   n_odue4 = n_odue4 + agtprm_fi.bal.    /*  overdue 46 - 60 days*/
END.
IF n_asdat > n_odat4 AND n_asdat <= n_odat5 THEN DO:
   n_odue5 = n_odue5 + agtprm_fi.bal.    /*  overdue 61 - 90 days*/
END.
IF n_asdat > n_odat5 AND n_asdat <= n_odat6 THEN DO:
   n_odue6 = n_odue6 + agtprm_fi.bal.    /*  overdue 91 - 180 days*/
END.
IF n_asdat > n_odat6 AND n_asdat <= n_odat7 THEN DO:
   n_odue7 = n_odue7 + agtprm_fi.bal.    /*  overdue 181 - 270 days*/
END.
IF n_asdat > n_odat7 AND n_asdat <= n_odat8 THEN DO:
   n_odue8 = n_odue8 + agtprm_fi.bal.    /*  overdue 271 - 365 days*/
END.
IF n_asdat > n_odat8   THEN DO:
   n_odue9 =  n_odue9 + agtprm_fi.bal.    /*  overdue Over 365 days*/
END.

n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 +
         n_odue6 + n_odue7 + n_odue8 + n_odue9.

ASSIGN  nv_tot_odue1 = nv_tot_odue1 +     n_odue1
        nv_tot_odue2 = nv_tot_odue2 +     n_odue2
        nv_tot_odue3 = nv_tot_odue3 +     n_odue3
        nv_tot_odue4 = nv_tot_odue4 +     n_odue4
        nv_tot_odue5 = nv_tot_odue5 +     n_odue5
        nv_tot_odue6 = nv_tot_odue6 +     n_odue6
        nv_tot_odue7 = nv_tot_odue7 +     n_odue7
        nv_tot_odue8 = nv_tot_odue8 +     n_odue8
        nv_tot_odue9 = nv_tot_odue9 +     n_odue9
        nv_tot_wcr   = nv_tot_wcr   +     n_wcr
        nv_tot_damt  = nv_tot_damt  +     n_damt
        nv_tot_odue  = nv_tot_odue  +     n_odue.

/*
ASSIGN  n_odue1 = 0
        n_odue2 = 0
        n_odue3 = 0 
        n_odue4 = 0 
        n_odue5 = 0 
        n_odue6 = 0 
        n_odue7 = 0 
        n_odue8 = 0 
        n_odue9 = 0
        n_wcr   = 0
        n_damt  = 0.*/
    .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDeptGrp C-Win 
PROCEDURE pdDeptGrp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_dir = ""
       nv_polgrp = ""
       nv_grptypdes = ""
       nv_insref = "".

FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
IF AVAIL xmm031 THEN DO:

   IF xmm031.dept = "G" OR xmm031.dept = "M" THEN DO:   /*Motor*/  /*A55-0231*/
      ASSIGN nv_polgrp = "MOT".

      FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                 acm001.docno  = agtprm_fil.docno NO-LOCK NO-ERROR.
      IF AVAIL acm001 THEN DO:
   
         IF SUBSTR((acm001.insref),2,1) = "C" OR 
            SUBSTR((acm001.insref),3,1) = "C" THEN
            nv_insref = "C".   /*Customer Type = Corperate */
         ELSE nv_insref = "P".   /*Customer Type = Personal */

         FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                   xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
         IF NOT AVAIL xmm600 THEN NEXT.
         ELSE DO:
            /*--- -- Aging Day ---*/
              IF xmm600.autoap = YES THEN DO:     /* -- Direct */
        
                 IF nv_insref = "P" THEN 
                     ASSIGN  nv_dir = "DiP"   /* CBC------------*/
                             nv_grptypdes = "บุคคลธรรมดา".
                 ELSE  ASSIGN nv_dir = "DiC"         /* ---------*/
                              nv_grptypdes = "นิติบุคคล".
                 
              END.
              ELSE DO:              /* -- Broker */
                  IF nv_insref = "P" THEN 
                     ASSIGN nv_dir = "BrP"   /* -----------*/
                            nv_grptypdes = "บุคคลธรรมดา".
                  ELSE ASSIGN nv_dir = "BrC"     /* ---------*/    
                               nv_grptypdes = "นิติบุคคล".
              END.
             
         END.   /*end find first*/

      END.  /*end acm001*/

      nv_polgrp = nv_polgrp + nv_dir.

   END.   /* end xmm031.dept = "G" - Motor */
   /*---By A55-0231 ---
   ELSE IF xmm031.dept = "M" THEN DO:       /*Compulsory*/
      ASSIGN nv_polgrp = "CMP"
             nv_dir    = "CMP"
             nv_polgrp = nv_polgrp + nv_dir
             nv_grptypdes = "Compulsory". 
   END.
   -------------------*/
   ELSE DO:   /*Non-Motor*/
       ASSIGN nv_dir = "NON"
              nv_polgrp = "NON" 
              nv_polgrp = nv_polgrp + nv_dir
              nv_grptypdes = "Non Motor".   
   END.
    
END.   /* end xmm031*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAcno C-Win 
PROCEDURE pdExpAcno :
/*------------------------------------------------------------------------------
  Purpose:     create A47-0035
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_fileH AS CHAR.

    ASSIGN
        nv_gtot_bal = 0
        
        nv_gtot_wcr = 0
        nv_gtot_damt = 0
        nv_gtot_odue = 0
        
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0
        /*---A53-0159---*/
        nv_gtot_odue6 = 0
        
        nv_gtot_gross = 0
        nv_gtot_comm = 0
        nv_gtot_comm_comp = 0
        .

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(fiFile-Name)  ) NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Asdate : " +  STRING(n_asdat,"99/99/9999")
                ""
                "wacr03.w - STATEMENT A4 SUMMARY BY PRODUCER"
                "" "" "" "" ""
                "Include Type : " +  nv_trntyp1.

            EXPORT DELIMITER ";"
                "Group Statement"
                "Account No." "Name"  "Credit Limit" "Gross" "Comm + Comm_comp" " Balance Due"
                "Within"  "Due Amount "  "Overdue" 
                /*---A53-0159
                "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                ----------*/
                "1 - 30 days"  "31 - 60 days"  "61 - 90 days"  " 91 - 365 days"  "over 365 days". 

        END.
    OUTPUT CLOSE.
/********************** END Page Header *********************/  

    FOR EACH wtSum USE-INDEX wtSum1  :

            /***************** EXPORT DETAIL ***************/
            
            OUTPUT TO VALUE (STRING(fiFile-Name)  ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    wtsum.wtgpstmt
                    wtsum.wtacno
                    wtsum.wtacname
                    /*STRING(wtsum.wtcredit)*/
                    STRING(wtsum.wtltamt,"->>>,>>>,>>>,>>9.99")
                    wtsum.wtgross
                    wtsum.wtcomm + wtsum.wtcomm_comp
                    
                    wtsum.wtbal
                    wtsum.wtwcr
                    wtsum.wtdamt
                    wtsum.wtodue
    
                    wtsum.wtodue1
                    wtsum.wtodue2
                    wtsum.wtodue3
                    wtsum.wtodue4
                    wtsum.wtodue5
                    /*---A53-0159---*/
                    SUBSTR(wtsum.wtpolgrp,1,3)
                    wtsum.wtgrptyp 
                    .
                   
            OUTPUT CLOSE.
            
            /***************** END EXPORT DETAIL ***************/

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_gross   = nv_gtot_gross + wtsum.wtgross
                    nv_gtot_comm   = nv_gtot_comm + wtsum.wtcomm
                    nv_gtot_comm_comp   = nv_gtot_comm_comp + wtsum.wtcomm_comp
                    
                    
                    nv_gtot_bal        = nv_gtot_bal + wtsum.wtbal

                    nv_gtot_wcr        = nv_gtot_wcr + wtsum.wtwcr
                    nv_gtot_damt     = nv_gtot_damt + wtsum.wtdamt
                    nv_gtot_odue     = nv_gtot_odue + wtsum.wtodue

                    nv_gtot_odue1   = nv_gtot_odue1 + wtsum.wtodue1
                    nv_gtot_odue2   = nv_gtot_odue2 + wtsum.wtodue2
                    nv_gtot_odue3   = nv_gtot_odue3 + wtsum.wtodue3
                    nv_gtot_odue4   = nv_gtot_odue4 + wtsum.wtodue4
                    nv_gtot_odue5   = nv_gtot_odue5 + wtsum.wtodue5.


/********************** Group Footer *********************/    

                    vCount = vCount + 1.


    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.

                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    ""
                    ""
                    ""
                    /*""*/
                    nv_gtot_gross
                    nv_gtot_comm + nv_gtot_comm_comp
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.

        OUTPUT CLOSE.
/********************** Page Footer *********************/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAcnoA470035 C-Win 
PROCEDURE pdExpAcnoA470035 :
/*-------------- comment  A47-0035
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.

    ASSIGN
        nv_gtot_bal = 0
        
        nv_gtot_wcr = 0
        nv_gtot_damt = 0
        nv_gtot_odue = 0
        
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0.

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(fiFile-Name) )  NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Asdate : " +  STRING(n_asdat,"99/99/9999")
                ""
                "wacr03.w - Check List Statement to Excel By Acno"  /* "Statement A4 Reports By Acno"  */
                "" "" "" "" ""
                "Include Type : " +  nv_trntyp1.
            /*
            EXPORT DELIMITER ";"
                "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วงเงินเครดิต" "รวมยอดค้างชำระ" 
                "ยอดไม่ครบกำหนด" "ครบกำหนด" "รวมยอดค้างชำระเกินกำหนด" "ค้าง 1-3 เดือน "  "ค้าง 3-6 เดือน"  "ค้าง 6-9 เดือน"   "ค้าง 9-12 เดือน"  "ค้าง เกิน 12 เดือน".
            */
            EXPORT DELIMITER ";"
                 "Account No." "Name"  "Credit"  "Credit Limit" " Balance Due"
                 "Within"  "Due Amount "  "Overdue"  "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 

        END.
    OUTPUT CLOSE.
/********************** END Page Header *********************/  

    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat       = n_asdat   AND
             (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK BY agtprm_fil.acno.

       DISP STRING(rsOutput) + "  " + agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                  agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
           
/********************** Group Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN
                    nv_tot_bal = 0

                    nv_tot_wcr = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0
                    
                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0.
             END.

/********************** SUM DETAIL *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_bal                = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr          = nv_tot_wcr + agtprm_fil.wcr
                    nv_tot_damt       = nv_tot_damt + agtprm_fil.damt
                    nv_tot_odue     = nv_tot_odue + agtprm_fil.odue

                    nv_tot_odue1     = nv_tot_odue1 + agtprm_fil.odue1
                    nv_tot_odue2      = nv_tot_odue2 + agtprm_fil.odue2
                    nv_tot_odue3      = nv_tot_odue3 + agtprm_fil.odue3
                    nv_tot_odue4     = nv_tot_odue4 + agtprm_fil.odue4
                    nv_tot_odue5     = nv_tot_odue5 + agtprm_fil.odue5.
                    
/********************** Group Footer *********************/    
             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
/*                    "TOTAL : " + agtprm_fil.acno*/
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    STRING(agtprm_fil.credit)
                    STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")
                    
                    nv_tot_bal

                    nv_tot_wcr
                    nv_tot_damt
                    nv_tot_odue

                    nv_tot_odue1
                    nv_tot_odue2
                    nv_tot_odue3
                    nv_tot_odue4
                    nv_tot_odue5.

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_bal        = nv_gtot_bal + nv_tot_bal

                    nv_gtot_wcr        = nv_gtot_wcr + nv_tot_wcr
                    nv_gtot_damt     = nv_gtot_damt + nv_tot_damt
                    nv_gtot_odue     = nv_gtot_odue + nv_tot_odue

                    nv_gtot_odue1     = nv_gtot_odue1 + nv_tot_odue1
                    nv_gtot_odue2      = nv_gtot_odue2 + nv_tot_odue2
                    nv_gtot_odue3      = nv_gtot_odue3 + nv_tot_odue3
                    nv_gtot_odue4     = nv_gtot_odue4 + nv_tot_odue4
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5.

             END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.


    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    ""     ""     ""
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.

        OUTPUT CLOSE.
/********************** Page Footer *********************/
-------------- comment  A47-0035 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAcnoProcess C-Win 
PROCEDURE pdExpAcnoProcess :
/*------------------------------------------------------------------------------
  Purpose:     create A47-0035
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.

    FOR EACH wtSum : DELETE wtsum. END.

    /*---A53-0159---*/
    nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
    mday = 15.  /*A55-0231*/
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
    mday = 0.  /*A55-0231*/ 
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.
    /*-----------*/

    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat    = n_asdat  AND
             (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )             
    NO-LOCK BREAK /* BY agtprm_fil.polbran*/  BY agtprm_fil.acno :

        DISP  /*agtprm_fil.acno --- A500178 ---*/
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.policy
              agtprm_fil.trntyp
              agtprm_fil.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess3 VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
        
        IF rstype = 3 THEN RUN pdmDay.

             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN
                    nv_tot_bal = 0

                    nv_tot_wcr = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0
                    
                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0
                    
                    nv_tot_gross = 0
                    nv_tot_comm = 0
                    nv_tot_comm_comp = 0
                    /*---A55-0231---*/
                    n_odue1 = 0
                    n_odue2 = 0
                    n_odue3 = 0
                    n_odue4 = 0
                    n_odue5 = 0.
                    /*--------------*/
                    .
             END.

            /********************** SUM DETAIL *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_bal     = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr     = nv_tot_wcr + agtprm_fil.wcr
                    nv_tot_damt    = nv_tot_damt + agtprm_fil.damt
                    nv_tot_odue    = nv_tot_odue + agtprm_fil.odue
                    nv_tot_gross    = nv_tot_gross + agtprm_fil.gross
                    nv_tot_comm     = nv_tot_comm + agtprm_fil.comm
                    nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp.
                /*---By A55-0231----
                    nv_tot_odue1   = nv_tot_odue1 + agtprm_fil.odue1
                    nv_tot_odue2   = nv_tot_odue2 + agtprm_fil.odue2
                    nv_tot_odue3   = nv_tot_odue3 + agtprm_fil.odue3
                    nv_tot_odue4   = nv_tot_odue4 + agtprm_fil.odue4
                    nv_tot_odue5   = nv_tot_odue5 + agtprm_fil.odue5.
                    -----------*/
            /*---By A55-0231----*/
               ASSIGN
                    n_odat1 = agtprm_fil.duedat  + 30  /* ได้วันที่วันสุดท้ายในช่วง*/
                    n_odat2 = agtprm_fil.duedat  + 60
                    n_odat3 = agtprm_fil.duedat  + 90
                    n_odat4 = agtprm_fil.duedat  + 365.

            /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
               IF  n_asdat <= (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                   n_wcr = n_wcr + agtprm_fil.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
               END.
               IF n_asdat > (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) AND n_asdat <= agtprm_fil.duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                   n_damt = n_damt + agtprm_fil.bal .             /* due Amout  ครบกำหนดชำระ*/
               END.
               /*-------------------------------*/ 
               IF n_asdat > agtprm_fil.duedat AND n_asdat <= n_odat1 THEN DO:
                       n_odue1 = n_odue1 +  agtprm_fil.bal.         /* 1-30 days */  /* เดิม  overdue 1- 3 months*/
               END.
               IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                       n_odue2 = n_odue2 +  agtprm_fil.bal.         /*31-60 days */  /* เดิม overdue 3 - 6 months*/
               END.
               IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                       n_odue3 = n_odue3 +  agtprm_fil.bal.         /*61-90 days*/   /* เดิม overdue 6 - 9 months*/
               END.
               IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                       n_odue4 = n_odue4 +  agtprm_fil.bal.         /*91-365 days */   /* เดิม overdue 9 - 12 months*/
               END.
               IF n_asdat > n_odat4 THEN DO:
                       n_odue5 = n_odue5 +  agtprm_fil.bal.        /*over 365 days */   /* เดิม over 12  months*/
               END.
               
               n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5. 

            ASSIGN nv_tot_odue1   =  n_odue1
                   nv_tot_odue2   =  n_odue2
                   nv_tot_odue3   =  n_odue3
                   nv_tot_odue4   =  n_odue4
                   nv_tot_odue5   =  n_odue5.

           /*---end A55-0231---*/
                    

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN nv_dir = ""
                       nv_polgrp = ""
                       nv_grptypdes = "".

                RUN pdDeptGrp.

                ASSIGN
                    nv_gpstmt = ""
                    nv_gpname = "".
                
                FIND FIRST wtSum USE-INDEX wtSum1 
                                WHERE wtsum.wtacno = agtprm_fil.acno AND
                                      wtsum.wtbran  = agtprm_fil.polbran NO-ERROR.
                IF NOT AVAIL wtSum THEN DO:
                
                    FIND FIRST xmm600 USE-INDEX xmm60001
                                        WHERE (xmm600.acno = agtprm_fil.acno) NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xmm600 THEN  nv_gpstmt = xmm600.gpstmt.
                
                    CREATE wtSum.
                    ASSIGN
                        wtsum.wtgpstmt  = nv_gpstmt
                        wtsum.wtacno    = agtprm_fil.acno
                        wtsum.wtacname  = agtprm_fil.ac_name
                        wtsum.wtbranch  = agtprm_fil.polbran
                        wtsum.wtcredit  = agtprm_fil.credit
                        wtsum.wtltamt   = agtprm_fil.odue6
                        
                        wtsum.wtbal     = nv_tot_bal
                        wtsum.wtwcr     = nv_tot_wcr
                        wtsum.wtdamt    = nv_tot_damt
                        wtsum.wtodue    = nv_tot_odue
    
                        wtsum.wtodue1   = nv_tot_odue1
                        wtsum.wtodue2   = nv_tot_odue2
                        wtsum.wtodue3   = nv_tot_odue3
                        wtsum.wtodue4   = nv_tot_odue4
                        wtsum.wtodue5   = nv_tot_odue5
                        
                        wtsum.wtagent   = agtprm_fil.agent
                        wtsum.wtgross   = nv_tot_gross
                        wtsum.wtcomm    = nv_tot_comm
                        wtsum.wtcomm_comp = nv_tot_comm_comp
                        /*---A53-0159---*/
                        wtsum.wtgrptyp    = SUBSTR(nv_dir,3,1)    /*   P, C , Non    */
                        wtsum.wtpolgrp    = nv_polgrp              /*   MOTDiC, MOTDiP, MOTBrC, MOTBrP, MOTCOC NON      */ 
                        .
                        

                END.  /* if not avail wtSum  - create*/

             END. /* IF LAST-OF(agtprm_fil.acno)  */

    END. /* for each agtprm_fil*/

/*    output to d:\temp\wtsumac.txt   .
 *         EXPORT  DELIMITER ";"
 *             "wtgstmt"  "wtacno" "wtagent" "wtacname" "wtbranch" "wtcredit"   "wtltamt"  "wtbal"  "wtdamt"  "wtodue"
 *               "wtodue1"   "wtodue2"   "wtodue3"    "wtodue4"    "wtodue5"     "wtgross"   "wtcomm"    "wtcomm_comp".
 *     for each wtsum:
 *         export delimiter ":" wtsum.
 *     
 *     end.
 *     output close.*/

END PROCEDURE.


/*        DISP STRING(rsOutput) + "  " + agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " + */
/*                   agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .                                                  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAgent C-Win 
PROCEDURE pdExpAgent :
/*------------------------------------------------------------------------------
  Purpose:     create A47-0035
  Parameters:  <none>
  Notes:       nv_out = true  เฉพาะ Agent เท่านั้น  ไม่เอา column acno
               nv_out = false  มี agent  acno ด้วย 
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_agentname AS CHAR.
DEF VAR nv_fileH AS CHAR.
DEF VAR nv_crper    AS DECI.
DEF VAR nv_ltamt    AS DECI.
DEF VAR nv_clicod   AS CHAR.

    ASSIGN
        nv_gtot_bal     = 0
        
        nv_gtot_wcr     = 0
        nv_gtot_damt    = 0
        nv_gtot_odue    = 0
        
        nv_gtot_odue1   = 0
        nv_gtot_odue2   = 0
        nv_gtot_odue3   = 0
        nv_gtot_odue4   = 0
        nv_gtot_odue5   = 0
        
        nv_gtot_gross   = 0
        nv_gtot_comm    = 0
        nv_gtot_comm_comp = 0
        .

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(fiFile-Name)  ) NO-ECHO.
        IF vCount = 0 THEN DO:

            IF nv_out = TRUE  THEN DO:
                EXPORT DELIMITER ";"
                    "Asdate : " +  STRING(n_asdat,"99/99/9999")
                    ""
                    "wacr03.w - STATEMENT A4 SUMMARY BY AGENT"  /* "Statement A4 Reports By Agent"  */
                    "" "" "" "" ""
                    "Include Type : " +  nv_trntyp1 
    
                    /* A47-0500 */
                    "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    ""
                    "Agent : " + nv_agent + " - " + nv_agent2
                    .

                EXPORT DELIMITER ";"
                    "Agent"
                    "Name"  "Credit Limit"  "Group Statement"  "Gross" "Comm + Comm_comp"  " Balance Due"
                    "Within"  "Due Amount "  "Overdue"
                    "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                    

            END.
            ELSE DO: 
                EXPORT DELIMITER ";"
                    "Asdate : " +  STRING(n_asdat,"99/99/9999")
                    ""
                    "wacr03.w - STATEMENT A4 SUMMARY BY AGENT ส่งกรม "  /* "Statement A4 Reports By Agent ส่งกรม"  */
                    "" "" "" "" ""
                    "Include Type : " +  nv_trntyp1 
    
                    /* A47-0500 */
                    "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    ""
                    "Agent : " + nv_agent + " - " + nv_agent2

                    .

                EXPORT DELIMITER ";"
                    "Agent"
                    "Name"   "Credit Limit"  "Group Statement"  "Gross" "Comm"  " Balance Due"
                    "Within"  "Due Amount "  "Overdue" 
                    "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
            END.

        END.
    OUTPUT CLOSE.

/********************** END Page Header *********************/  

    FOR EACH wtSum USE-INDEX wtSum4 BREAK BY wtSum.wtagent :

/********************** Group Header *********************/
        IF FIRST-OF(wtsum.wtagent) THEN DO:
        /**/
            ASSIGN
                nv_agentname = ""
                nv_crper    = 0
                nv_ltamt    = 0
                nv_clicod   = ""
                .
            FIND xmm600 WHERE xmm600.acno = wtsum.wtacno  NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
                ASSIGN
                    nv_agentname = xmm600.name
                    nv_crper    = xmm600.crper
                    nv_ltamt    = xmm600.ltamt
                    nv_clicod   = xmm600.clicod.

                FIND xtm600 WHERE xtm600.acno = wtsum.wtagent  NO-LOCK NO-ERROR.
                IF AVAIL xtm600 THEN nv_agentname = xtm600.name.
                                ELSE nv_agentname = xmm600.name.
            END.

            IF nv_out = TRUE THEN  DO:

                OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        "Agent  : " + wtsum.wtagent + " - " + nv_agentname.
                OUTPUT CLOSE.
    
                ASSIGN
                    nv_agtot_bal    = 0
            
                    nv_agtot_wcr    = 0
                    nv_agtot_damt   = 0
                    nv_agtot_odue   = 0
                    
                    nv_agtot_odue1  = 0
                    nv_agtot_odue2  = 0
                    nv_agtot_odue3  = 0
                    nv_agtot_odue4  = 0
                    nv_agtot_odue5  = 0
                    
                    nv_agtot_gross  = 0
                    nv_agtot_comm   = 0
                    nv_agtot_comm_comp = 0
                    .
            END.    /* nv_out = false */
        
        END.  /* first-of(wtsum.wtagent)*/
            
            /***************** EXPORT DETAIL ***************/

            OUTPUT TO VALUE (STRING(fiFile-Name)  ) APPEND NO-ECHO.
                IF nv_out = TRUE THEN  DO:     /* ออก code acno ด้วย */

                    EXPORT DELIMITER ";"
                        wtsum.wtagent
                        wtsum.wtacno
                        wtsum.wtacname
                        /*STRING(wtsum.wtcredit)*/
                        STRING(wtsum.wtltamt,"->>>,>>>,>>>,>>9.99")
                        wtsum.wtgpstmt
                        
                        wtsum.wtgross
                        wtsum.wtcomm + wtsum.wtcomm_comp
                     
                        wtsum.wtbal
                        wtsum.wtwcr
                        wtsum.wtdamt
                        wtsum.wtodue
        
                        wtsum.wtodue1
                        wtsum.wtodue2
                        wtsum.wtodue3
                        wtsum.wtodue4
                        wtsum.wtodue5
                        /*---A53-0159---*/
                        SUBSTR(wtsum.wtpolgrp,1,3)
                        wtsum.wtgrptyp.

                END.        /* nv_out = false */
                ELSE DO:                    /* ส่งกรม */    
                    EXPORT DELIMITER ";"
                        wtsum.wtagent
                        nv_agentName
                       /* STRING(nv_crper)*/
                        STRING(nv_ltamt,"->>>,>>>,>>>,>>9.99")
                        wtsum.wtgpstmt

                        wtsum.wtgross
                        wtsum.wtcomm + wtsum.wtcomm_comp

                        wtsum.wtbal
                        wtsum.wtwcr
                        wtsum.wtdamt
                        wtsum.wtodue

                        wtsum.wtodue1
                        wtsum.wtodue2
                        wtsum.wtodue3
                        wtsum.wtodue4
                        wtsum.wtodue5
                        /*---A53-0159---*/
                        SUBSTR(wtsum.wtpolgrp,1,3)
                        wtsum.wtgrptyp.
                END.
            OUTPUT CLOSE.
            
            /***************** END EXPORT DETAIL ***************/

               /* SUM BRANCH */
               ASSIGN
                    nv_agtot_gross  = nv_agtot_gross + wtsum.wtgross
                    nv_agtot_comm   = nv_agtot_comm + wtsum.wtcomm
                    nv_agtot_comm_comp   = nv_agtot_comm_comp + wtsum.wtcomm_comp

                    nv_agtot_bal    = nv_agtot_bal + wtsum.wtbal

                    nv_agtot_wcr    = nv_agtot_wcr + wtsum.wtwcr
                    nv_agtot_damt   = nv_agtot_damt + wtsum.wtdamt
                    nv_agtot_odue   = nv_agtot_odue + wtsum.wtodue

                    nv_agtot_odue1  = nv_agtot_odue1 + wtsum.wtodue1
                    nv_agtot_odue2  = nv_agtot_odue2 + wtsum.wtodue2
                    nv_agtot_odue3  = nv_agtot_odue3 + wtsum.wtodue3
                    nv_agtot_odue4  = nv_agtot_odue4 + wtsum.wtodue4
                    nv_agtot_odue5  = nv_agtot_odue5 + wtsum.wtodue5.

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_gross   = nv_gtot_gross + wtsum.wtgross
                    nv_gtot_comm   = nv_gtot_comm + wtsum.wtcomm
                    nv_gtot_comm_comp   = nv_gtot_comm_comp + wtsum.wtcomm_comp
               
                    nv_gtot_bal     = nv_gtot_bal + wtsum.wtbal
                                    
                    nv_gtot_wcr     = nv_gtot_wcr + wtsum.wtwcr
                    nv_gtot_damt    = nv_gtot_damt + wtsum.wtdamt
                    nv_gtot_odue    = nv_gtot_odue + wtsum.wtodue

                    nv_gtot_odue1   = nv_gtot_odue1 + wtsum.wtodue1
                    nv_gtot_odue2   = nv_gtot_odue2 + wtsum.wtodue2
                    nv_gtot_odue3   = nv_gtot_odue3 + wtsum.wtodue3
                    nv_gtot_odue4   = nv_gtot_odue4 + wtsum.wtodue4
                    nv_gtot_odue5   = nv_gtot_odue5 + wtsum.wtodue5.


/********************** Group Footer *********************/    

    IF nv_out = TRUE THEN  DO:
        IF LAST-OF(wtsum.wtagent) THEN DO:
            OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
    
                EXPORT DELIMITER ";"
                    "Total Agent : " + wtsum.wtagent + " - " + nv_agentname
                    "" ""
                    ""
                    ""
                   /* ""*/
                    nv_agtot_gross
                    nv_agtot_comm + nv_agtot_comm_comp

                    nv_agtot_bal
    
                    nv_agtot_wcr
                    nv_agtot_damt
                    nv_agtot_odue
                    
                    nv_agtot_odue1
                    nv_agtot_odue2
                    nv_agtot_odue3
                    nv_agtot_odue4
                    nv_agtot_odue5.
    
                EXPORT DELIMITER ";" "".
    
            OUTPUT CLOSE.

        END.  /* if last-of(wtsum.wtagent)*/

                    vCount = vCount + 1.
    END.    /* nv_out true */

    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.

            IF nv_out = TRUE THEN  DO:     /* ออก code acno ด้วย */
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    "" ""
                    ""
                    ""
                   /* ""*/
                    nv_gtot_gross
                    nv_gtot_comm + nv_gtot_comm_comp
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.

            END.
            ELSE DO:
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    "" 
                    ""
                    ""
                   /* ""*/
                    nv_gtot_gross
                    nv_gtot_comm + nv_gtot_comm_comp
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.
            END.

        OUTPUT CLOSE.
/********************** Page Footer *********************/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAgentOut C-Win 
PROCEDURE pdExpAgentOut :
/*------------------------------------------------------------------------------
  Purpose:     create A47-9999
  Parameters:  <none>
  Notes:       ข้อมูลส่งกรม nv_out  = true 

              RUN pdExpAgentOut.
              RUN pdExpAgentOutFile.
------------------------------------------------------------------------------*/
DEF VAR     vCount      AS INT INIT 0.
DEF VAR     nv_bdes     AS CHAR.

    FOR EACH wtSum : DELETE wtsum. END.

    /*---A53-0159--*/
    nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.
    /*-------------*/

    FOR EACH  agtprm_fil USE-INDEX by_agent    WHERE
              agtprm_fil.asdat    = n_asdat    AND
            (agtprm_fil.agent   >= nv_agent   AND   
              agtprm_fil.agent   <= nv_agent2) AND     /* A47-0500 */
            (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
            (LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )             
    NO-LOCK BREAK   BY agtprm_fil.agent :

            DISP agtprm_fil.polbran
                /*agtprm_fil.acno --- A500178 ---*/
                 agtprm_fil.acno FORMAT "X(10)"
                 agtprm_fil.policy
                 agtprm_fil.trntyp
                 agtprm_fil.docno
            WITH     COLOR BLACK/WHITE NO-LABEL FRAME frProcess3 VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

             IF FIRST-OF(agtprm_fil.agent)  THEN DO:
                ASSIGN
                    nv_tot_bal  = 0
                                
                    nv_tot_wcr  = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0
                    
                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0
                    nv_tot_odue6 = 0
                    nv_tot_odue7 = 0
                    nv_tot_odue8 = 0
                    nv_tot_odue9 = 0
                    
                    nv_tot_gross = 0
                    nv_tot_comm  = 0
                    nv_tot_comm_comp = 0.
                   
             END.

            /********************** SUM DETAIL *********************/    
           
           ASSIGN
               nv_tot_wcr     = nv_tot_wcr   + agtprm_fil.wcr 
               nv_tot_odue1   = nv_tot_odue1 + agtprm_fil.odue1
               nv_tot_odue2   = nv_tot_odue2 + agtprm_fil.odue2
               nv_tot_odue3   = nv_tot_odue3 + agtprm_fil.odue3
               nv_tot_odue4   = nv_tot_odue4 + agtprm_fil.odue4
               nv_tot_odue5   = nv_tot_odue5 + agtprm_fil.odue5.

               /* TOTAL */
                nv_tot_bal     = nv_tot_bal   + agtprm_fil.bal.

                
            ASSIGN
                nv_tot_damt    = nv_tot_damt  + agtprm_fil.damt
                nv_tot_odue    = nv_tot_odue  + agtprm_fil.odue 
               
                nv_tot_wcr     = nv_tot_wcr   + n_wcr
                nv_tot_damt    = nv_tot_damt + n_damt
                nv_tot_odue    = nv_tot_odue  + n_odue 
                
                nv_tot_gross   = nv_tot_gross + agtprm_fil.gross
                nv_tot_comm    = nv_tot_comm  + agtprm_fil.comm
                nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp
                .

             IF LAST-OF(agtprm_fil.agent)  THEN DO:  /**/

                ASSIGN
                    nv_gpstmt = ""
                    nv_gpname = "".
                
                FIND FIRST wtSum USE-INDEX wtSum4 
                                 WHERE  wtsum.wtagent = agtprm_fil.agent NO-ERROR.
                IF NOT AVAIL wtSum THEN DO:
                
                    FIND FIRST xmm600 USE-INDEX xmm60001
                                      WHERE (xmm600.acno = agtprm_fil.agent) NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xmm600 THEN  nv_gpstmt = xmm600.gpstmt.
                
                    CREATE wtSum.
                    ASSIGN
                        wtsum.wtgpstmt  = nv_gpstmt
                        wtsum.wtacno    = agtprm_fil.acno
                        wtsum.wtacname  = agtprm_fil.ac_name
                        wtsum.wtbranch  = agtprm_fil.polbran
                        wtsum.wtcredit  = agtprm_fil.credit
                        wtsum.wtltamt   = agtprm_fil.odue6
                        
                        wtsum.wtbal     = nv_tot_bal
                        wtsum.wtwcr     = nv_tot_wcr
                        wtsum.wtdamt    = nv_tot_damt
                        wtsum.wtodue    = nv_tot_odue
    
                        wtsum.wtodue1   = nv_tot_odue1    
                        wtsum.wtodue2   = nv_tot_odue2    
                        wtsum.wtodue3   = nv_tot_odue3    
                        wtsum.wtodue4   = nv_tot_odue4    
                        wtsum.wtodue5   = nv_tot_odue5    
                        wtsum.wtodue6   = nv_tot_odue6    
                        wtsum.wtodue7   = nv_tot_odue7    
                        wtsum.wtodue8   = nv_tot_odue8    
                        wtsum.wtodue9   = nv_tot_odue9 
                        
                        wtsum.wtagent   = agtprm_fil.agent
                        wtsum.wtgross   = nv_tot_gross
                        wtsum.wtcomm    = nv_tot_comm
                        wtsum.wtcomm_comp = nv_tot_comm_comp
                        .

                END.  /* if not avail wtSum  - create*/
                ELSE ASSIGN 
                        wtsum.wtbal     = nv_tot_bal
                        wtsum.wtwcr     = nv_tot_wcr
                        wtsum.wtdamt    = nv_tot_damt
                        wtsum.wtodue    = nv_tot_odue
    
                        wtsum.wtodue1   = nv_tot_odue1    
                        wtsum.wtodue2   = nv_tot_odue2    
                        wtsum.wtodue3   = nv_tot_odue3    
                        wtsum.wtodue4   = nv_tot_odue4    
                        wtsum.wtodue5   = nv_tot_odue5    
                        wtsum.wtodue6   = nv_tot_odue6    
                        wtsum.wtodue7   = nv_tot_odue7    
                        wtsum.wtodue8   = nv_tot_odue8    
                        wtsum.wtodue9   = nv_tot_odue9 
                        wtsum.wtgross   = nv_tot_gross
                        wtsum.wtcomm    = nv_tot_comm
                        wtsum.wtcomm_comp = nv_tot_comm_comp
                        .
               
             END. /* IF LAST-OF(agtprm_fil.acno)  */

    END. /* for each agtprm_fil*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAgentOutFile C-Win 
PROCEDURE pdExpAgentOutFile :
/*------------------------------------------------------------------------------
  Purpose:     create A47-0035
  Parameters:  <none>
  Notes:       nv_out = true  เฉพาะ Agent เท่านั้น  ไม่เอา column acno
               nv_out = false  มี agent  acno ด้วย 
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_agentname AS CHAR.
DEF VAR nv_fileH AS CHAR.
DEF VAR nv_crper    AS DECI.
DEF VAR nv_ltamt    AS DECI.
DEF VAR nv_clicod   AS CHAR.

    ASSIGN
        nv_gtot_bal     = 0
        
        nv_gtot_wcr     = 0
        nv_gtot_damt    = 0
        nv_gtot_odue    = 0
        
        nv_gtot_odue1   = 0
        nv_gtot_odue2   = 0
        nv_gtot_odue3   = 0
        nv_gtot_odue4   = 0
        nv_gtot_odue5   = 0
        
        nv_gtot_gross   = 0
        nv_gtot_comm    = 0
        nv_gtot_comm_comp = 0
        .

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(fiFile-Name)  ) NO-ECHO.
        IF vCount = 0 THEN DO:

            IF nv_out = FALSE  THEN DO:
                EXPORT DELIMITER ";"
                    "Asdate : " +  STRING(n_asdat,"99/99/9999")
                    ""
                    "wacr03.w - STATEMENT A4 SUMMARY BY AGENT"  /* "Statement A4 Reports By Agent"  */
                    "" "" "" "" ""
                    "Include Type : " +  nv_trntyp1 
    
                    /* A47-0500 */
                    "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    ""
                    "Agent : " + nv_agent + " - " + nv_agent2
                    .

                EXPORT DELIMITER ";"
                    "Agent" "Account No."
                    "Name"   "Credit Limit"  "Group Statement"  "Gross" "Comm + Comm_comp"  " Balance Due"
                    "Within"  "Due Amount "  "Overdue"  
                    /*---A53-0159---
                    "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                    ---------------*/
                    "1 - 15 days"  "16 - 30 days"  "31 - 45 days" "46 - 60 days"  "61 - 90 days" 
                    "91 - 180 days"  "181 - 270 days"  " 271 - 365 days"  "Over 365 days". 

            END.
            /*
            ELSE DO: 
                EXPORT DELIMITER ";"
                    "Asdate : " +  STRING(n_asdat,"99/99/9999")
                    ""
                    "wacr03.w - STATEMENT A4 SUMMARY BY AGENT ส่งกรม "  /* "Statement A4 Reports By Agent ส่งกรม"  */
                    "" "" "" "" ""
                    "Include Type : " +  nv_trntyp1 
    
                    /* A47-0500 */
                    "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    ""
                    "Agent : " + nv_agent + " - " + nv_agent2

                    .

                EXPORT DELIMITER ";"
                    "Agent"
                    "Name"  "Credit"  "Credit Limit"  "Group Statement"  "Gross" "Comm"  " Balance Due"
                    "Within"  "Due Amount "  "Overdue"  
                    "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                   
                    
            END.
            */

        END.
    OUTPUT CLOSE.

/********************** END Page Header *********************/  

    FOR EACH wtSum USE-INDEX wtSum4 BREAK BY wtSum.wtagent :

/********************** Group Header *********************/
        IF FIRST-OF(wtsum.wtagent) THEN DO:
        /**/
            ASSIGN
                nv_agentname = ""
                nv_crper    = 0
                nv_ltamt    = 0
                nv_clicod   = ""
                .
            FIND xmm600 WHERE xmm600.acno = wtsum.wtagent  NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
                ASSIGN
                    nv_agentname = xmm600.name
                    nv_crper    = xmm600.crper
                    nv_ltamt    = xmm600.ltamt
                    nv_clicod   = xmm600.clicod.

                FIND xtm600 WHERE xtm600.acno = wtsum.wtagent  NO-LOCK NO-ERROR.
                IF AVAIL xtm600 THEN nv_agentname = xtm600.name.
                                ELSE nv_agentname = xmm600.name.
            END.

            IF nv_out = FALSE THEN  DO:

                OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        "Agent  : " + wtsum.wtagent + " - " + nv_agentname.
                OUTPUT CLOSE.
    
                ASSIGN
                    nv_agtot_bal    = 0
            
                    nv_agtot_wcr    = 0
                    nv_agtot_damt   = 0
                    nv_agtot_odue   = 0
                    
                    nv_agtot_odue1  = 0
                    nv_agtot_odue2  = 0
                    nv_agtot_odue3  = 0
                    nv_agtot_odue4  = 0
                    nv_agtot_odue5  = 0
                    nv_agtot_odue6  = 0
                    nv_agtot_odue7  = 0
                    nv_agtot_odue8  = 0
                    nv_agtot_odue9  = 0
                    
                    nv_agtot_gross  = 0
                    nv_agtot_comm   = 0
                    nv_agtot_comm_comp = 0
                    .
            END.    /* nv_out = false */
        
        END.  /* first-of(wtsum.wtagent)*/
            
            /***************** EXPORT DETAIL ***************/

            OUTPUT TO VALUE (STRING(fiFile-Name)  ) APPEND NO-ECHO.
                IF nv_out = FALSE THEN  DO:     /* ออก code acno ด้วย */

                    EXPORT DELIMITER ";"
                        wtsum.wtagent
                        wtsum.wtacno
                        wtsum.wtacname
                       /* STRING(wtsum.wtcredit)*/
                        STRING(wtsum.wtltamt,"->>>,>>>,>>>,>>9.99")
                        wtsum.wtgpstmt
                        
                        wtsum.wtgross
                        wtsum.wtcomm + wtsum.wtcomm_comp
                     
                        wtsum.wtbal
                        wtsum.wtwcr
                        wtsum.wtdamt
                        wtsum.wtodue
        
                        wtsum.wtodue1
                        wtsum.wtodue2
                        wtsum.wtodue3
                        wtsum.wtodue4
                        wtsum.wtodue5
                        wtsum.wtodue6
                        wtsum.wtodue7
                        wtsum.wtodue8
                        wtsum.wtodue9
                        SUBSTR(wtsum.wtpolgrp,1,3) 
                        wtsum.wtgrptyp .    
                END.    /* nv_out = false */
                ELSE DO:                    /* ส่งกรม */    
                    EXPORT DELIMITER ";"
                        wtsum.wtagent
                        nv_agentName
                       /* STRING(nv_crper)*/
                        STRING(nv_ltamt,"->>>,>>>,>>>,>>9.99")
                        wtsum.wtgpstmt

                        wtsum.wtgross
                        wtsum.wtcomm + wtsum.wtcomm_comp

                        wtsum.wtbal
                        wtsum.wtwcr
                        wtsum.wtdamt
                        wtsum.wtodue

                        wtsum.wtodue1
                        wtsum.wtodue2
                        wtsum.wtodue3
                        wtsum.wtodue4
                        wtsum.wtodue5
                        wtsum.wtodue6
                        wtsum.wtodue7
                        wtsum.wtodue8
                        wtsum.wtodue9.
                        
                END.
            OUTPUT CLOSE.
            
            /***************** END EXPORT DETAIL ***************/

               /* SUM BRANCH */
               ASSIGN
                    nv_agtot_gross      = nv_agtot_gross + wtsum.wtgross
                    nv_agtot_comm       = nv_agtot_comm + wtsum.wtcomm
                    nv_agtot_comm_comp  = nv_agtot_comm_comp + wtsum.wtcomm_comp

                    nv_agtot_bal        = nv_agtot_bal + wtsum.wtbal

                    nv_agtot_wcr        = nv_agtot_wcr + wtsum.wtwcr
                    nv_agtot_damt       = nv_agtot_damt + wtsum.wtdamt
                    nv_agtot_odue       = nv_agtot_odue + wtsum.wtodue
                                        
                    nv_agtot_odue1      = nv_agtot_odue1 + wtsum.wtodue1
                    nv_agtot_odue2      = nv_agtot_odue2 + wtsum.wtodue2
                    nv_agtot_odue3      = nv_agtot_odue3 + wtsum.wtodue3
                    nv_agtot_odue4      = nv_agtot_odue4 + wtsum.wtodue4
                    nv_agtot_odue5      = nv_agtot_odue5 + wtsum.wtodue5
                    nv_agtot_odue6      = nv_agtot_odue6 + wtsum.wtodue6
                    nv_agtot_odue7      = nv_agtot_odue7 + wtsum.wtodue7
                    nv_agtot_odue8      = nv_agtot_odue8 + wtsum.wtodue8
                    nv_agtot_odue9      = nv_agtot_odue9 + wtsum.wtodue9.
                   
             /* SUM BRANCH */

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_gross   = nv_gtot_gross + wtsum.wtgross
                    nv_gtot_comm   = nv_gtot_comm + wtsum.wtcomm
                    nv_gtot_comm_comp   = nv_gtot_comm_comp + wtsum.wtcomm_comp
               
                    nv_gtot_bal     = nv_gtot_bal + wtsum.wtbal
                                    
                    nv_gtot_wcr     = nv_gtot_wcr + wtsum.wtwcr
                    nv_gtot_damt    = nv_gtot_damt + wtsum.wtdamt
                    nv_gtot_odue    = nv_gtot_odue + wtsum.wtodue

                    nv_gtot_odue1   = nv_gtot_odue1 + wtsum.wtodue1
                    nv_gtot_odue2   = nv_gtot_odue2 + wtsum.wtodue2
                    nv_gtot_odue3   = nv_gtot_odue3 + wtsum.wtodue3
                    nv_gtot_odue4   = nv_gtot_odue4 + wtsum.wtodue4
                    nv_gtot_odue5   = nv_gtot_odue5 + wtsum.wtodue5
                    nv_gtot_odue6   = nv_gtot_odue6 + wtsum.wtodue6
                    nv_gtot_odue7   = nv_gtot_odue7 + wtsum.wtodue7
                    nv_gtot_odue8   = nv_gtot_odue8 + wtsum.wtodue8
                    nv_gtot_odue9   = nv_gtot_odue9 + wtsum.wtodue9.


/********************** Group Footer *********************/    

    IF nv_out = FALSE THEN  DO:
        IF LAST-OF(wtsum.wtagent) THEN DO:
            OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
    
                EXPORT DELIMITER ";"
                    "Total Agent : " + wtsum.wtagent + " - " + nv_agentname
                    "" ""
                    ""
                    ""
                   /* ""*/
                    nv_agtot_gross
                    nv_agtot_comm + nv_agtot_comm_comp

                    nv_agtot_bal
    
                    nv_agtot_wcr
                    nv_agtot_damt
                    nv_agtot_odue
                    
                    nv_agtot_odue1
                    nv_agtot_odue2
                    nv_agtot_odue3
                    nv_agtot_odue4
                    nv_agtot_odue5
                    nv_agtot_odue6
                    nv_agtot_odue7
                    nv_agtot_odue8
                    nv_agtot_odue9.
    
                EXPORT DELIMITER ";" "".
    
            OUTPUT CLOSE.
             ASSIGN
                    nv_agtot_bal    = 0
            
                    nv_agtot_wcr    = 0
                    nv_agtot_damt   = 0
                    nv_agtot_odue   = 0
                    
                    nv_agtot_odue1  = 0
                    nv_agtot_odue2  = 0
                    nv_agtot_odue3  = 0
                    nv_agtot_odue4  = 0
                    nv_agtot_odue5  = 0
                    nv_agtot_odue6  = 0
                    nv_agtot_odue7  = 0
                    nv_agtot_odue8  = 0
                    nv_agtot_odue9  = 0
                    
                    nv_agtot_gross  = 0
                    nv_agtot_comm   = 0
                    nv_agtot_comm_comp = 0
                    .

        END.  /* if last-of(wtsum.wtagent)*/

                    vCount = vCount + 1.
    END.    /* nv_out true */

    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.

            IF nv_out = FALSE THEN  DO:     /* ออก code acno ด้วย */
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    "" ""
                    ""
                    ""
                    /*""*/
                    nv_gtot_gross
                    nv_gtot_comm + nv_gtot_comm_comp
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5
                    nv_gtot_odue6
                    nv_gtot_odue7
                    nv_gtot_odue8
                    nv_gtot_odue9.

            END.
            ELSE DO:
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    "" 
                    ""
                    ""
                    /*""*/
                    nv_gtot_gross
                    nv_gtot_comm + nv_gtot_comm_comp
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5
                    nv_gtot_odue6
                    nv_gtot_odue7
                    nv_gtot_odue8
                    nv_gtot_odue9.
            END.

        OUTPUT CLOSE.
/********************** Page Footer *********************/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpAgentProcess C-Win 
PROCEDURE pdExpAgentProcess :
/*------------------------------------------------------------------------------
  Purpose:     create A47-0035
  Parameters:  <none>
  Notes:       ไม่ส่งกรมฯ - แสดงคอลัมน์ Agent & Acno ใช้เงื่อนไข CBC (A53-0159)
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.

FOR EACH wtSum:
     DELETE wtsum. 
END.

/*---A53-0159---*/
nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
    mday = 15.   /*A55-0234*/
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
    mday = 0.  /*A55-0231*/
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.
/*---A53-0159---*/

FOR EACH  agtprm_fil USE-INDEX by_agent       WHERE
          agtprm_fil.asdat       = n_asdat    AND
         (agtprm_fil.agent      >= nv_agent   AND   
          agtprm_fil.agent      <= nv_agent2) AND     /* A47-0500 */
          (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
         (LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )             
NO-LOCK BREAK BY agtprm_fil.agent                     /* A47-0500 */
              BY agtprm_fil.acno :

        DISP agtprm_fil.polbran
             /*agtprm_fil.acno --- A500178 ---*/
             agtprm_fil.acno FORMAT "X(10)"
             agtprm_fil.policy
             agtprm_fil.trntyp
             agtprm_fil.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess3 VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
        IF rstype = 3 THEN RUN pdmDay.

        IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /* first-of  ของ acno  ทุกรายการใน Agent  บาง acno จะเข้าไปอยู่ในหลาย Agent */
        ASSIGN
            nv_tot_bal  = 0
            nv_tot_wcr  = 0
            nv_tot_damt = 0
            nv_tot_odue = 0
            nv_tot_odue1 = 0
            nv_tot_odue2 = 0
            nv_tot_odue3 = 0
            nv_tot_odue4 = 0
            nv_tot_odue5 = 0
            nv_tot_odue6 = 0
            nv_tot_odue7 = 0
            nv_tot_odue8 = 0
            nv_tot_odue9 = 0
            nv_tot_gross = 0
            nv_tot_comm  = 0
            nv_tot_comm_comp = 0.
           /*---A55-0231---*/
            ASSIGN n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0.
            /*--------------*/
        END.

        /********************** SUM DETAIL *********************/ 
        /*-----A53-0159---
        ASSIGN
        /* TOTAL */
            nv_tot_bal     = nv_tot_bal + agtprm_fil.bal

            nv_tot_wcr     = nv_tot_wcr + agtprm_fil.wcr
            nv_tot_damt    = nv_tot_damt + agtprm_fil.damt
            nv_tot_odue    = nv_tot_odue + agtprm_fil.odue

            nv_tot_odue1   = nv_tot_odue1 + agtprm_fil.odue1
            nv_tot_odue2   = nv_tot_odue2 + agtprm_fil.odue2
            nv_tot_odue3   = nv_tot_odue3 + agtprm_fil.odue3
            nv_tot_odue4   = nv_tot_odue4 + agtprm_fil.odue4
            nv_tot_odue5   = nv_tot_odue5 + agtprm_fil.odue5
                                       
            nv_tot_gross   = nv_tot_gross + agtprm_fil.gross
            nv_tot_comm    = nv_tot_comm  + agtprm_fil.comm
            nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp
            .
            --------------*/

            /* TOTAL */
            RUN pdCalComdat.
                
            ASSIGN

            /*---A53-0159---
            nv_tot_damt    = nv_tot_damt  + agtprm_fil.damt*/
            /*nv_tot_odue    = nv_tot_odue  + agtprm_fil.odue 
            nv_tot_wcr     = nv_tot_wcr   + n_wcr
            nv_tot_damt    = nv_tot_damt + n_damt
            nv_tot_odue    = nv_tot_odue  + n_odue 
            ---A53-0159--*/
            
            nv_tot_bal     = nv_tot_bal   + agtprm_fil.bal
            nv_tot_gross   = nv_tot_gross + agtprm_fil.gross
            nv_tot_comm    = nv_tot_comm  + agtprm_fil.comm
            nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp
            .
           
            /*---A53-0159---*/
            ASSIGN n_odue1 = 0
                   n_odue2 = 0
                   n_odue3 = 0 
                   n_odue4 = 0
                   n_odue5 = 0
                   n_odue6 = 0
                   n_odue7 = 0 
                   n_odue8 = 0
                   n_odue9 = 0
                   n_wcr   = 0
                   n_damt  = 0
                   .
                /*-------------------*/

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN nv_dir = ""
                       nv_polgrp = ""
                       nv_grptypdes = "".

                RUN pdDeptGrp.

                ASSIGN
                    nv_gpstmt = ""
                    nv_gpname = "".
                
                FIND FIRST wtSum USE-INDEX wtSum4 
                                 WHERE  wtsum.wtagent = agtprm_fil.acno AND
                                        wtsum.wtacno  = agtprm_fil.agent 
                                 NO-ERROR.     /* A47-0500 */
                IF NOT AVAIL wtSum THEN DO:
                
                    FIND FIRST xmm600 USE-INDEX xmm60001
                                      WHERE (xmm600.acno = agtprm_fil.acno) NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xmm600 THEN  nv_gpstmt = xmm600.gpstmt.
                
                    CREATE wtSum.
                    ASSIGN
                        wtsum.wtgpstmt  = nv_gpstmt
                        wtsum.wtacno    = agtprm_fil.acno
                        wtsum.wtacname  = agtprm_fil.ac_name
                        wtsum.wtbranch  = agtprm_fil.polbran
                        wtsum.wtcredit  = agtprm_fil.credit
                        wtsum.wtltamt   = agtprm_fil.odue6
                        
                        wtsum.wtbal     = nv_tot_bal
                        wtsum.wtwcr     = nv_tot_wcr
                        wtsum.wtdamt    = nv_tot_damt
                        wtsum.wtodue    = nv_tot_odue
    
                        wtsum.wtodue1   = nv_tot_odue1
                        wtsum.wtodue2   = nv_tot_odue2
                        wtsum.wtodue3   = nv_tot_odue3
                        wtsum.wtodue4   = nv_tot_odue4
                        wtsum.wtodue5   = nv_tot_odue5
                        wtsum.wtodue6   = nv_tot_odue6
                        wtsum.wtodue7   = nv_tot_odue7
                        wtsum.wtodue8   = nv_tot_odue8
                        wtsum.wtodue9   = nv_tot_odue9
                        
                        wtsum.wtagent   = agtprm_fil.agent
                        wtsum.wtgross   = nv_tot_gross
                        wtsum.wtcomm    = nv_tot_comm
                        wtsum.wtcomm_comp = nv_tot_comm_comp
                        /*---A53-0159---*/
                        wtsum.wtgrptyp    = SUBSTR(nv_dir,3,1)    /*   P, C , Non    */
                        wtsum.wtpolgrp    = nv_polgrp.              /*   MOTDiC, MOTDiP, MOTBrC, MOTBrP, MOTCOC NON      */ 

                END.  /* if not avail wtSum  - create*/

                ASSIGN
                      nv_tot_bal  = 0
                      nv_tot_wcr  = 0
                      nv_tot_damt = 0
                      nv_tot_odue = 0
                      nv_tot_odue1 = 0
                      nv_tot_odue2 = 0
                      nv_tot_odue3 = 0
                      nv_tot_odue4 = 0
                      nv_tot_odue5 = 0
                      nv_tot_odue6 = 0
                      nv_tot_odue7 = 0
                      nv_tot_odue8 = 0
                      nv_tot_odue9 = 0
                      nv_tot_gross = 0
                      nv_tot_comm  = 0
                      nv_tot_comm_comp = 0.

             END. /* IF LAST-OF(agtprm_fil.acno)  */

    END. /* for each agtprm_fil*/


/*     output to d:\temp\wtsumag.txt   .                                                                                 */
/*          EXPORT  DELIMITER ";"                                                                                        */
/*              "wtgstmt"  "wtacno" "wtagent" "wtacname" "wtbranch" "wtcredit"   "wtltamt"  "wtbal"  "wtdamt"  "wtodue"  */
/*                "wtodue1"   "wtodue2"   "wtodue3"    "wtodue4"    "wtodue5"     "wtgross"   "wtcomm"    "wtcomm_comp". */
/*                                                                                                                       */
/*          for each wtsum:                                                                                              */
/*              export delimiter ";" wtsum.                                                                              */
/*                                                                                                                       */
/*          end.                                                                                                         */
/*      output close.                                                                                                    */


END PROCEDURE.


/*        DISP STRING(rsOutput) + "  " + agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " + */
/*                   agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .                                                  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpBr C-Win 
PROCEDURE pdExpBr :
/*------------------------------------------------------------------------------
  Purpose:     A47-0014  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_fileH AS CHAR.

    ASSIGN
        nv_gtot_bal = 0
        
        nv_gtot_wcr = 0
        nv_gtot_damt = 0
        nv_gtot_odue = 0
        
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0
        /*---A53-0159---*/
        nv_gtot_odue6 = 0
        nv_gtot_odue7 = 0
        nv_gtot_odue8 = 0
        nv_gtot_odue9 = 0
        /*--------------*/
        
        nv_fileH = STRING(fiFile-Name) + "H" .

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(nv_fileH)  ) NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Asdate : " +  STRING(n_asdat,"99/99/9999")
                ""
                "wacr03.w - STATEMENT A4 SUMMARY BY BRANCH"  /* "Statement A4 Reports By Acno"  */
                "" "" "" "" ""
                "Include Type : " +  nv_trntyp1
                /* A47-0500 */
                "" ""
                "Branch : " + n_branch + " - " + n_branch2
                .

            EXPORT DELIMITER ";"
                "Branch" 
                "Client Type Code"           /*note add*/
                "Group Statement"
                "Account No." "Name"  "Credit Limit" " Balance Due"
                "Within"  "Due Amount "  "Overdue"  
                /*---A53-0159---
                "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                ----------------*/
                "1 - 15 days"  "16 - 30 days"  "31 - 45 days" "46 - 60 days"  "61 - 90 days" 
                "91 - 180 days"  "181 - 270 days"  " 271 - 365 days"  "Over 365 days". 

        END.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (STRING(fiFile-Name)  ) NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Branch" 
                "Client Type Code"            /*Note Add*/
                "Group Statement"
                "Account No." "Name"    "Credit Limit" " Balance Due"
                "Within"  "Due Amount "  "Overdue"  
                /*---A53-0159---
                "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                ----------------*/
                "1 - 15 days"  "16 - 30 days"  "31 - 45 days" "46 - 60 days"  "61 - 90 days" 
                "91 - 180 days"  "181 - 270 days"  " 271 - 365 days"  "Over 365 days". 
        END.
    OUTPUT CLOSE.
/********************** END Page Header *********************/  

    FOR EACH wtSum USE-INDEX wtSum2 BREAK BY wtSum.wtbran :
                                          /*BY wtsum.clientco  :*/
                                          

/********************** Group Header *********************/
        IF FIRST-OF(wtsum.wtbran) THEN DO:
        /**/
            nv_bdes = "".
            FIND xmm023 WHERE xmm023.branch = wtsum.wtbran  NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN nv_bdes = xmm023.bdes.

            OUTPUT TO VALUE (STRING(nv_fileH) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "Branch  : " + wtsum.wtbran + " - " + nv_bdes.
            OUTPUT CLOSE.

            ASSIGN
                nv_brtot_bal = 0
        
                nv_brtot_wcr = 0
                nv_brtot_damt = 0
                nv_brtot_odue = 0
                
                nv_brtot_odue1 = 0
                nv_brtot_odue2 = 0
                nv_brtot_odue3 = 0
                nv_brtot_odue4 = 0
                nv_brtot_odue5 = 0
                nv_brtot_odue6 = 0
                nv_brtot_odue7 = 0
                nv_brtot_odue8 = 0
                nv_brtot_odue9 = 0.
        
        END.  /* first-of(wtsum.wtbran)*/
            
            /***************** EXPORT DETAIL ***************/
            OUTPUT TO VALUE (STRING(nv_fileH) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    wtsum.wtbran
                    wtsum.clientco           /*note add ja*/
                    wtsum.wtgpstmt
                    wtsum.wtacno
                    wtsum.wtacname
                   /* STRING(wtsum.wtcredit)*/
                    STRING(wtsum.wtltamt,"->>>,>>>,>>>,>>9.99")
                    
                    wtsum.wtbal
                    wtsum.wtwcr
                    wtsum.wtdamt
                    wtsum.wtodue
    
                    wtsum.wtodue1
                    wtsum.wtodue2
                    wtsum.wtodue3
                    wtsum.wtodue4
                    wtsum.wtodue5
                    wtsum.wtodue6
                    wtsum.wtodue7
                    wtsum.wtodue8
                    wtsum.wtodue9.
                    /*---A53-0159---
                    SUBSTR(wtsum.wtpolgrp,1,3)
                    wtsum.wtgrptyp.
                    -------*/

            OUTPUT CLOSE. 
            
            OUTPUT TO VALUE (STRING(fiFile-Name)  ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    wtsum.wtbran
                    wtsum.clientco           /*note add ja*/
                    wtsum.wtgpstmt
                    wtsum.wtacno
                    wtsum.wtacname
                  /*  STRING(wtsum.wtcredit)*/
                    STRING(wtsum.wtltamt,"->>>,>>>,>>>,>>9.99")
                    
                    wtsum.wtbal
                    wtsum.wtwcr
                    wtsum.wtdamt
                    wtsum.wtodue
    
                    wtsum.wtodue1
                    wtsum.wtodue2
                    wtsum.wtodue3
                    wtsum.wtodue4
                    wtsum.wtodue5
                    wtsum.wtodue6
                    wtsum.wtodue7
                    wtsum.wtodue8
                    wtsum.wtodue9.

                    /*---A53-0159---
                    SUBSTR(wtsum.wtpolgrp,1,3)
                    wtsum.wtgrptyp.
                    -----*/
            OUTPUT CLOSE.
            
            /***************** END EXPORT DETAIL ***************/

               /* SUM BRANCH */
               ASSIGN
                    nv_brtot_bal        = nv_brtot_bal + wtsum.wtbal

                    nv_brtot_wcr        = nv_brtot_wcr + wtsum.wtwcr
                    nv_brtot_damt     = nv_brtot_damt + wtsum.wtdamt
                    nv_brtot_odue     = nv_brtot_odue + wtsum.wtodue

                    nv_brtot_odue1   = nv_brtot_odue1 + wtsum.wtodue1
                    nv_brtot_odue2   = nv_brtot_odue2 + wtsum.wtodue2
                    nv_brtot_odue3   = nv_brtot_odue3 + wtsum.wtodue3
                    nv_brtot_odue4   = nv_brtot_odue4 + wtsum.wtodue4
                    nv_brtot_odue5   = nv_brtot_odue5 + wtsum.wtodue5
                    nv_brtot_odue6   = nv_brtot_odue6 + wtsum.wtodue6
                    nv_brtot_odue7   = nv_brtot_odue7 + wtsum.wtodue7
                    nv_brtot_odue8   = nv_brtot_odue8 + wtsum.wtodue8
                    nv_brtot_odue9   = nv_brtot_odue9 + wtsum.wtodue9.
                   /*--------------*/

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_bal        = nv_gtot_bal + wtsum.wtbal

                    nv_gtot_wcr        = nv_gtot_wcr + wtsum.wtwcr
                    nv_gtot_damt     = nv_gtot_damt + wtsum.wtdamt
                    nv_gtot_odue     = nv_gtot_odue + wtsum.wtodue

                    nv_gtot_odue1   = nv_gtot_odue1 + wtsum.wtodue1
                    nv_gtot_odue2   = nv_gtot_odue2 + wtsum.wtodue2
                    nv_gtot_odue3   = nv_gtot_odue3 + wtsum.wtodue3
                    nv_gtot_odue4   = nv_gtot_odue4 + wtsum.wtodue4
                    nv_gtot_odue5   = nv_gtot_odue5 + wtsum.wtodue5
                    nv_gtot_odue6   = nv_gtot_odue6 + wtsum.wtodue6
                    nv_gtot_odue7   = nv_gtot_odue7 + wtsum.wtodue7
                    nv_gtot_odue8   = nv_gtot_odue8 + wtsum.wtodue8
                    nv_gtot_odue9   = nv_gtot_odue9 + wtsum.wtodue9.


/********************** Group Footer *********************/    

        IF LAST-OF(wtsum.wtbran) THEN DO:
            OUTPUT TO VALUE (STRING(nv_fileH) ) APPEND NO-ECHO.
    
                EXPORT DELIMITER ";"
                    "Total Branch  : " + wtsum.wtbran + " - " + nv_bdes
    
                    "" ""
                    ""            /*Note add column ja*/
                    ""
                    ""
                  /* ""*/
                    nv_brtot_bal
    
                    nv_brtot_wcr
                    nv_brtot_damt
                    nv_brtot_odue
                    
                    nv_brtot_odue1
                    nv_brtot_odue2
                    nv_brtot_odue3
                    nv_brtot_odue4
                    nv_brtot_odue5
                    nv_brtot_odue6
                    nv_brtot_odue7
                    nv_brtot_odue8
                    nv_brtot_odue9.
    
                EXPORT DELIMITER ";" "".
    
            OUTPUT CLOSE.

        END.  /* if last-of(wtsum.wtbran)*/

                    vCount = vCount + 1.


    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(nv_fileH) ) APPEND NO-ECHO.

                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    "" ""
                    ""            /*Note add column ja*/
                    ""
                    ""
                   /* ""*/
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5
                    nv_gtot_odue6
                    nv_gtot_odue7
                    nv_gtot_odue8
                    nv_gtot_odue9.

        OUTPUT CLOSE.
/********************** Page Footer *********************/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpBrA470014 C-Win 
PROCEDURE pdExpBrA470014 :
/*-------------- comment  A47-0014 
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.

    ASSIGN
        nv_gtot_bal = 0
        
        nv_gtot_wcr = 0
        nv_gtot_damt = 0
        nv_gtot_odue = 0
        
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0.

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Asdate : " +  STRING(n_asdat,"99/99/9999")
                ""
                "wacr03.w - Check List Statement to Excel By Branch"  /* "Statement A4 Reports By Acno"  */
                "" "" "" "" ""
                "Include Type : " +  nv_trntyp1.


            EXPORT DELIMITER ";"
                "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วงเงินเครดิต" "รวมยอดค้างชำระ" 
                "ยอดไม่ครบกำหนด" "ครบกำหนด" "รวมยอดค้างชำระเกินกำหนด" "ค้าง 1-3 เดือน "  "ค้าง 3-6 เดือน"  "ค้าง 6-9 เดือน"   "ค้าง 9-12 เดือน"  "ค้าง เกิน 12 เดือน".

            EXPORT DELIMITER ";"
                 "Account No." "Name"  "Credit"  "Credit Limit" " Balance Due"
                 "Within"  "Due Amount "  "Overdue"  "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 

        END.
    OUTPUT CLOSE.
/********************** END Page Header *********************/  

    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat       = n_asdat   AND
             (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK BY agtprm_fil.polbran BY agtprm_fil.acno .

       DISP STRING(rsOutput) + "  " + agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                  agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

/********************** Group Header *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
            IF FIRST-OF(agtprm_fil.polbran) THEN DO:
            /**/
                nv_bdes = "".
                FIND xmm023 WHERE xmm023.branch = agtprm_fil.polbran  NO-LOCK NO-ERROR.
                IF AVAIL xmm023 THEN nv_bdes = xmm023.bdes.
                
                EXPORT DELIMITER ";"
                    "Branch  : " + agtprm_fil.polbran + " - " + nv_bdes.

                ASSIGN
                    nv_brtot_bal = 0

                    nv_brtot_wcr = 0
                    nv_brtot_damt = 0
                    nv_brtot_odue = 0
                    
                    nv_brtot_odue1 = 0
                    nv_brtot_odue2 = 0
                    nv_brtot_odue3 = 0
                    nv_brtot_odue4 = 0
                    nv_brtot_odue5 = 0.

            END.
            
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN
                    nv_tot_bal = 0

                    nv_tot_wcr = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0
                    
                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0.
             END.

/********************** SUM DETAIL *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_bal                = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr          = nv_tot_wcr + agtprm_fil.wcr
                    nv_tot_damt       = nv_tot_damt + agtprm_fil.damt
                    nv_tot_odue     = nv_tot_odue + agtprm_fil.odue

                    nv_tot_odue1     = nv_tot_odue1 + agtprm_fil.odue1
                    nv_tot_odue2      = nv_tot_odue2 + agtprm_fil.odue2
                    nv_tot_odue3      = nv_tot_odue3 + agtprm_fil.odue3
                    nv_tot_odue4     = nv_tot_odue4 + agtprm_fil.odue4
                    nv_tot_odue5     = nv_tot_odue5 + agtprm_fil.odue5.
                    

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    STRING(agtprm_fil.credit)
                    STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")
                    
                    nv_tot_bal

                    nv_tot_wcr
                    nv_tot_damt
                    nv_tot_odue

                    nv_tot_odue1
                    nv_tot_odue2
                    nv_tot_odue3
                    nv_tot_odue4
                    nv_tot_odue5.

               /* SUM BRANCH */
               ASSIGN
                    nv_brtot_bal        = nv_brtot_bal + nv_tot_bal

                    nv_brtot_wcr        = nv_brtot_wcr + nv_tot_wcr
                    nv_brtot_damt     = nv_brtot_damt + nv_tot_damt
                    nv_brtot_odue     = nv_brtot_odue + nv_tot_odue

                    nv_brtot_odue1     = nv_brtot_odue1 + nv_tot_odue1
                    nv_brtot_odue2      = nv_brtot_odue2 + nv_tot_odue2
                    nv_brtot_odue3      = nv_brtot_odue3 + nv_tot_odue3
                    nv_brtot_odue4     = nv_brtot_odue4 + nv_tot_odue4
                    nv_brtot_odue5     = nv_brtot_odue5 + nv_tot_odue5.

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_bal        = nv_gtot_bal + nv_tot_bal

                    nv_gtot_wcr        = nv_gtot_wcr + nv_tot_wcr
                    nv_gtot_damt     = nv_gtot_damt + nv_tot_damt
                    nv_gtot_odue     = nv_gtot_odue + nv_tot_odue

                    nv_gtot_odue1     = nv_gtot_odue1 + nv_tot_odue1
                    nv_gtot_odue2      = nv_gtot_odue2 + nv_tot_odue2
                    nv_gtot_odue3      = nv_gtot_odue3 + nv_tot_odue3
                    nv_gtot_odue4     = nv_gtot_odue4 + nv_tot_odue4
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5.

             END.

/********************** Group Footer *********************/    
            IF LAST-OF(agtprm_fil.polbran) THEN DO:
                EXPORT DELIMITER ";"
                    "Total Branch  : " + agtprm_fil.polbran + " - " + nv_bdes
                    
                    ""
                    ""
                    ""
                    nv_brtot_bal

                    nv_brtot_wcr
                    nv_brtot_damt
                    nv_brtot_odue
                    
                    nv_brtot_odue1
                    nv_brtot_odue2
                    nv_brtot_odue3
                    nv_brtot_odue4
                    nv_brtot_odue5.

            END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.


    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    ""     ""     ""
                    nv_gtot_bal

                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.

        OUTPUT CLOSE.
/********************** Page Footer *********************/

END A47-0014 ---------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpBrCBC C-Win 
PROCEDURE pdExpBrCBC :
/*------------------------------------------------------------------------------
  Purpose:     A47-0014  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_fileC AS CHAR.
/* TOTAL */
DEF  VAR nvB_tot_prem        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_prem_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_stamp       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_tax         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_gross       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_comm        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_comm_comp   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_net         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_bal         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_tot_wcr         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nvB_tot_damt        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nvB_tot_odue        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue1       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue2       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue3       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue4       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue5       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/*---A53-0159---*/
DEF  VAR nvB_tot_odue6       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue7       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue8       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_tot_odue9       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/* SUM BRANCH TOTAL */      
DEF  VAR nvB_brtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_brtot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nvB_brtot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nvB_brtot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/*---A53-0159---*/
DEF  VAR nvB_brtot_odue6     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue7     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue8     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_brtot_odue9     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/* SUM Agent TOTAL */
DEF  VAR nvB_agtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nvB_agtot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nvB_agtot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
/*---A53-0159---*/
DEF  VAR nvB_agtot_odue6     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_agtot_odue7     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_odue8     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_agtot_odue9     AS   DECI   FORMAT  ">>,>>>,>>>,>>9.99-".

/* GRAND TOTAL */
DEF  VAR nvB_gtot_prem       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_prem_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_stamp      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_tax        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_gross      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_comm       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_comm_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_net        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_bal        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nvB_gtot_wcr        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nvB_gtot_damt       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nvB_gtot_odue       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nvB_gtot_odue1      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue2      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue3      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue4      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue5      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  

/*---A53-0159---*/
DEF  VAR nvB_gtot_odue6      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 
DEF  VAR nvB_gtot_odue7      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue8      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  
DEF  VAR nvB_gtot_odue9      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-". 

    ASSIGN
        nvB_gtot_bal = 0
        nvB_gtot_wcr = 0
        nvB_gtot_damt = 0
        nvB_gtot_odue = 0
        nvB_gtot_odue1 = 0
        nvB_gtot_odue2 = 0
        nvB_gtot_odue3 = 0
        nvB_gtot_odue4 = 0
        nvB_gtot_odue5 = 0
        nvB_gtot_odue6 = 0
        nvB_gtot_odue7 = 0
        nvB_gtot_odue8 = 0
        nvB_gtot_odue9 = 0
        nn_polbran = ""
        nn_poltyp  = ""
        /*--------------*/
        
        nv_fileC = STRING(fiFile-Name) + "C" .

/********************** Page Header *********************/           
    OUTPUT TO VALUE (STRING(nv_fileC)  ) NO-ECHO.
        IF vCount = 0 THEN DO:
            EXPORT DELIMITER ";"
                "Asdate : " +  STRING(n_asdat,"99/99/9999")
                ""
                "wacr03.w - STATEMENT A4 SUMMARY BY BRANCH"  /* "Statement A4 Reports By Acno"  */
                "" "" "" "" ""
                "Include Type : " +  nv_trntyp1
                /* A47-0500 */
                "" ""
                "Branch : " + n_branch + " - " + n_branch2
                .

            EXPORT DELIMITER ";"
                "Branch" 
                "Client Type Code"           /*note add*/
                "Group Statement"
                "Account No." "Name"  "Credit Limit" " Balance Due"
                "Within"  "Due Amount "  "Overdue"  
                /*---A53-0159---
                "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
                ----------------*/
                "1 - 15 days"  "16 - 30 days"  "31 - 45 days" "46 - 60 days"  "61 - 90 days" 
                "91 - 180 days"  "181 - 270 days"  " 271 - 365 days"  "Over 365 days" "Group" . 

        END.
    OUTPUT CLOSE.
    
/********************** END Page Header *********************/  

    FOR EACH wtBSum USE-INDEX wtBSum2 BREAK BY wtBSum.wtBbran 
                                            BY wtBSum.wtBpoltyp :

/********************** Group Header *********************/
        IF FIRST-OF(wtBsum.wtBbran) THEN DO:
        /**/
            nv_bdes = "".
            FIND xmm023 WHERE xmm023.branch = wtBsum.wtBbran  NO-LOCK NO-ERROR.
            IF AVAIL xmm023 THEN nv_bdes = xmm023.bdes.

            OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";" "".
                EXPORT DELIMITER ";"
                    "Branch  : " + wtBsum.wtBbran + " - " + nv_bdes.
            OUTPUT CLOSE.
            IF FIRST-OF (wtBsum.wtBpoltyp) THEN DO:
            ASSIGN
                nvB_brtot_bal = 0
                  
                nvB_brtot_wcr = 0
                nvB_brtot_damt = 0
                nvB_brtot_odue = 0
                  
                nvB_brtot_odue1 = 0
                nvB_brtot_odue2 = 0
                nvB_brtot_odue3 = 0
                nvB_brtot_odue4 = 0
                nvB_brtot_odue5 = 0
                nvB_brtot_odue6 = 0
                nvB_brtot_odue7 = 0
                nvB_brtot_odue8 = 0
                nvB_brtot_odue9 = 0.
        END.
          
        
        END.  /* first-of(wtBsum.wtBbran)*/

        
            
            /***************** EXPORT DETAIL ***************/
            OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    wtBsum.wtBbran
                    wtBsum.Bclientco           /*note add ja*/
                    wtBsum.wtBgpstmt
                    wtBsum.wtBacno
                    wtBsum.wtBacname
                  /*  STRING(wtBsum.wtBcredit)*/
                    STRING(wtBsum.wtBltamt,"->>>,>>>,>>>,>>9.99")
                    
                    wtBsum.wtBbal
                    wtBsum.wtBwcr
                    wtBsum.wtBdamt
                    wtBsum.wtBodue
                             
                    wtBsum.wtBodue1
                    wtBsum.wtBodue2
                    wtBsum.wtBodue3
                    wtBsum.wtBodue4
                    wtBsum.wtBodue5
                    wtBsum.wtBodue6
                    wtBsum.wtBodue7
                    wtBsum.wtBodue8
                    wtBsum.wtBodue9
                    /*---A53-0159---*/
                    wtBsum.wtBpoltyp.
                    
            OUTPUT CLOSE. 
            
            /***************** END EXPORT DETAIL ***************/

               /* SUM BRANCH */
               ASSIGN
                    nvB_brtot_bal     = nvB_brtot_bal  + wtBsum.wtBbal

                    nvB_brtot_wcr     = nvB_brtot_wcr  + wtBsum.wtBwcr
                    nvB_brtot_damt    = nvB_brtot_damt + wtBsum.wtBdamt
                    nvB_brtot_odue    = nvB_brtot_odue + wtBsum.wtBodue
                                                                  
                    nvB_brtot_odue1   = nvB_brtot_odue1 + wtBsum.wtBodue1
                    nvB_brtot_odue2   = nvB_brtot_odue2 + wtBsum.wtBodue2
                    nvB_brtot_odue3   = nvB_brtot_odue3 + wtBsum.wtBodue3
                    nvB_brtot_odue4   = nvB_brtot_odue4 + wtBsum.wtBodue4
                    nvB_brtot_odue5   = nvB_brtot_odue5 + wtBsum.wtBodue5
                    nvB_brtot_odue6   = nvB_brtot_odue6 + wtBsum.wtBodue6
                    nvB_brtot_odue7   = nvB_brtot_odue7 + wtBsum.wtBodue7
                    nvB_brtot_odue8   = nvB_brtot_odue8 + wtBsum.wtBodue8
                    nvB_brtot_odue9   = nvB_brtot_odue9 + wtBsum.wtBodue9.
                   /*--------------*/                              

               /* GRAND TOTAL*/
               ASSIGN
                    nvB_gtot_bal     = nvB_gtot_bal + wtBsum.wtBbal
                                         
                    nvB_gtot_wcr     = nvB_gtot_wcr + wtBsum.wtBwcr
                    nvB_gtot_damt    = nvB_gtot_damt + wtBsum.wtBdamt
                    nvB_gtot_odue    = nvB_gtot_odue + wtBsum.wtBodue

                    nvB_gtot_odue1   = nvB_gtot_odue1 + wtBsum.wtBodue1
                    nvB_gtot_odue2   = nvB_gtot_odue2 + wtBsum.wtBodue2
                    nvB_gtot_odue3   = nvB_gtot_odue3 + wtBsum.wtBodue3
                    nvB_gtot_odue4   = nvB_gtot_odue4 + wtBsum.wtBodue4
                    nvB_gtot_odue5   = nvB_gtot_odue5 + wtBsum.wtBodue5
                    nvB_gtot_odue6   = nvB_gtot_odue6 + wtBsum.wtBodue6
                    nvB_gtot_odue7   = nvB_gtot_odue7 + wtBsum.wtBodue7
                    nvB_gtot_odue8   = nvB_gtot_odue8 + wtBsum.wtBodue8
                    nvB_gtot_odue9   = nvB_gtot_odue9 + wtBsum.wtBodue9.
        ASSIGN nn_polbran = wtBsum.wtBbran
               nn_poltyp  = wtBsum.wtBpoltyp.

        RUN pdBrCrtWTT.
       
                    
/********************** Group Footer *********************/    
                    
        IF LAST-OF(wtBsum.wtBbran) THEN DO:
            OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
    
                EXPORT DELIMITER ";"
                    "Total Branch  : "  + wtBsum.wtBbran + " - " +  nv_bdes 
    
                    "" ""
                    ""            /*Note add column ja*/
                    ""
                    ""
                   /* ""*/
                    nvB_brtot_bal   
                                    
                    nvB_brtot_wcr   
                    nvB_brtot_damt  
                    nvB_brtot_odue  
                                    
                    nvB_brtot_odue1 
                    nvB_brtot_odue2 
                    nvB_brtot_odue3 
                    nvB_brtot_odue4 
                    nvB_brtot_odue5 
                    nvB_brtot_odue6 
                    nvB_brtot_odue7 
                    nvB_brtot_odue8 
                    nvB_brtot_odue9.
            OUTPUT CLOSE.

            FOR EACH wtTsum NO-LOCK WHERE wtTsum.wtTbran = wtBsum.wtBbran  
            BREAK BY wtTsum.wtTBran 
                  BY wtTsum.wtTpoltyp.
               OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "Total Branch  : " + wtTsum.wtTbran + " - " + wtTsum.wtTpoltyp
    
                    "" ""
                    ""            /*Note add column ja*/
                    ""
                    ""
                 /*   ""*/
                    wtTsum.wtTbal    
                                   
                    wtTsum.wtTwcr    
                    wtTsum.wtTdamt   
                    wtTsum.wtTodue   
                                   
                    wtTsum.wtTodue1  
                    wtTsum.wtTodue2  
                    wtTsum.wtTodue3  
                    wtTsum.wtTodue4  
                    wtTsum.wtTodue5  
                    wtTsum.wtTodue6  
                    wtTsum.wtTodue7  
                    wtTsum.wtTodue8  
                    wtTsum.wtTodue9. 
                
                OUTPUT CLOSE.

                RUN pdBrCrtWTG.

           END.  /* end for each wtTsum */

        END.  /* if last-of(wtsum.wtbran)*/

                    vCount = vCount + 1.


    END. /* for each agtprm_fil*/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
        EXPORT DELIMITER ";" "".

                EXPORT DELIMITER ";"
                    "GRAND TOTAL : ALL" 
                    "" ""
                    ""            /*Note add column ja*/
                    ""
                    ""
                   /* ""*/
                    nvB_gtot_bal
                      
                    nvB_gtot_wcr
                    nvB_gtot_damt
                    nvB_gtot_odue
                    
                    nvB_gtot_odue1
                    nvB_gtot_odue2
                    nvB_gtot_odue3
                    nvB_gtot_odue4
                    nvB_gtot_odue5
                    nvB_gtot_odue6
                    nvB_gtot_odue7
                    nvB_gtot_odue8
                    nvB_gtot_odue9.
                      
        OUTPUT CLOSE.

        FOR EACH wtGsum NO-LOCK  
            BREAK BY wtGsum.wtGpoltyp.
            
               OUTPUT TO VALUE (STRING(nv_fileC) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                   "GRAND TOTAL : " + " - " + wtGsum.wtGpoltyp
                    "" ""
                    ""            
                    ""
                    ""
                   /* ""*/
                    wtGsum.wtGbal    
                                   
                    wtGsum.wtGwcr    
                    wtGsum.wtGdamt   
                    wtGsum.wtGodue   
                                   
                    wtGsum.wtGodue1  
                    wtGsum.wtGodue2  
                    wtGsum.wtGodue3  
                    wtGsum.wtGodue4  
                    wtGsum.wtGodue5  
                    wtGsum.wtGodue6  
                    wtGsum.wtGodue7  
                    wtGsum.wtGodue8  
                    wtGsum.wtGodue9. 
                OUTPUT CLOSE.
        END.
/********************** Page Footer *********************/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpBrProcess C-Win 
PROCEDURE pdExpBrProcess :
/*------------------------------------------------------------------------------
  Purpose:     A47-0014  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR nv_bdes AS CHAR.

    FOR EACH wtSum : DELETE wtsum. END.
    FOR EACH wtTSum : DELETE wtTsum. END.
    FOR EACH wtGSum : DELETE wtGsum. END.

    nv_poltyp = "".
/*---A53-0159---*/
IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.
/*--A53-0159---*/


    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat       = n_asdat   AND
             (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
        ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) NO-LOCK BREAK BY agtprm_fil.polbran BY agtprm_fil.acno 
        BY agtprm_fil.poltyp:  /*A53-0159*/

        DISP agtprm_fil.polbran
             /*agtprm_fil.acno --- A500178 ---*/
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.poltyp    /*---A53-0159---*/
             agtprm_fil.policy
             agtprm_fil.trntyp
             agtprm_fil.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess3 VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        RUN pdmDay.

        IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
           ASSIGN
               nv_tot_bal = 0

               nv_tot_wcr = 0
               nv_tot_damt = 0
               nv_tot_odue = 0
               
               nv_tot_odue1 = 0
               nv_tot_odue2 = 0
               nv_tot_odue3 = 0
               nv_tot_odue4 = 0
               nv_tot_odue5 = 0
               nv_tot_odue6 = 0
               nv_tot_odue7 = 0
               nv_tot_odue8 = 0
               nv_tot_odue9 = 0.
               /*---A55-0231---*/
               ASSIGN n_odue1 = 0
               n_odue2 = 0
               n_odue3 = 0
               n_odue4 = 0
               n_odue5 = 0.
               /*--------------*/

        END.
            
             /* TOTAL */
           ASSIGN  n_odat1 = ?
                   n_odat2 = ?
                   n_odat3 = ?
                   n_odat4 = ?
                   n_odat5 = ?
                   n_odat6 = ?
                   n_odat7 = ?
                   n_odat8 = ?
                   n_odat9 = ?
                   
                   n_odue1 = 0
                   n_odue2 = 0
                   n_odue3 = 0 
                   n_odue4 = 0 
                   n_odue5 = 0 
                   n_odue6 = 0 
                   n_odue7 = 0 
                   n_odue8 = 0 
                   n_odue9 = 0
                   n_wcr   = 0
                   n_damt  = 0.

                   n_duedat = agtprm_fil.duedat .   /*nv_comdat.*/
                                        
                   ASSIGN  n_odat1 =  n_duedat  +  15
                           n_odat2 =  n_duedat  +  30
                           n_odat3 =  n_duedat  +  45
                           n_odat4 =  n_duedat  +  60
                           n_odat5 =  n_duedat  +  90
                           n_odat6 =  n_duedat  +  180
                           n_odat7 =  n_duedat  +  270
                           n_odat8 =  n_duedat  +  365. 

                    IF n_asdat <= (n_duedat - fuMaxDay(n_duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย */
                       nv_tot_wcr = nv_tot_wcr + agtprm_fil.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
                    END.
                    IF n_asdat > (n_duedat - fuMaxDay(n_duedat) + mday) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                        nv_tot_damt = nv_tot_damt + agtprm_fil.bal.   /* due Amout  ครบกำหนดชำระ*/
                    END.
                    
                    IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                       nv_tot_odue1 = nv_tot_odue1 + agtprm_fi.bal.    /*  overdue 1 - 15 days*/
                    END.
                    IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                       nv_tot_odue2 =  nv_tot_odue2 + agtprm_fi.bal.    /*  overdue 16 - 30 days*/
                    END.
                    IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                       nv_tot_odue3 = nv_tot_odue3 + agtprm_fi.bal.    /*  overdue 31 - 45 days*/
                    END.
                    IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                       nv_tot_odue4 = nv_tot_odue4 + agtprm_fi.bal.    /*  overdue 46 - 60 days*/
                    END.
                    IF n_asdat > n_odat4 AND n_asdat <= n_odat5 THEN DO:
                       nv_tot_odue5 = nv_tot_odue5 + agtprm_fi.bal.    /*  overdue 61 - 90 days*/
                    END.
                    IF n_asdat > n_odat5 AND n_asdat <= n_odat6 THEN DO:
                       nv_tot_odue6 = nv_tot_odue6 + agtprm_fi.bal.    /*  overdue 91 - 180 days*/
                    END.
                    IF n_asdat > n_odat6 AND n_asdat <= n_odat7 THEN DO:
                       nv_tot_odue7 = nv_tot_odue7 + agtprm_fi.bal.    /*  overdue 181 - 270 days*/
                    END.
                    IF n_asdat > n_odat7 AND n_asdat <= n_odat8 THEN DO:
                       nv_tot_odue8 = nv_tot_odue8 + agtprm_fi.bal.    /*  overdue 271 - 365 days*/
                    END.
                    IF n_asdat > n_odat8   THEN DO:
                       nv_tot_odue9 =  nv_tot_odue9 + agtprm_fi.bal.    /*  overdue Over 365 days*/
                    END.
                    
                    nv_tot_odue = nv_tot_odue1 + nv_tot_odue2 + nv_tot_odue3 + nv_tot_odue4 + nv_tot_odue5 +
                                  nv_tot_odue6 + nv_tot_odue7 + nv_tot_odue8 + nv_tot_odue9.
                    
                    ASSIGN nv_tot_bal       = nv_tot_bal       + agtprm_fil.bal
                           nv_tot_gross     = nv_tot_gross     + agtprm_fil.gross
                           nv_tot_comm      = nv_tot_comm      + agtprm_fil.comm
                           nv_tot_comm_comp = nv_tot_comm_comp + agtprm_fil.comm_comp.
            
            RUN pdDeptGrp.  /*แยก Motor, Non motor*/
                    
            RUN pdBrcrtwtB.   /*Create workfile*/

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                ASSIGN
                    nv_gpstmt = ""
                    nv_gpname = "".
                
                FIND FIRST wtSum USE-INDEX wtSum1 
                                WHERE wtsum.wtacno = agtprm_fil.acno AND
                                      wtsum.wtbran = agtprm_fil.polbran NO-ERROR.  
                IF NOT AVAIL wtSum THEN DO:
                
                    FIND FIRST xmm600 USE-INDEX xmm60001
                                        WHERE (xmm600.acno = agtprm_fil.acno) NO-LOCK NO-ERROR NO-WAIT.
                    /*** start note modi ***/
                    IF AVAIL xmm600 THEN DO:  
                        ASSIGN
                        nv_gpstmt = xmm600.gpstmt
                        nv_clicod = xmm600.clicod. /*note add*/
                    END.
                    /***  End note modi  ***/
                    CREATE wtSum.
                    ASSIGN
                        wtsum.wtgpstmt  = nv_gpstmt
                        wtsum.wtacno    = agtprm_fil.acno
                        wtsum.wtacname  = agtprm_fil.ac_name
                        wtsum.wtbranch  = agtprm_fil.polbran
                        wtsum.wtcredit  = agtprm_fil.credit
                        wtsum.wtltamt   = agtprm_fil.odue6
                        
                        wtsum.wtbal     = nv_tot_bal
                        wtsum.wtwcr     = nv_tot_wcr
                        wtsum.wtdamt    = nv_tot_damt
                        wtsum.wtodue    = nv_tot_odue
    
                        wtsum.wtodue1   = nv_tot_odue1
                        wtsum.wtodue2   = nv_tot_odue2
                        wtsum.wtodue3   = nv_tot_odue3
                        wtsum.wtodue4   = nv_tot_odue4
                        wtsum.wtodue5   = nv_tot_odue5
                        wtsum.wtodue6   = nv_tot_odue6
                        wtsum.wtodue7   = nv_tot_odue7
                        wtsum.wtodue8   = nv_tot_odue8
                        wtsum.wtodue9   = nv_tot_odue9
                        
                        wtsum.clientco  = nv_clicod /*note add ja*/
                        /*---A53-0159---*/
                        wtsum.wtgrptyp    = SUBSTR(nv_dir,3,1)    /*   P, C , Non    */
                        wtsum.wtpolgrp    = nv_polgrp              /*   MOTDiC, MOTDiP, MOTBrC, MOTBrP, MOTCOC NON      */ 
                        .

                END.  /* if not avail wtSum  - create*/

             END. /* IF LAST-OF(agtprm_fil.acno)  */

    END. /* for each agtprm_fil*/
 
END PROCEDURE.

/*        DISP STRING(rsOutput) + "  " + agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +  */
/*                   agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .                                                   */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdgpstmt C-Win 
PROCEDURE pdgpstmt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF BUFFER bxmm600 FOR xmm600.
DEF VAR vgpname AS CHAR.

    FOR EACH wtgp: DELETE wtgp. END.

    FOR EACH xmm600 USE-INDEX xmm60001
                                        WHERE (xmm600.acno >= nv_frac) AND (xmm600.acno <= nv_toac) 
                                       NO-LOCK:
    
        FIND FIRST bxmm600 USE-INDEX xmm60009
                                     WHERE bxmm600.acno = xmm600.gpstmt NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL bxmm600 THEN vgpname = bxmm600.name.  /* ชื่อ group code statement */
                                         ELSE vgpname = "".

        CREATE wtgp.
        ASSIGN
            wtgp.wtgpstmt = xmm600.gpstmt
            wtgp.wtgpname = vgpname
            wtgp.wtacno      = xmm600.acno
            wtgp.wtname     = xmm600.name.

    END.  /* for each xmm600*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData C-Win 
PROCEDURE pdInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch  = xmm023.branch
                fibdes     = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND Last  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch2  = xmm023.branch
                fibdes2     = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
         END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdmDay C-Win 
PROCEDURE pdmDay :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
IF AVAIL xmm031 THEN DO:

   IF xmm031.dept = "G" OR xmm031.dept = "M" THEN    /*Motor*/
      mday = 15.
   ELSE mday = 0.
   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOutput C-Win 
PROCEDURE pdOutput :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */
                IF report-name = "Check List ST(A4) By Branch" THEN DO:
                   IF n_type = "Motor" THEN DO:
                        RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                          " AND " +
                                          "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                          "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                          " AND ( " + nv_filter1 + " )". 
                   END.
                   ELSE IF n_type = "Non" THEN DO:
                       RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  /*A53-0159*/
                                          " AND " +
                                          "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                          "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                          " AND ( " + nv_filter1 + " )". 
                   END.
                   ELSE DO:
                       RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND " +
                                          "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                          "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                          " AND ( " + nv_filter1 + " )". 
                   END.

                END.
                ELSE  DO:               /* "STATEMENT A4 SUMMARY" */
                    IF n_type = "Motor" THEN DO:
                        RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                          " AND ( " + nv_filter1 + " )".
                    END.
                    ELSE IF n_type = "Non" THEN DO:
                          RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                           " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  /*A53-0159*/
                                          " AND ( " + nv_filter1 + " )".
                    END.
                    ELSE DO:
                          RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND ( " + nv_filter1 + " )".
                    END.
                END.

                /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
               /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd*/ 
                ASSIGN   
                   RB-INCLUDE-RECORDS = "O"
                   RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                   RB-PRINTER-NAME      = IF rsOutput = 2 THEN cbPrtList ELSE " "
                   RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
                   RB-NO-WAIT           = No
                   RB-OTHER-PARAMETERS  =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                           "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                           "rb_branch = " + STRING(n_branch) + CHR(10) +
                                           "rb_branch2 = " + STRING(n_branch2) + CHR(10) +
                                           "rb_branchName = " + vBranchName + CHR(10) +
                                           "rb_trntyp1 = " + "Include Type : " + nv_trntyp1  + CHR(10) +
                                           "rb_pich   = " + nv_a4a_07 + CHR(10) + /*ADD Saharat S. A62-0279*/
                                           "rb_tmsen  = " + nv_a4a_32 .           /*ADD Saharat S. A62-0279*/
                    RUN pdRunRB.
            END.
            ELSE DO:  /* To Excel  กรณี ลง excel หากเลือกลง by branch ให้ ดีง  report by Br*/

/* A47-0035
               IF report-name = "Check List ST(A4) By Branch" THEN DO:  /*wac_sm02.prl*/
                    RUN pdExpBrProcess.
                    RUN pdExpBr.        /* A46-0092   report-name = "Check List ST(A4) By Br to Excel".*/
                END.
                ELSE
                    RUN pdExpAcno.   /*  A46-0092  report-name = "Check List Statement to Excel".*/
                END.
*/

/*A47-0035*/

                IF report-name = "Summary by Producer" THEN DO:
                    RUN pdExpAcnoProcess.
                    RUN pdExpAcno.
                END.
                ELSE IF report-name = "Summary by Branch" THEN DO:
                    RUN pdExpBrProcess.
                    RUN pdExpBr. 
                    RUN pdExpBrcbc.   /*-A53-0159-*/
                END.
                ELSE IF report-name = "Summary by Agent" AND nv_out = FALSE THEN DO:
                    RUN pdExpAgentProcess.
                    RUN pdExpAgentOutFile.
                END.
                ELSE IF report-name = "Summary by Agent" AND nv_out = TRUE THEN DO:
                    RUN pdExpAgentOut.
                    RUN pdExpAgent.
                END.



            END.  /* to file*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunRB C-Win 
PROCEDURE pdRunRB :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**/           
            RUN aderb\_printrb(report-library, 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSym100 C-Win 
PROCEDURE pdSym100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  vCliCodAll = "" .
  FOR EACH sym100 USE-INDEX sym10001  WHERE sym100.tabcod = "U021"  :
        vCliCodAll = vCliCodAll + sym100.itmcod  + ",".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brAcproc_fil
    FOR EACH Acproc_fil  WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
             SUBSTRING(acProc_fil.enttim,10,3) <>  "NO"
             BY acproc_fil.asdat DESC  .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList C-Win 
PROCEDURE ProcGetPrtList :
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
    cbPrtList:List-Items IN FRAME frOutput = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME frOutput.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList C-Win 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR report-list   AS CHARACTER.
DEF VAR report-count  AS INTEGER.
DEF VAR report-number AS INTEGER.

  RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
    OUTPUT report-count).
  
  IF report-count = 0 THEN RETURN NO-APPLY.

  DO WITH FRAME frST :
        ASSIGN
          cbRptList:List-Items = report-list
          report-number = LOOKUP (report-name,report-list)
          cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
                                  ELSE ENTRY (1, report-list).    
  
       DISP cbRptList . 
  END.
  
/*     message  "cbRptList" report-library  skip (1) 
 *                  cbRptList view-as alert-box.*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR tday        AS INT FORMAT "99".
DEF VAR tmon       AS INT FORMAT "99".
DEF VAR tyear      AS INT FORMAT "9999".
DEF VAR maxday AS INT FORMAT "99".
  
ASSIGN 
               tday = DAY(vDate)
               tmon = MONTH(vDate)
               tyear = YEAR(vDate).
               /*  ให้ค่าวันที่สูงสุดของเดือนแก่ตัวแปร*/
               maxday = DAY(     DATE(tmon,28,tyear) + 4  - DAY(DATE(tmon,28,tyear) + 4)    ).
               
               
  RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
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

