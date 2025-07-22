/*programid   : wgwsngen.i                                               */ 
/*programname : Load text file Sin_Asia to GW                            */ 
/*Copyright   : Safety Insurance Public Company Limited 			     */ 
/*			    ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)				         */ 
/*create by   : Kridtiya i. A54-0056  date . 29/03/2011                  
                ��Ѻ������������ö����� text file sinasia to GW system*/ 
/*copy write  : wgwargen.i                                               */ 
/*************************************************************************/ 
DEFINE NEW SHARED TEMP-TABLE wdetail2
    FIELD inscmp              AS CHAR FORMAT "x(20)" INIT ""  /*  ���ͺ���ѷ��Сѹ  */                                           
    FIELD offcde              AS CHAR FORMAT "x(10)" INIT ""  /*  CODE-�Ң�   */                                                   
    FIELD insyearno           AS CHAR FORMAT "x(4)"  INIT ""  /*  �շ��ӻ�Сѹ   */                                               
    FIELD notifyno            AS CHAR FORMAT "x(25)" INIT ""  /*  �Ţ�Ѻ��  */                                                   
    FIELD prepol              AS CHAR FORMAT "x(25)" INIT ""  /*  �Ţ��.���  */                                                   
    FIELD cedpol              AS CHAR FORMAT "x(25)" INIT ""  /*  �Ţ�ѭ��    */                                                   
    FIELD CustName            AS CHAR FORMAT "x(60)" INIT ""  /*  �����١���  */                                                   
    FIELD idno                AS CHAR FORMAT "x(15)" INIT ""  /*  �Ţ�ѵû�ЪҪ�  */                                               
    FIELD Category            AS CHAR FORMAT "X(30)" INIT ""  /*  ������ö¹��    */                                               
    FIELD Brand               AS CHAR FORMAT "x(30)" INIT ""  /*  ������  */                                                       
    FIELD Model               AS CHAR FORMAT "x(50)" INIT ""  /*  ���ö  */                                                       
    FIELD CC                  AS CHAR FORMAT "x(5)"  INIT ""  /*  cc  */                                                           
    FIELD caryear             AS CHAR FORMAT "x(4)"  INIT ""  /*  ��ö    */                                                       
    FIELD engno               AS CHAR FORMAT "x(25)" INIT ""  /*  �Ţ����ͧ  */                                                   
    FIELD chasno              AS CHAR FORMAT "x(25)" INIT ""  /*  �Ţ�ѧ  */                                                       
    FIELD licno               AS CHAR FORMAT "x(10)" INIT ""  /*  ����¹ */                                                       
    FIELD province            AS CHAR FORMAT "x(30)" INIT ""  /*  �ѧ��Ѵ */                                                       
    FIELD regdte              AS CHAR FORMAT "x(20)" INIT ""  /*  �ѹ��訴����¹ */                                               
    FIELD LicType             AS CHAR FORMAT "x(10)" INIT ""  /*  ������������¹ */                                               
    FIELD covtyp              AS CHAR FORMAT "x(30)" INIT ""  /*  ����������ͧ    */                                               
    FIELD covamt              AS CHAR FORMAT "x(20)" INIT ""  /*  �ع��   */                                                       
    FIELD covamttheft         AS CHAR FORMAT "x(20)" INIT ""  /*  �ع���  */                                                    
    FIELD efftdte             AS CHAR FORMAT "X(10)" INIT ""  /*  �ѹ������ͧ */                                                    
    FIELD expdte              AS CHAR FORMAT "x(10)" INIT ""  /*  �ѹ�������  */                                                    
    FIELD netpremamt          AS CHAR FORMAT "x(20)" INIT ""  /*  �����ط��  */                                                    
    FIELD gropremamt          AS CHAR FORMAT "x(20)" INIT ""  /*  �������    */                                                    
    FIELD notifyuser          AS CHAR FORMAT "x(30)" INIT ""  /*  �����(�յ��)  */                                                
    FIELD CmrName             AS CHAR FORMAT "x(30)" INIT ""  /*  ����� (marketing-�ͺ�á)  */                                     
    FIELD InsuranceOfficer    AS CHAR FORMAT "x(30)" INIT ""  /* ���˹�ҷ���Ѻ�� / �Ţ�ú.    */                                 
    FIELD CustAddressMailing  AS CHAR FORMAT "x(100)" INIT ""  /* �������Ѵ���͡�������١��� (�����͡��÷�駺ؤ����йԵԺؤ��)*/ 
    FIELD OutsAmt3001         AS CHAR FORMAT "x(30)" INIT ""  /* ���Ф����������    */                                             
    FIELD OutsAmt3002         AS CHAR FORMAT "x(30)" INIT ""  /* ���Ф�Ҿú.���� */                                                 
    FIELD nTotal              AS CHAR FORMAT "x(15)" INIT ""  /* Total   */                                                         
    FIELD barcode             AS CHAR FORMAT "x(25)" INIT ""  /* �Ţ������ */   
    FIELD namerequest         AS CHAR FORMAT "x(50)" INIT ""  
    FIELD daterequest         AS CHAR FORMAT "x(20)" INIT ""  
    FIELD nocheck             AS CHAR FORMAT "x(30)" INIT ""  .
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy          AS CHAR FORMAT "x(25)" INIT ""   /* notify number*/  
    FIELD poltyp          AS CHAR FORMAT "x(3)"  INIT ""                   
    FIELD caryear         AS CHAR FORMAT "x(4)"  INIT ""   /* year         */  
    FIELD eng             AS CHAR FORMAT "x(25)" INIT ""   /* engine       */  
    FIELD chasno          AS CHAR FORMAT "x(25)" INIT ""   /* chassis      */  
    FIELD engcc           AS CHAR FORMAT "x(5)"  INIT ""   /* weight       */  
    FIELD vehreg          AS CHAR FORMAT "x(10)" INIT ""   /* licence no   */  
    FIELD garage          AS CHAR FORMAT "x(1)"  INIT ""   /* garage       */  
    FIELD idno            AS CHAR FORMAT "X(20)" INIT ""   /* fleet disc.  */  
    FIELD vehuse          AS CHAR FORMAT "x(1)"  INIT ""   /* vehuse       */  
    FIELD comdat          AS CHAR FORMAT "x(10)" INIT ""   /* comdat       */  
    FIELD si              AS CHAR FORMAT "x(15)" INIT ""   /* sum si       */  
    FIELD fire            AS CHAR FORMAT "x(15)" INIT ""   
    FIELD premt           AS CHAR FORMAT "x(15)" INIT ""   /*  prem.1            */  
    FIELD stk             AS CHAR FORMAT "x(25)" INIT ""   /* sticker            */  
    FIELD brand           AS CHAR FORMAT "x(50)" INIT ""   /* brand              */     
    FIELD addr1           AS CHAR FORMAT "x(100)" INIT ""  /* address1           */     
    FIELD addr2           AS CHAR FORMAT "x(60)" INIT ""   /* address2           */     
    FIELD tiname          AS CHAR FORMAT "x(30)" INIT ""   /* title name         */     
    FIELD insnam          AS CHAR FORMAT "x(55)" INIT ""   /* first name         */     
    FIELD benname         AS CHAR FORMAT "x(65)" INIT ""   /* beneficiary        */     
    FIELD cedpol          AS CHAR FORMAT "x(10)"  INIT ""  /* account no.        */     
    FIELD expdat          AS CHAR FORMAT "x(10)" INIT ""   /* expiry date        */     
    FIELD re_country      AS CHAR FORMAT "x(18)" INIT ""   /* province           */     
    FIELD receipt_name    AS CHAR FORMAT "x(50)" INIT ""   /* receipt name       */     
    FIELD prepol          AS CHAR FORMAT "x(25)" INIT ""   /* old policy         */     
    FIELD ncb             AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
    FIELD add1_70         AS CHAR FORMAT "X(50)" INIT ""   /* �������˹�ҵ��ҧ70 */     
    FIELD add2_70         AS CHAR FORMAT "X(60)" INIT ""   /* �������˹�ҵ��ҧ70�ó�����¡�������*/     
    FIELD tp1             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Person       */     
    FIELD tp2             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Per Acciden  */     
    FIELD tp3             AS CHAR FORMAT "X(14)" INIT ""   /* TPPD/Per Acciden  */     
    FIELD covcod          AS CHAR FORMAT "x(1)"  INIT ""   /* covcod            */     
    FIELD cndat           AS CHAR FORMAT "x(10)" INIT ""   
    FIELD tambon          AS CHAR FORMAT "x(35)" INIT ""    
    FIELD amper           AS CHAR FORMAT "x(35)" INIT ""    
    FIELD country         AS CHAR FORMAT "x(35)" INIT ""    
    FIELD compul          AS CHAR FORMAT "x"        INIT "" 
    FIELD model           AS CHAR FORMAT "x(50)"    INIT ""   
    FIELD seat            AS CHAR FORMAT "x(2)"     INIT ""    
    FIELD comper          AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD comacc          AS CHAR FORMAT "x(14)"    INIT ""    
    FIELD deductpd       AS CHAR FORMAT "X(14)"     INIT ""     
    FIELD deductpd2       AS CHAR FORMAT "X(14)"    INIT ""  
    FIELD cargrp         AS CHAR FORMAT "x"         INIT ""     
    FIELD body           AS CHAR FORMAT "x(40)"     INIT ""     
    FIELD NO_41          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD NO_42          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD NO_43          AS CHAR FORMAT "x(14)"     INIT ""  
    FIELD comment        AS CHAR FORMAT "x(512)"    INIT ""
    FIELD agent          AS CHAR FORMAT "x(10)"     INIT ""   
    FIELD producer       AS CHAR FORMAT "x(10)"     INIT ""   
    FIELD entdat         AS CHAR FORMAT "x(10)"     INIT ""      
    FIELD enttim         AS CHAR FORMAT "x(8)"      INIT ""       
    FIELD trandat        AS CHAR FORMAT "x(10)"     INIT "" 
    FIELD firstdat       AS CHAR FORMAT "x(10)"     INIT ""  
    FIELD trantim        AS CHAR FORMAT "x(8)"      INIT ""       
    FIELD n_IMPORT       AS CHAR FORMAT "x(2)"      INIT ""       
    FIELD n_EXPORT       AS CHAR FORMAT "x(2)"      INIT "" 
    FIELD pass           AS CHAR FORMAT "x"         INIT "n"
    FIELD OK_GEN         AS CHAR FORMAT "X"         INIT "Y" 
    FIELD renpol         AS CHAR FORMAT "x(32)"     INIT ""     
    FIELD cr_2           AS CHAR FORMAT "x(32)"     INIT ""  
    FIELD namerequest    AS CHAR FORMAT "x(50)"     INIT ""  
    FIELD daterequest    AS CHAR FORMAT "x(20)"     INIT ""  
    FIELD nocheck        AS CHAR FORMAT "x(30)"     INIT ""  
    FIELD docno          AS CHAR INIT "" FORMAT "x(10)" 
    FIELD redbook        AS CHAR INIT "" FORMAT "X(8)"
    FIELD drivnam        AS CHAR FORMAT "x"     INIT "n" 
    FIELD tariff         AS CHAR FORMAT "x(2)"  INIT "9"
    FIELD tons           AS DECI FORMAT "9999.99"  INIT ""
    FIELD cancel         AS CHAR FORMAT "x(2)"  INIT ""    
    FIELD accdat         AS CHAR INIT "" FORMAT "x(10)"   
    FIELD prempa         AS CHAR FORMAT "x"     INIT ""       
    FIELD subclass       AS CHAR FORMAT "x(5)"  INIT ""    
    FIELD fleet          AS CHAR FORMAT "x(10)" INIT ""   
    FIELD WARNING        AS CHAR FORMAT "X(30)" INIT ""
    FIELD seat41         AS INTE FORMAT "99"    INIT 0
    FIELD volprem        AS CHAR FORMAT "x(20)" INIT "" 
    FIELD n_branch       AS CHAR FORMAT "x(5)"  INIT "" .
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.                       
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.                       
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.                       
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.             
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.                        
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.             
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".                      
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.                       
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.                       
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.                      
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.                       
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.                      
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "". 
DEF  var  nv_row  as  int  init  0.                       
DEFINE STREAM  ns1.                                        
DEFINE STREAM  ns2.                                         
DEFINE STREAM  ns3.                                        
DEF VAR nv_uom1_v AS INTE INIT 0.                     
DEF VAR nv_uom2_v AS INTE INIT 0.                     
DEF VAR nv_uom5_v AS INTE INIT 0.                     
DEF VAR chkred    AS logi INIT NO.                   
DEF VAR nv_comper  AS DECI INIT 0.                       
DEF VAR nv_comacc  AS DECI INIT 0.                       
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .       
def var nv_chk as  logic.                                
DEF VAR nv_ncbyrs AS INTE.                               
DEF VAR  NO_CLASS AS CHAR INIT "".                       
def var  s_recid1       as RECID .     /* uwm100  */                    
def var  s_recid2       as recid .     /* uwm120  */                    
def var  s_recid3       as recid .     /* uwm130  */                    
def var  s_recid4       as recid .     /* uwm301  */                    
DEF VAR nv_provi   AS   CHAR INIT "".                                   
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".              
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".                
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.     
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/                              
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */                              
def var s_riskgp    AS INTE FORMAT ">9".                                                         
def var s_riskno    AS INTE FORMAT "999".                                                        
def var s_itemno    AS INTE FORMAT "999".                                                        
DEF VAR nv_drivage1 AS INTE INIT 0.                                
DEF VAR nv_drivage2 AS INTE INIT 0.                                
DEF VAR nv_drivbir1 AS CHAR INIT "".                               
DEF VAR nv_drivbir2 AS CHAR INIT "".                               
def var nv_dept     as char format  "X(1)".       
def var nv_undyr    as    char  init  ""    format   "X(4)".       
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.            
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.      
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.    
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.    
DEF VAR s_130bp1    AS RECID                 NO-UNDO.      
DEF VAR s_130fp1    AS RECID                 NO-UNDO.      
DEF VAR nvffptr     AS RECID                 NO-UNDO.      
DEF VAR n_rd132     AS RECID                 NO-UNDO.      
DEF VAR nv_gap      AS DECIMAL               NO-UNDO.      
DEF VAR nv_fptr     AS RECID.                           
DEF VAR nv_bptr     AS RECID.                           
DEF VAR nv_nptr     AS RECID.                           
DEF VAR nv_gap2     AS DECIMAL               NO-UNDO.              
DEF VAR nv_prem2    AS DECIMAL               NO-UNDO.              
DEF VAR nv_rstp     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_rtax     AS DECIMAL               NO-UNDO.                                
DEF VAR nv_key_a    AS DECIMAL INITIAL 0     NO-UNDO.                                 
DEF VAR nv_rec100   AS RECID .                                       
DEF VAR nv_rec120   AS RECID .                                                                   
DEF VAR nv_rec130   AS RECID .                                                                  
DEF VAR nv_rec301   AS RECID .                                                                   
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0  NO-UNDO.                                 
DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".                                
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.                       
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.           
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".                                   
DEFINE VAR nv_maxdes AS CHAR.                                                   
DEFINE VAR nv_mindes AS CHAR.                                                   
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */  
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */  
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".                           
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".                    
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR NO-UNDO.                                                


