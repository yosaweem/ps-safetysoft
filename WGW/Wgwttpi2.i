/*programid   : wgwttpi2.i                                                             */ 
/*programname : Load text file tpis ö��÷ء�˭�  to GW                                */ 
/* Copyright  : Safety Insurance Public Company Limited                                */  
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                                     */  
/*create by   : by....... Assign ..... date...............                             
               ��Ѻ������������ö����� text file tpis ö��÷ء�˭�    to GW system  */
/**************************************************************************/

DEFINE VAR nv_txt1            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt2            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt3            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt4            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt5            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt6            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt7            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.                                        
DEFINE VAR nv_txt8            AS    CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.    
DEFINE VAR nv_line1           AS    INTEGER   INITIAL 0            NO-UNDO.                                                   
DEFINE  WORKFILE wuppertxt NO-UNDO                                                                              
    FIELD line     AS INTEGER   FORMAT ">>9"                                                                      
    FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".                                                      
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                                                
    /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                                     
    /*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".    
DEFINE VAR gv_id              AS CHAR FORMAT "X(8)" NO-UNDO.                                                               
DEFINE VAR nv_pwd             AS CHAR NO-UNDO.                                                                             
DEFINE VAR n_sclass72         AS CHAR FORMAT "x(4)".                                                                        
DEFINE VAR n_ratmin           AS INTE INIT 0.                                                                              
DEFINE VAR n_ratmax           AS INTE INIT 0.                                                                              
DEFINE VAR nv_maxdes          AS CHAR.                                                                                     
DEFINE VAR nv_mindes          AS CHAR.                                                                                     
DEFINE VAR nv_si              AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */                                     
DEFINE VAR nv_maxSI           AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */                                     
DEFINE VAR nv_minSI           AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */                                     
DEFINE VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".                                                   
DEFINE VAR nv_basere          AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.                                               
DEFINE VAR nv_newsck          AS CHAR FORMAT "x(15)" INIT " ".                                                              
DEFINE VAR n_firstdat         AS DATE INIT ?.                                                                                                         
DEF VAR np_number           AS CHAR FORMAT "x(10)"  INIT "" .
DEF VAR np_model            AS CHAR FORMAT "x(55)"  INIT "" .                                                                                                             
DEF VAR np_Li_Province      AS CHAR FORMAT "x(30)"  INIT "" .                                                        
DEF VAR np_cc               AS DECI  INIT 0 . 
DEF VAR np_seate            AS CHAR FORMAT "x(12)"  INIT "" .     
DEFINE  TEMP-TABLE wdetail
    FIELD policy       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD poltyp       AS CHAR  FORMAT "x(3)"  INIT ""
    FIELD cedpol       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD branch       AS CHAR  FORMAT "x(2)"  INIT ""
    FIELD tiname       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD insnam       AS CHAR  FORMAT "x(60)" INIT ""
    FIELD insnam2      AS CHAR  FORMAT "x(60)" INIT ""   
    FIELD iadd1        AS CHAR  FORMAT "x(250)" INIT ""
    FIELD iadd2        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD iadd3        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD iadd4        AS CHAR  FORMAT "x(35)" INIT ""
    FIELD Birth        AS CHAR  FORMAT "x(15)" INIT "xx/xx/xxx"
    FIELD Tele         AS CHAR  FORMAT "x(25)" INIT ""
    FIELD prvpol       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD comdat       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD expdat       AS CHAR  FORMAT "x(15)" INIT ""
    FIELD compul       AS CHAR  FORMAT "x"     INIT ""
    FIELD prempa       AS CHAR  FORMAT "x"     INIT ""
    FIELD subclass     AS CHAR  FORMAT "x(3)"  INIT ""
    FIELD brand        AS CHAR  FORMAT "x(30)" INIT ""
    FIELD model        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD cc           AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD weight       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD seat         AS CHAR  FORMAT "x(2)"  INIT ""
    FIELD body         AS CHAR  FORMAT "x(30)" INIT ""    
    FIELD vehreg       AS CHAR  FORMAT "x(11)" INIT ""
    FIELD engno        AS CHAR  FORMAT "x(25)" INIT ""
    FIELD chasno       AS CHAR  FORMAT "x(25)" INIT ""
    FIELD caryear      AS CHAR  FORMAT "x(4)"  INIT ""
    FIELD vehuse       AS CHAR  FORMAT "x"     INIT ""
    FIELD garage       AS CHAR  FORMAT "x"     INIT ""
    FIELD inspec       AS CHAR  FORMAT "x"     INIT ""
    FIELD stk          AS CHAR  FORMAT "x(15)" INIT ""
    /*FIELD camName      AS CHAR  FORMAT "x(100)" INIT ""  */
    /*FIELD cov          AS CHAR  FORMAT "x(10)" INIT ""*/
    /*FIELD pack         AS CHAR  FORMAT "x(10)" INIT ""*/
    /*FIELD province     AS CHAR  FORMAT "x(20)" INIT ""
    FIELD inscom       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD insdate      AS CHAR  FORMAT "x(15)" INIT "xx/xx/xxx"*/
    /*FIELD colour       AS CHAR  FORMAT "x(20)" INIT ""*/
    /*FIELD rec          AS CHAR  FORMAT "x(15)" INIT ""
    FIELD netprem1     AS CHAR  FORMAT "x(20)" INIT ""
    FIELD volprem1     AS CHAR  FORMAT "x(20)" INIT ""
    FIELD maiadd       AS CHAR  FORMAT "x(100)" INIT ""
    FIELD ind          AS CHAR  FORMAT "x(15)" INIT ""
    FIELD inty         AS CHAR  FORMAT "x(15)" INIT ""*/
    FIELD entdat       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD enttim       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD trandat      AS CHAR  FORMAT "x(10)" INIT ""
    FIELD trantim      AS CHAR  FORMAT "x(10)" INIT ""
    FIELD access       AS CHAR  FORMAT "x"     INIT ""
    FIELD covcod       AS CHAR  FORMAT "x(3)"  INIT ""   
    FIELD si           AS CHAR  FORMAT "x(25)" INIT ""
    FIELD netprem      AS CHAR  FORMAT "x(20)" INIT ""
    FIELD volprem      AS CHAR  FORMAT "x(20)" INIT ""
    FIELD Compprem     AS CHAR  FORMAT "x(20)" INIT ""
    FIELD fleet        AS CHAR  FORMAT "x(10)" INIT ""
    FIELD ncb          AS DECI INIT 0
    FIELD finint       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD benname      AS CHAR  FORMAT "x(60)" INIT ""         /*benificiary*/
    FIELD prmtxt       AS CHAR  FORMAT "x(250)" INIT ""         /*Accessery*/
    FIELD n_user       AS CHAR  FORMAT "x(10)" INIT ""         /*user id*/
    FIELD n_IMPORT     AS CHAR  FORMAT "x(2)"  INIT ""
    FIELD n_export     AS CHAR  FORMAT "x(2)"  INIT ""
    FIELD cancel       AS CHAR  FORMAT "x(2)"  INIT ""         /*cancel*/
    FIELD WARNING      AS CHAR  FORMAT "X(30)"  INIT ""
    FIELD comment      AS CHAR  FORMAT "x(512)" INIT ""
    FIELD seat41       AS INTE  FORMAT "99"     INIT 0
    FIELD pass         AS CHAR  FORMAT "x"      INIT "n"
    FIELD OK_GEN       AS CHAR  FORMAT "X"      INIT "Y"
    FIELD comper       AS CHAR  INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD comacc       AS CHAR  INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD NO_41        AS CHAR  INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD NO_42        AS CHAR  INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD NO_43        AS CHAR  INIT "200000"   FORMAT ">,>>>,>>>,>>>,>>9"
    FIELD tariff       AS CHAR  FORMAT "x(2)"   INIT ""
    FIELD baseprem     AS INTE  FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp       AS CHAR  FORMAT "x(2)"   INIT ""
    FIELD producer     AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD agent        AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD inscod       AS CHAR  INIT ""
    FIELD premt        AS CHAR  FORMAT "x(10)" INIT ""
    FIELD redbook      AS CHAR  INIT "" FORMAT "X(10)"     /*note add*/
    FIELD base         AS CHAR  INIT "" FORMAT "X(10)"                      /*Note add Base Premium 25/09/2006*/
    FIELD accdat       AS CHAR  INIT "" FORMAT "x(10)"     /*Account Date For 72*/
    FIELD docno        AS CHAR  INIT "" FORMAT "x(10)"     /*Docno For 72*/
    FIELD ICNO         AS CHAR  INIT "" FORMAT "x(13)"     /*���ʺѵû�ЪҪ�*/
    FIELD CoverNote    AS CHAR  INIT "" FORMAT "x(13)"     /* �к�����繧ҹ COVER NOTE A51-0071 amparat*/
    FIELD sendnam      AS CHAR  FORMAT "x(50)"  INIT ""
    FIELD chkcar       AS CHAR  FORMAT "x(50)"  INIT ""
    FIELD insrefno     AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD changwat     AS CHAR  FORMAT "x(2)"   INIT ""
    /*FIELD class        AS CHAR  FORMAT "x(5)"   INIT ""*/    .
    
DEF NEW SHARED VAR    nv_message as   char.                                                                        
DEFINE NEW SHARED VAR no_baseprm   AS DECI      FORMAT ">>,>>>,>>9.99-".   /*note add test Base Premium 25/09/2006     */ 
DEFINE NEW SHARED VAR NO_basemsg   AS CHAR      FORMAT "x(50)" .           /*Warning Error If Not in Range 25/09/2006  */ 
DEFINE            VAR nv_accdat    AS DATE      FORMAT "99/99/9999"     INIT ?  .                                             
DEFINE            VAR nv_docno     AS CHAR      FORMAT "9999999"        INIT " ".                                            
DEFINE NEW SHARED VAR nv_batchyr   AS INT       FORMAT "9999"           INIT 0.                                              
DEFINE NEW SHARED VAR nv_batcnt    AS INT       FORMAT "99"             INIT 0.                                              
DEFINE NEW SHARED VAR nv_batchno   AS CHARACTER FORMAT "X(13)"          INIT ""  NO-UNDO.                                    
DEFINE VAR            nv_batrunno  AS INT       FORMAT ">,>>9"          INIT 0.                                                    
DEFINE VAR            nv_imppol    AS INT       FORMAT ">>,>>9"         INIT 0.                                                    
DEFINE VAR            nv_impprem   AS DECI      FORMAT "->,>>>,>>9.99"  INIT 0.                                                    
DEFINE VAR            nv_batprev   AS CHARACTER FORMAT "X(13)"          INIT ""  NO-UNDO.                                          
DEFINE VAR            nv_tmppolrun AS INTEGER   FORMAT "999"            INIT 0.           /*Temp Policy Running No.*/              
DEFINE VAR            nv_batbrn    AS CHARACTER FORMAT "x(2)"           INIT ""  NO-UNDO. /*Batch Branch*/                          
DEFINE VAR            nv_tmppol    AS CHARACTER FORMAT "x(16)"          INIT "".          /*Temp Policy*/                           
DEFINE VAR            nv_rectot    AS INT       FORMAT ">>,>>9"         INIT 0.           /* Display �ӹǹ �/� ������ */          
DEFINE VAR            nv_recsuc    AS INT       FORMAT ">>,>>9"         INIT 0.           /* Display �ӹǹ �/� ��������� */      
DEFINE VAR            nv_netprm_t  AS DECI      FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display ������� ������ */          
DEFINE VAR            nv_netprm_s  AS DECI      FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display ������� ��������� */      
DEFINE VAR            nv_batflg    AS LOG                               INIT NO.                                                   
DEFINE VAR            nv_txtmsg    AS CHAR      FORMAT "x(50)"          INIT "".          /* Parameter ���Ѻ nv_check */          
DEFINE VAR            n_model      AS CHAR      FORMAT "x(40)".  
DEFINE VAR  n_insref     AS CHARACTER   FORMAT "X(10)".                                                                
DEFINE VAR  nv_messagein AS CHAR        FORMAT "X(200)".                                                                    
DEFINE VAR  nv_usrid     AS CHARACTER   FORMAT "X(08)".                                                                
DEFINE VAR  nv_transfer  AS LOGICAL   .                                                                              
DEFINE VAR  n_check      AS CHARACTER .                                                                              
DEFINE VAR  nv_insref    AS CHARACTER   FORMAT "X(10)".                                                                
DEFINE VAR  putchr       AS CHAR        FORMAT "X(200)" INIT "" NO-UNDO.                                                    
DEFINE VAR  putchr1      AS CHAR        FORMAT "X(100)" INIT "" NO-UNDO.                                                    
DEFINE VAR  nv_typ       AS CHAR        FORMAT "X(2)".                                                                      
DEFINE VAR  aa           AS DECI.                                                                                  
DEFINE VAR  nv_driver    AS CHARACTER   FORMAT "X(23)" INITIAL ""  .
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO                                                         
    FIELD policy     AS CHARACTER    INITIAL ""                                                  
    FIELD lnumber    AS INTEGER                                                                  
    FIELD ltext      AS CHARACTER    INITIAL ""                                                  
    FIELD ltext2     AS CHARACTER    INITIAL ""  .   

DEF VAR     nv_model   AS CHAR FORMAT "X(40)"   INITIAL "".                   /*A57-0010*/                               
DEF VAR     nv_reportDate       AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_dateReq          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_contract         AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_refno            AS CHAR     FORMAT "x(100)".                                                                   
DEF VAR     nv_title            AS CHAR     FORMAT "x(20)".  
DEF VAR     nv_Name             AS CHAR     FORMAT "x(100)".  
DEF VAR     nv_sName            AS CHAR     FORMAT "x(80)".                                                                    
DEF VAR     nv_custName         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_address1         AS CHAR     FORMAT "x(250)".                                                                    
DEF VAR     nv_address2         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_address3         AS CHAR     FORMAT "x(60)".   
DEF VAR     nv_address4         AS CHAR     FORMAT "x(60)".    
DEF VAR     nv_postCode         AS CHAR     FORMAT "x(10)".                                                                     
DEF VAR     nv_icno             AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_birthDate        AS CHAR     FORMAT "x(10)" INIT "xx/xx/xxx".                                                                    
DEF VAR     nv_tel              AS CHAR     FORMAT "x(35)".                                                                    
DEF VAR     nv_brand            AS CHAR     FORMAT "x(30)".                                                                    
DEF VAR     nv_modelTPIS        AS CHAR     FORMAT "x(50)". /* ���ö���᷹����� */                                                                   
DEF VAR     nv_modelYear        AS CHAR     FORMAT "x(10)".                                                                    
DEF VAR     nv_cc               AS CHAR     FORMAT "x(10)".                                                                    
DEF VAR     nv_typeVeh          AS CHAR     FORMAT "x(2)". 
DEF VAR     nv_package          AS CHAR     FORMAT "x(5)". 
/*DEF VAR     nv_covver           AS CHAR     FORMAT "x(3)". */
DEF VAR     nv_compulsory       AS CHAR     FORMAT "x(20)". 
DEF VAR     nv_insCom           AS CHAR     FORMAT "x(55)".                                                                    
DEF VAR     nv_licence          AS CHAR     FORMAT "x(12)".                                                                    
DEF VAR     nv_chassis          AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_engNum           AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_insAmount        AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_premium          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_netPrem          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_polNum           AS CHAR     FORMAT "x(20)". 
DEF VAR     nv_insDate          AS CHAR     FORMAT "x(15)". 
DEF VAR     nv_comDate          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_expDate          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_LPBName          AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_mktOff           AS CHAR     FORMAT "x(10)".                                                                     
DEF VAR     nv_oldCont          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_changwat         AS CHAR     FORMAT "x(2)".   
DEF VAR     nv_province         AS CHAR     FORMAT "x(30)". 
DEF VAR     nv_CAT3             AS CHAR     FORMAT "x(2)".                                                                     
DEF VAR     nv_date491          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_date724          AS CHAR     FORMAT "x(15)". 
DEF VAR     nv_recive           AS CHAR     FORMAT "x(10)".
DEF VAR     nv_netPrem1         AS CHAR     FORMAT "x(20)".
DEF VAR     nv_premium1         AS CHAR     FORMAT "x(20)".
DEF VAR     nv_maiAddress       AS CHAR     FORMAT "x(250)". 
DEF VAR     nv_idNum            AS CHAR     FORMAT "x(20)". 
DEF VAR     nv_insType          AS CHAR     FORMAT "x(20)". 
DEF VAR     nv_pack             AS CHAR     FORMAT "x(2)".
DEF VAR     nv_classTP          AS CHAR     FORMAT "x(5)". 
DEF VAR     nv_cover            AS CHAR     FORMAT "x(3)".  /* ����������ͧ 1,2,3,2+,3+ */
DEF VAR     nv_modelSaf         AS CHAR     FORMAT "x(9)".  /* ���ö����ѷ */
DEF VAR     nv_branTP           AS CHAR     FORMAT "x(2)".  /* �ҢҢͧ���᷹ */
DEF VAR     nv_branSaf          AS CHAR     FORMAT "x(2)".  /* �ҢҢͧ����ѷ */
DEF VAR     nv_ISP              AS CHAR     FORMAT "x(20)".
DEF VAR     nv_bennames         AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_1            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_2            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_3            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_4            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_5            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f6acc1           AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f6acc2           AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f6acc3           AS CHAR     FORMAT "x(100)".
DEF VAR     nv_dealer           AS CHAR     FORMAT "x(100)".
DEF VAR     n_garage            AS CHAR     FORMAT "x(2)".
DEF VAR     n_BDate             AS DECI    INIT 0.
DEF VAR     np_date             AS CHAR     FORMAT "x(15)" INIT "xx/xx/xxxx".

DEFINE  WORKFILE wdetailmemo  NO-UNDO  
    FIELD policy      AS CHARACTER FORMAT "X(16)"
    FIELD reportDate  AS CHARACTER FORMAT "X(15)"  
    FIELD dateReq     AS CHARACTER FORMAT "X(15)" 
    FIELD ref_no      AS CHARACTER FORMAT "X(50)"
    FIELD ModelTPIS   AS CHARACTER FORMAT "x(30)"
    FIELD inscom      AS CHARACTER FORMAT "x(10)"
    FIELD Polnum      AS CHARACTER FORMAT "x(13)"
    FIELD LPBName     AS CHARACTER FORMAT "X(30)"  
    FIELD mktOff      AS CHARACTER FORMAT "X(10)"  
    FIELD oldCont     AS CHARACTER FORMAT "X(15)"  
    FIELD CAT3        AS CHARACTER FORMAT "X(3)"  
    FIELD DATE491     AS CHARACTER FORMAT "X(15)"  
    FIELD DATE724     AS CHARACTER FORMAT "X(15)"
    FIELD memotxt1    AS CHARACTER FORMAT "X(78)"      
    FIELD memotxt2    AS CHARACTER FORMAT "X(78)"     
    FIELD memotxt3    AS CHARACTER FORMAT "X(78)"    
    FIELD memotxt4    AS CHARACTER FORMAT "X(78)"   
    FIELD memotxt5    AS CHARACTER FORMAT "X(78)"   
    FIELD memotxt6    AS CHARACTER FORMAT "X(78)"   
    FIELD memotxt7    AS CHARACTER FORMAT "X(78)".

DEFINE  TEMP-TABLE wdetail3
    FIELD policy              AS CHAR  FORMAT "x(16)"   INIT ""
    FIELD REPORT_DATE         AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD INS_REQUEST         AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD CONTRACT            AS CHAR  FORMAT "x(20)"   INIT ""
    FIELD REF_NO              AS CHAR  FORMAT "x(50)"   INIT ""
    FIELD nTITLE              AS CHAR  FORMAT "x(30)"   INIT ""
    FIELD CUSTOMER_NAME       AS CHAR  FORMAT "x(80)"   INIT ""
    FIELD MAILING_ADDRESS1    AS CHAR  FORMAT "x(150)"   INIT ""
    /*FIELD MAILING_ADDRESS2    AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD MAILING_ADDRESS3    AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD POSTAL_CODE         AS CHAR  FORMAT "x(20)"    INIT ""*/
    FIELD REG_ADDRESS1        AS CHAR  FORMAT "x(150)"   INIT ""  
   /* FIELD REG_ADDRESS2        AS CHAR  FORMAT "x(60)"   INIT ""  
    FIELD REG_ADDRESS3        AS CHAR  FORMAT "x(60)"   INIT ""  
    FIELD REG_CODE            AS CHAR  FORMAT "x(30)"   INIT ""  */
    /*FIELD NATIONALITY_ID      AS CHAR  FORMAT "x(15)"   INIT ""*/
    /*FIELD BIRTH               AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD H_TEL               AS CHAR  FORMAT "x(35)"   INIT "" */
    FIELD BRAND               AS CHAR  FORMAT "x(30)"   INIT ""
    FIELD MODELTPIS           AS CHAR  FORMAT "x(45)"   INIT ""
    FIELD MODELSAF            AS CHAR  FORMAT "x(45)"   INIT ""   
    FIELD nYEAR               AS CHAR  FORMAT "x(5)"    INIT ""
    FIELD ncolor              AS CHAR  FORMAT "x(20)"   INIT ""  
    FIELD CC                  AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD nCoverage           AS CHAR  FORMAT "x(5)"    INIT ""
    FIELD TYPE_VEH            AS CHAR  FORMAT "x(2)"    INIT "" 
    FIELD INS_COM             AS CHAR  FORMAT "x(10)"   INIT "" 
    FIELD LICENCE             AS CHAR  FORMAT "x(20)"   INIT ""
    FIELD CHANGWAT            AS CHAR  FORMAT "x(20)"    INIT ""
    FIELD CHASSIS             AS CHAR  FORMAT "x(30)"   INIT ""
    FIELD ENG_NUM             AS CHAR  FORMAT "x(30)"   INIT ""
    FIELD INS_AMT             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD NET_PREM            AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD PREMIUM             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD POL_NUM             AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD stk_no              AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD DATE_INS            AS CHAR  FORMAT "x(10)"   INIT "" 
    FIELD INS_EXP             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD branch              AS CHAR  FORMAT "x(2)"   INIT ""
    /*FIELD LPBNAME             AS CHAR  FORMAT "x(20)"   INIT " "*/
    FIELD MKT_OFF             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD OLD_CONT            AS CHAR  FORMAT "x(10)"   INIT "" 
    FIELD CAT3                AS CHAR  FORMAT "x(2)"    INIT ""
    FIELD DATE491             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD DATE724             AS CHAR  FORMAT "x(10)"   INIT "" 
    /*FIELD ISP                 AS CHAR  FORMAT "x(15)"   INIT ""  */
    FIELD F18_1               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_2               AS CHAR  FORMAT "x(70)"   INIT "" 
    FIELD F18_3               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_4               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_5               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD nINS_COM1           AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nINSRQST1           AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nINS_EXP1           AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nPOL_NUM1           AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nPREMIUM1           AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD nPack               AS CHAR  FORMAT "x(5)"    INIT "" 
    FIELD nDealer             AS CHAR  FORMAT "x(150)"  INIT ""
    FIELD nVeh                AS CHAR  FORMAT "x(1)"    INIT "" 
    FIELD nClass72            AS CHAR  FORMAT "x(5)"    INIT "" 
    FIELD com_no              AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD rec_no              AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD netPREM             AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD id_num              AS CHAR  FORMAT "x(25)"   INIT "" 
    FIELD ins_type            AS CHAR  FORMAT "x(250)"  INIT "" 
    FIELD nben                AS CHAR  FORMAT "x(100)"  INIT "" 
    FIELD F6_1                AS CHAR  FORMAT "x(150)"  INIT "" 
    FIELD F6_2                AS CHAR  FORMAT "x(150)"  INIT "" 
    FIELD F6_3                AS CHAR  FORMAT "x(150)"  INIT "" 
    FIELD nYR_EXT             AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nINS_COLL_OLD_CONT  AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nNEW_OLD            AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nINS_RQST           AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nENDORSE            AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nYR_EXT2            AS CHAR  FORMAT "x(25)"   INIT ""  
    FIELD nINS_COLL           AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD nBrand              AS CHAR  FORMAT "x(30)"   INIT ""    .
DEFINE NEW  SHARED VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW  SHARED VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".
DEF VAR nREG_ADDRESS1      AS CHAR FORMAT "x(250)" INIT "" .  
DEF VAR nREG_ADDRESS2      AS CHAR FORMAT "x(60)" INIT "" .  
DEF VAR nREG_ADDRESS3      AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR nREG_ADDRESS4      AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR nREG_CODE          AS CHAR FORMAT "x(60)" INIT "" .  
DEF VAR nCOLOUR            AS CHAR FORMAT "x(30)" INIT "" .  
DEF VAR nsticker           AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINS_COM1          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINSRQST1          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINS_EXP1          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nPOL_NUM1          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nPREMIUM1          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nYR_EXT            AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINS_COLL_OLD_CONT AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nNEW_OLD           AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINS_RQST          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nENDORSE           AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nYR_EXT2           AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nINS_COLL          AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
/*����� ����Ѻ�ŧ��� */
/* def  stream ns1.                                                                                              */
DEFINE VAR     nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.                        
DEFINE VAR     nv_reccnt       AS INT   INIT  0.                                                              
/* DEFINE VAR     nv_completecnt  AS INT   INIT  0.                                                              */
/* DEFINE VAR     nv_enttim       AS CHAR  INIT  "" .                                                            */
 def    var     nv_export       as char  init  ""  format "X(8)".                                             
/* def    stream  ns2.                                                                                           */
 DEFINE NEW SHARED WORKFILE wdetailtxt NO-UNDO                                                                    
     FIELD Recordtype  AS CHAR FORMAT "X(1)"     INIT ""           /*1  Header Record "D"*/                    
     FIELD Contractno  AS CHAR FORMAT "X(10)"    INIT ""           /*2  Contract Number     */                 
     FIELD pol_name    AS CHAR FORMAT "X(60)"    INIT ""           /*3  ���ͼ����һ�Сѹ*/                     
     FIELD pol_addr1   AS CHAR FORMAT "X(160)"   INIT ""           /*4  �����������һ�Сѹ1/����Ѻ���͡���*/ 
     FIELD carbrand    AS CHAR FORMAT "X(16)"    INIT ""           /*5  Car brand code:"001"=TOYOTA*/          
     FIELD model       AS CHAR FORMAT "X(16)"    INIT ""           /*6  HILUX,SOLUNA*/                         
     FIELD yrmanu      AS CHAR FORMAT "X(4)"     INIT ""           /*7  Year of car  */                        
     FIELD colorcode   AS CHAR FORMAT "X(16)"    INIT ""           /*8  Color Code*/                           
     FIELD cc_weight   AS CHAR FORMAT "X(4)"     INIT ""           /*9  CC/WEIGHT KG/TON*/                     
     FIELD engine      AS CHAR FORMAT "X(26)"    INIT ""           /*10 �����Ţ����ͧ¹��*/                   
     FIELD chassis     AS CHAR FORMAT "X(26)"    INIT ""           /*11 �����Ţ��Ƕѧö*/                      
     FIELD licence     AS CHAR FORMAT "X(12)"    INIT ""           /*12 �����Ţ����¹ö */                    
     FIELD province    AS CHAR FORMAT "X(25)"    INIT ""           /*13 �ѧ��Ѵ��訴����¹ö*/                
     FIELD comp_code   AS CHAR FORMAT "X(5)"     INIT ""           /*14 ���� �.��Сѹ���(TLT.COMMENT)*/        
     FIELD accdat      AS CHAR FORMAT "X(8)"     INIT ""           /*15 �ѹ��赡ŧ�Ѻ��Сѹ */                 
     FIELD expdat      AS CHAR FORMAT "X(8)"     INIT ""           /*16 �ѹ������ش����������ͧ */            
     FIELD policy      AS CHAR FORMAT "X(26)"    INIT ""           /*17 �Ţ���������� */                      
     FIELD ins_amt     AS CHAR FORMAT "X(20)"    INIT ""           /*18 �Ţ���������� */                      
     FIELD prem_vo     AS CHAR FORMAT "X(20)"    INIT ""           /*19 ������».1 + ���� + �ҡ� */           
     FIELD sckno       AS CHAR FORMAT "X(26)"    INIT ""           /*20 �Ţ����������ú. */                  
     FIELD prem_72     AS CHAR FORMAT "X(20)"    INIT ""           /*21 ���� �ú. */                          
     FIELD stkno       AS CHAR FORMAT "X(15)"    INIT ""           /*21 �Ţ���ʵ������ */                    
     FIELD ref_no      AS CHAR FORMAT "X(20)"    INIT ""           /*22 �Ţ���������� */                      
     FIELD temp        AS CHAR FORMAT "X(16)"    INIT ""           /*23 �����ء��� */  /* Add by A52-0310 */   
     /*---------- Add Watsana K. [A530131] -------------*/                                                     
     FIELD net_prm     AS INT  FORMAT ">>>,>>>,>>9.99-"  INIT ""   /*24 Net Premium (Voluntary). */            
     FIELD net_comp    AS INT  FORMAT ">>>,>>>,>>9.99-"  INIT ""   /*25 Net Premium (Compulsory) */            
     /*---------- End Watsana K. [A530131] -------------*/                                                     
     FIELD mail        AS CHAR FORMAT "x(160)"   INIT ""           /*26 �������ͧ�١��� (mailing address) */  
     FIELD idcardno    AS CHAR FORMAT "x(13)"    INIT ""           /*Add A56-0217*/                            
     FIELD insurtyp    AS CHAR FORMAT "x"        INIT "" .         /*Add A56-0217*/                            
 DEF VAR ns_policyrenew AS CHAR FORMAT "x(30)"   INIT "" .         /*Add A56-0217*/                           
 DEF VAR ns_policy72    AS CHAR FORMAT "x(30)"   INIT "" .         /*Add A56-0217*/ 
 DEF VAR nv_polno       AS CHAR FORMAT "x(14)" INIT "" .
 DEFINE  WORKFILE wcomp NO-UNDO                                          
     /*1*/      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""    
     /*2*/      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0    
                FIELD vehuse      AS CHAR FORMAT "x" INIT "1"              .
 DEF VAR nv_vehuse72 AS CHAR FORMAT "x" INIT "1"  .
 DEF VAR nvclass72   AS CHAR FORMAT "x(5)" INIT ""  .
 DEFINE  WORKFILE wprmt       NO-UNDO                                          
 /*1*/      FIELD policy      AS CHARACTER FORMAT "X(16)"   INITIAL ""    
 /*2*/      FIELD premtacc1   AS CHARACTER FORMAT "X(60)"   INITIAL ""    
            FIELD premtacc2   AS CHARACTER FORMAT "X(60)"   INITIAL ""    
            FIELD premtacc3   AS CHARACTER FORMAT "X(60)"   INITIAL ""   .

                                                 


 









