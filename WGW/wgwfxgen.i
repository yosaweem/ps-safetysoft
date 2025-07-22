/*programid   : wgwfxgen.i                                                                 */ 
/*programname : load text file fax to GW                                                   */ 
/* Copyright  : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A56-0024  date . 04/02/2013                                    */ 
/*              เพิ่มโปรแกรมนำเข้างานรับประกันภัยทางแฟกซ์                                  */ 
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD recno            AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD Notify_dat       AS CHAR FORMAT "X(10)"  INIT ""    /*  1  วันที่รับแจ้ง   */                        
    FIELD time_notify      AS CHAR FORMAT "X(10)"  INIT ""    /*  2  วันที่รับเงินค่าเบิ้ยประกัน */            
    FIELD notifyno         AS CHAR FORMAT "X(30)"  INIT ""    /*  3  รายชื่อบริษัทประกันภัย  */                
    FIELD comp_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  4  เลขที่สัญญาเช่าซื้อ */                    
    FIELD NAME_mkt         AS CHAR FORMAT "X(45)"  INIT ""    /*  5  เลขที่กรมธรรม์เดิม  */                    
    FIELD cmbr_no          AS CHAR FORMAT "X(30)"  INIT ""    /*  6  รหัสสาขา    */                            
    FIELD cmbr_code        AS CHAR FORMAT "X(20)"  INIT ""    /*  7  สาขา KK */                                
    FIELD branch           AS CHAR FORMAT "X(10)"  INIT ""    /*  8  เลขรับเเจ้ง */                            
    FIELD producer         AS CHAR FORMAT "X(15)"  INIT ""    /*  9  Campaign    */                            
    FIELD agent            AS CHAR FORMAT "X(15)"  INIT ""    /*  10 Sub Campaign    */      
    FIELD deler            AS CHAR FORMAT "X(10)"  INIT ""    /*     deler       */       
    FIELD campaigno        AS CHAR FORMAT "X(20)"  INIT ""    /*  11 บุคคล/นิติบุคคล */                        
    FIELD cov_car          AS CHAR FORMAT "X(20)"  INIT ""    /*  12 คำนำหน้าชื่อ    */                        
    FIELD cov_new          AS CHAR FORMAT "X(20)"  INIT ""    /*  13 ชื่อผู้เอาประกัน    */                    
    FIELD covcod           AS CHAR FORMAT "X(20)"  INIT ""    /*  14 นามสกุลผู้เอาประกัน */  
    FIELD product          AS CHAR FORMAT "X(30)"  INIT ""    /*  Add A55-0073   */
    FIELD freeprem         AS CHAR FORMAT "X(20)"  INIT ""    /*  15 บ้านเลขที่  */                            
    FIELD freecomp         AS CHAR FORMAT "X(20)"  INIT ""    /*  21 ตำบล/แขวง   */                            
    FIELD comdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  22 อำเภอ/เขต   */                            
    FIELD expdat           AS CHAR FORMAT "X(10)"  INIT ""    /*  23 จังหวัด */                                
    FIELD ispno            AS CHAR FORMAT "X(30)"  INIT ""    /*  24 รหัสไปรษณีย์    */ /*A55-0046*/                       
    FIELD pol70            AS CHAR FORMAT "X(20)"  INIT ""    /*  24 รหัสไปรษณีย์    */                        
    FIELD pol72            AS CHAR FORMAT "X(20)"  INIT ""    /*  25 ประเภทความคุ้มครอง  */                    
    FIELD n_TITLE          AS CHAR FORMAT "X(20)"  INIT ""    /*  26 ประเภทการซ่อม   */                        
    FIELD n_name1          AS CHAR FORMAT "X(60)"  INIT ""    /*  27 วันเริ่มคุ้มครอง    */                    
    FIELD ADD_1            AS CHAR FORMAT "X(150)" INIT ""    /*  28 วันสิ้นสุดคุ้มครอง  */                    
    FIELD ADD_2            AS CHAR FORMAT "X(35)"  INIT ""    /*  29 รหัสรถ  */                                
    FIELD ADD_3            AS CHAR FORMAT "X(35)"  INIT ""    /*  30 ประเภทประกันภัยรถยนต์   */                
    FIELD ADD_4            AS CHAR FORMAT "X(35)"  INIT ""    /*  31 ชื่อยี่ห้อรถ    */                        
    FIELD ADD_5            AS CHAR FORMAT "X(10)"  INIT ""    /*  32 รุ่นรถ  */                                
    FIELD tel              AS CHAR FORMAT "X(30)"  INIT ""    /*  33 New/Used    */                            
    FIELD brand            AS CHAR FORMAT "X(20)"  INIT ""    /*  34 เลขทะเบียน  */                            
    FIELD model            AS CHAR FORMAT "X(50)"  INIT ""    /*  35 เลขตัวถัง   */                            
    FIELD engine           AS CHAR FORMAT "X(30)"  INIT ""    /*  36 เลขเครื่องยนต์  */                        
    FIELD chassis          AS CHAR FORMAT "X(30)"  INIT ""    /*  37 ปีรถยนต์    */                            
    FIELD power            AS CHAR FORMAT "X(10)"  INIT ""    /*  38 ซีซี    */                                
    FIELD cyear            AS CHAR FORMAT "X(10)"  INIT ""    /*  39 น้ำหนัก/ตัน */                            
    FIELD licence          AS CHAR FORMAT "X(30)"  INIT ""    /*  40 ทุนประกันปี 1   */                        
    FIELD provin           AS CHAR FORMAT "X(30)"  INIT ""    /*  41 เบี้ยรวมภาษีเเละอากรปี 1    */            
    FIELD subclass         AS CHAR FORMAT "X(10)"  INIT ""    /*  42 ทุนประกันปี 2   */                        
    FIELD garage           AS CHAR FORMAT "X(2)"   INIT ""    /*  43 เบี้ยรวมภาษีเเละอากรปี 2    */            
    FIELD ins_amt1         AS CHAR FORMAT "X(20)"  INIT ""    /*  44 เวลารับเเจ้ง    */                        
    FIELD prem1            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 ชื่อเจ้าหน้าที่ MKT */                    
    FIELD prem2            AS CHAR FORMAT "X(20)"  INIT ""    /*  45 ชื่อเจ้าหน้าที่ MKT */                    
    FIELD comprem          AS CHAR FORMAT "X(20)"  INIT ""    /*  46 หมายเหตุ    */                            
    FIELD prem3            AS CHAR FORMAT "X(20)"  INIT ""    /*  47 ผู้ขับขี่ที่ 1 เเละวันเกิด  */            
    FIELD sck              AS CHAR FORMAT "X(20)"  INIT ""    /*  48 ผู้ขับขี่ที่ 2 เเละวันเกิด  */            
    FIELD ref              AS CHAR FORMAT "X(30)"  INIT ""    /*  49 คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */    
    FIELD recivename       AS CHAR FORMAT "X(60)"  INIT ""    /*  50 ชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */            
    FIELD vatcode          AS CHAR FORMAT "X(15)"  INIT ""    /*  51 นามสกุล (ใบเสร็จ/ใบกำกับภาษี)   */        
    FIELD notiuser         AS CHAR FORMAT "X(50)"  INIT ""    /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)*/    
    FIELD bennam           AS CHAR FORMAT "X(55)"  INIT ""    /*  57 ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */        
    FIELD remak1           AS CHAR FORMAT "X(100)" INIT ""    /*  58 อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */        
    FIELD statusco         AS CHAR FORMAT "X(35)"  INIT ""    /*  59 จังหวัด (ใบเสร็จ/ใบกำกับภาษี)   */      
    FIELD idno             AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday         AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins         AS CHAR FORMAT "X(100)" INIT ""  
    FIELD namedirect       AS CHAR FORMAT "X(100)" INIT ""
    FIELD driv_no          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD drivname1        AS CHAR FORMAT "X(100)" INIT "" 
    FIELD sexdri1          AS CHAR FORMAT "X(6)"   INIT "" 
    FIELD birthdri1        AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD idexpdat         AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD occupdri1        AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD idnodri1         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2        AS CHAR FORMAT "X(100)" INIT ""  
    FIELD sexdri2          AS CHAR FORMAT "X(6)"   INIT ""    
    FIELD birthdri2        AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD occupdri2        AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD idnodri2         AS CHAR FORMAT "X(20)"  INIT "" .
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""     /*  11 บุคคล/นิติบุคคล */                        
    FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""     /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)    */    
    FIELD branch      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""     /*policy type*/
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT ""     /*policy*//*a40166 chg format from 12 to 16*/
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""     /*comm date*/
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""     /*expiry date*/
    FIELD compul      AS CHAR FORMAT "x"      INIT ""     /*compulsory*/
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""     /*title*/
    FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""     /*name*/
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""     /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""     /*sub class*/
    FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""     /*vehicl registration*/
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""     /*engine no*/
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""     /*chasis no*/
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""     
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""     /*vehicle use*/
    FIELD garage      AS CHAR FORMAT "x"      INIT ""     
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""     
    FIELD access      AS CHAR FORMAT "x"      INIT ""     /*accessories*/
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""     /*cover type*/
    FIELD product     AS CHAR FORMAT "X(30)"  INIT ""     /*  Add A55-0073   */
    FIELD si          AS CHAR FORMAT "x(25)"  INIT ""     /*sum insure*/
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT ""     /*voluntory premium*/
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD deductpp    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductba    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct da*/
    FIELD deductpa    AS CHAR FORMAT "x(10)"  INIT ""    /*deduct pd*/
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""    /*benificiary*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD cancel      AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD WARNING     AS CHAR FORMAT "X(30)"  INIT ""
    FIELD comment     AS CHAR FORMAT "x(512)" INIT ""    
    FIELD seat41      AS INTE FORMAT "99"     INIT 0         
    FIELD pass        AS CHAR FORMAT "x"      INIT "n"       
    FIELD OK_GEN      AS CHAR FORMAT "X"      INIT "Y"        
    FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43       AS CHAR INIT "200000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD deler       AS CHAR FORMAT "X(10)" INIT ""         
    FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
    FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""       
    FIELD idno        AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD birthday    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins    AS CHAR FORMAT "X(100)" INIT ""   
    FIELD namedirect  AS CHAR FORMAT "X(100)" INIT ""  
    FIELD drivname1   AS CHAR FORMAT "X(100)" INIT "" 
    FIELD idnodri1    AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2   AS CHAR FORMAT "X(100)" INIT ""  
    FIELD idnodri2    AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD notifydat   AS CHAR FORMAT "X(60)"  INIT "" .
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
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
DEF VAR n_model AS CHAR FORMAT "x(40)".
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
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
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 
DEFINE VAR n_insref   AS CHARACTER FORMAT "X(10)".  
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer AS LOGICAL   .
DEF VAR n_check     AS CHARACTER . 
DEF VAR nv_insref   AS CHARACTER FORMAT "X(10)".  
DEF VAR putchr      AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100   FOR sic_bran.uwm100. 
DEF  STREAM ns1.  
DEF  VAR nv_type  AS INTEGER  LABEL "Type".   
