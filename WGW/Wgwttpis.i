/*programid   : wgwttpis.i                                               */ 
/*programname : Load text file tpis to GW                                */ 
/* Copyright  : Safety Insurance Public Company Limited                  */  
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                       */  
/*create by   : ranu i. A57-0242   date. 22/07/2014             
               ปรับโปรแกรมให้สามารถนำเข้า text file tpis   to GW system   */
/*modify by   : Kridtiya i. A58-0029 ขยายตัวแปรเลขตัวถัง จาก 15 เป็น 25   */               
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
    FIELD camName      AS CHAR  FORMAT "x(100)" INIT ""
    FIELD cedpol       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD branch       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD entdat       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD enttim       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD trandat      AS CHAR  FORMAT "x(10)" INIT ""
    FIELD trantim      AS CHAR  FORMAT "x(10)" INIT ""
    FIELD poltyp       AS CHAR  FORMAT "x(3)"  INIT ""
    FIELD policy       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD prvpol       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD comdat       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD expdat       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD compul       AS CHAR  FORMAT "x"     INIT ""
    FIELD tiname       AS CHAR  FORMAT "x(20)" INIT ""
    FIELD insnam       AS CHAR  FORMAT "x(60)" INIT ""
    FIELD insnam2      AS CHAR  FORMAT "x(60)" INIT ""    
    FIELD iadd1        AS CHAR  FORMAT "x(160)" INIT ""
    FIELD iadd2        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD iadd3        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD iadd4        AS CHAR  FORMAT "x(35)" INIT ""
    FIELD Birth        AS CHAR  FORMAT "x(15)" INIT "xx/xx/xxx"
    FIELD Tele         AS CHAR  FORMAT "x(25)" INIT ""
    FIELD prempa       AS CHAR  FORMAT "x"     INIT ""
    FIELD subclass     AS CHAR  FORMAT "x(3)"  INIT ""
    FIELD brand        AS CHAR  FORMAT "x(30)" INIT ""
    FIELD model        AS CHAR  FORMAT "x(50)" INIT ""
    FIELD cc           AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD weight       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD seat         AS CHAR  FORMAT "x(2)"  INIT ""
    /*FIELD body         AS CHAR  FORMAT "x(25)" INIT ""*//*A58-0029*/
    FIELD body         AS CHAR  FORMAT "x(30)" INIT ""    /*A58-0029*/
    FIELD vehreg       AS CHAR  FORMAT "x(11)" INIT ""
    FIELD engno        AS CHAR  FORMAT "x(25)" INIT ""
    FIELD chasno       AS CHAR  FORMAT "x(25)" INIT ""
    FIELD caryear      AS CHAR  FORMAT "x(4)"  INIT ""
    FIELD vehuse       AS CHAR  FORMAT "x"     INIT ""
    FIELD garage       AS CHAR  FORMAT "x"     INIT ""
    FIELD inspec       AS CHAR  FORMAT "x"     INIT ""
    FIELD stk          AS CHAR  FORMAT "x(15)" INIT ""
    FIELD access       AS CHAR  FORMAT "x"     INIT ""
    /*FIELD covcod       AS CHAR  FORMAT "x"     INIT ""*//*A58-0029*/ 
    FIELD covcod       AS CHAR  FORMAT "x(3)"  INIT ""   /*A58-0029*/ 
    FIELD si           AS CHAR  FORMAT "x(25)" INIT ""
    FIELD volprem      AS CHAR  FORMAT "x(20)" INIT ""
    FIELD Compprem     AS CHAR  FORMAT "x(20)" INIT ""
    FIELD fleet        AS CHAR  FORMAT "x(10)" INIT ""
    FIELD ncb          AS DECI INIT 0
    FIELD finint       AS CHAR  FORMAT "x(10)" INIT ""
    FIELD benname      AS CHAR  FORMAT "x(60)" INIT ""         /*benificiary*/
    FIELD prmtxt       AS CHAR  FORMAT "x(60)" INIT ""         /*Accessery*/
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
    FIELD ICNO         AS CHAR  INIT "" FORMAT "x(13)"     /*รหัสบัตรประชาชน*/
    FIELD CoverNote    AS CHAR  INIT "" FORMAT "x(13)"     /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
    FIELD sendnam      AS CHAR  FORMAT "x(50)"  INIT ""
    FIELD chkcar       AS CHAR  FORMAT "x(50)"  INIT ""
    FIELD insrefno     AS CHAR  FORMAT "x(10)"  INIT ""
    FIELD changwat     AS CHAR  FORMAT "x(2)"   INIT ""
    FIELD class        AS CHAR  FORMAT "x(5)"   INIT "".
    
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
DEFINE VAR            nv_rectot    AS INT       FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ทั้งไฟล์ */          
DEFINE VAR            nv_recsuc    AS INT       FORMAT ">>,>>9"         INIT 0.           /* Display จำนวน ก/ธ ที่นำเข้าได้ */      
DEFINE VAR            nv_netprm_t  AS DECI      FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ทั้งไฟล์ */          
DEFINE VAR            nv_netprm_s  AS DECI      FORMAT "->,>>>,>>9.99"  INIT 0.           /* Display เบี้ยรวม ที่นำเข้าได้ */      
DEFINE VAR            nv_batflg    AS LOG                               INIT NO.                                                   
DEFINE VAR            nv_txtmsg    AS CHAR      FORMAT "x(50)"          INIT "".          /* Parameter คู่กับ nv_check */          
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

DEFINE  WORKFILE wcomp NO-UNDO                                          
    FIELD package     AS CHARACTER      FORMAT "X(10)"   INITIAL ""   
    FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.  

DEF VAR nv_model   AS CHAR FORMAT "X(40)"   INITIAL "".                   /*A57-0010*/                               
DEF VAR     nv_reportDate       AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_dateReq          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_contract         AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_refno            AS CHAR     FORMAT "x(100)".                                                                   
DEF VAR     nv_title            AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_custName         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_address1         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_address2         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_address3         AS CHAR     FORMAT "x(60)".                                                                    
DEF VAR     nv_postCode         AS CHAR     FORMAT "x(10)".                                                                     
DEF VAR     nv_icno             AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_birthDate        AS CHAR     FORMAT "x(10)" INIT "xx/xx/xxx".                                                                    
DEF VAR     nv_tel              AS CHAR     FORMAT "x(35)".                                                                    
DEF VAR     nv_brand            AS CHAR     FORMAT "x(30)".                                                                    
DEF VAR     nv_modelTPIS        AS CHAR     FORMAT "x(50)". /* รุ่นรถตัวแทนให้มา */                                                                   
DEF VAR     nv_modelYear        AS CHAR     FORMAT "x(10)".                                                                    
DEF VAR     nv_cc               AS CHAR     FORMAT "x(10)".                                                                    
DEF VAR     nv_typeVeh          AS CHAR     FORMAT "x(2)".                                                                     
DEF VAR     nv_insCom           AS CHAR     FORMAT "x(55)".                                                                    
DEF VAR     nv_licence          AS CHAR     FORMAT "x(12)".                                                                    
DEF VAR     nv_chassis          AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_engNum           AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_insAmount        AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_premium          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_netPrem          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_polNum           AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_comDate          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_expDate          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_LPBName          AS CHAR     FORMAT "x(25)".                                                                    
DEF VAR     nv_mktOff           AS CHAR     FORMAT "x(10)".                                                                     
DEF VAR     nv_oldCont          AS CHAR     FORMAT "x(20)".                                                                    
DEF VAR     nv_changwat         AS CHAR     FORMAT "x(2)".                                                                     
DEF VAR     nv_CAT3             AS CHAR     FORMAT "x(2)".                                                                     
DEF VAR     nv_date491          AS CHAR     FORMAT "x(15)".                                                                    
DEF VAR     nv_date724          AS CHAR     FORMAT "x(15)". 
DEF VAR     nv_pack             AS CHAR     FORMAT "x(2)".
DEF VAR     nv_classTP          AS CHAR     FORMAT "x(5)". 
DEF VAR     nv_cover            AS CHAR     FORMAT "x(3)".  /* ความคุ้มครอง 1,2,3,2+,3+ */
DEF VAR     nv_modelSaf         AS CHAR     FORMAT "x(9)".  /* รุ่นรถบริษัท */
DEF VAR     nv_branTP           AS CHAR     FORMAT "x(2)".  /* สาขาของตัวแทน */
DEF VAR     nv_branSaf          AS CHAR     FORMAT "x(2)".  /* สาขาของบริษัท */
DEF VAR     nv_ISP              AS CHAR     FORMAT "x(20)".
DEF VAR     nv_f18_1            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_2            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_3            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_4            AS CHAR     FORMAT "x(100)".
DEF VAR     nv_f18_5            AS CHAR     FORMAT "x(100)".
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
    FIELD CONTRACT            AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD REF_NO              AS CHAR  FORMAT "x(50)"   INIT ""
    FIELD nTITLE              AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD CUSTOMER_NAME       AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD MAILING_ADDRESS1    AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD MAILING_ADDRESS2    AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD MAILING_ADDRESS3    AS CHAR  FORMAT "x(60)"   INIT ""
    FIELD POSTAL_CODE         AS CHAR  FORMAT "x(20)"    INIT ""
    FIELD REG_ADDRESS1        AS CHAR  FORMAT "x(60)"   INIT ""  /*A57-0433*/
    FIELD REG_ADDRESS2        AS CHAR  FORMAT "x(60)"   INIT ""  /*A57-0433*/
    FIELD REG_ADDRESS3        AS CHAR  FORMAT "x(60)"   INIT ""  /*A57-0433*/
    FIELD REG_CODE            AS CHAR  FORMAT "x(30)"   INIT ""  /*A57-0433*/
    FIELD NATIONALITY_ID      AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD BIRTH               AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD H_TEL               AS CHAR  FORMAT "x(35)"   INIT ""
    FIELD BRAND               AS CHAR  FORMAT "x(20)"   INIT ""
    FIELD MODELTPIS           AS CHAR  FORMAT "x(15)"   INIT ""
    FIELD MODELSAF            AS CHAR  FORMAT "x(15)"   INIT ""    
    FIELD nYEAR               AS CHAR  FORMAT "x(5)"    INIT ""
    FIELD ncolor              AS CHAR  FORMAT "x(20)"   INIT ""   /*A57-0433*/
    FIELD CC                  AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD nCoverage           AS CHAR  FORMAT "x(5)"    INIT ""
    FIELD TYPE_VEH            AS CHAR  FORMAT "x(2)"    INIT ""
    FIELD INS_COM             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD LICENCE             AS CHAR  FORMAT "x(20)"   INIT ""
    FIELD CHANGWAT            AS CHAR  FORMAT "x(5)"    INIT ""
    FIELD CHASSIS             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD ENG_NUM             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD INS_AMT             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD NET_PREM            AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD PREMIUM             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD POL_NUM             AS CHAR  FORMAT "x(25)"   INIT ""
    FIELD stk_no              AS CHAR  FORMAT "x(25)"   INIT ""   /*A57-0433*/
    FIELD DATE_INS            AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD INS_EXP             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD LPBNAME             AS CHAR  FORMAT "x(20)"   INIT ""
    FIELD MKT_OFF             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD OLD_CONT            AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD CAT3                AS CHAR  FORMAT "x(2)"    INIT ""
    FIELD DATE491             AS CHAR  FORMAT "x(10)"   INIT ""
    FIELD DATE724             AS CHAR  FORMAT "x(10)"   INIT "" 
    FIELD ISP                 AS CHAR  FORMAT "x(15)"   INIT ""  
    FIELD F18_1               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_2               AS CHAR  FORMAT "x(70)"   INIT "" 
    FIELD F18_3               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_4               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD F18_5               AS CHAR  FORMAT "x(70)"   INIT ""  
    FIELD nINS_COM1           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nINSRQST1           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nINS_EXP1           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nPOL_NUM1           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nPREMIUM1           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nYR_EXT             AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nINS_COLL_OLD_CONT  AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nNEW_OLD            AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nINS_RQST           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nENDORSE            AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nYR_EXT2            AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/
    FIELD nINS_COLL           AS CHAR  FORMAT "x(25)"   INIT ""  /*A57-0433*/  .
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
DEF VAR nREG_ADDRESS1      AS CHAR FORMAT "x(60)" INIT "" .  /*A57-0433*/
DEF VAR nREG_ADDRESS2      AS CHAR FORMAT "x(60)" INIT "" .  /*A57-0433*/
DEF VAR nREG_ADDRESS3      AS CHAR FORMAT "x(60)" INIT "" .  /*A57-0433*/
DEF VAR nREG_CODE          AS CHAR FORMAT "x(60)" INIT "" .  /*A57-0433*/
DEF VAR nCOLOUR            AS CHAR FORMAT "x(30)" INIT "" .  /*A57-0433*/
DEF VAR nsticker           AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINS_COM1          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINSRQST1          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINS_EXP1          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nPOL_NUM1          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nPREMIUM1          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nYR_EXT            AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINS_COLL_OLD_CONT AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nNEW_OLD           AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINS_RQST          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nENDORSE           AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nYR_EXT2           AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/
DEF VAR nINS_COLL          AS CHAR FORMAT "x(20)" INIT "" .  /*A57-0433*/ 

 









