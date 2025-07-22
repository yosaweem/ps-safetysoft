/*programid   : wgwnsgen.i                                               */ 
/*programname : Load text file LOCKTON [NISSAN] to GW                            */ 
/*Copyright   : Safety Insurance Public Company Limited 			     */ 
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				         */ 
/*create by   : Kridtiya i. A56-0299  date .                  
                ปรับโปรแกรมให้สามารถนำเข้า text file Lockton[nissan] to GW system  */ 
/*************************************************************************/ 
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy          AS CHAR FORMAT "x(25)"  INIT ""  /* notify number*/  
    FIELD poltyp          AS CHAR FORMAT "x(3)"   INIT ""  /* policy       */                
    FIELD cedpol          AS CHAR FORMAT "x(10)"  INIT ""  /* account no.  */     
    FIELD tiname          AS CHAR FORMAT "x(30)" INIT ""   /* title name   */     
    FIELD insnam          AS CHAR FORMAT "x(55)" INIT ""   /* first name   */     
    FIELD insnam2         AS CHAR FORMAT "x(40)" INIT ""   /* first name   */     
    FIELD insnam3         AS CHAR FORMAT "x(40)" INIT ""                   
    FIELD add1            AS CHAR FORMAT "x(100)" INIT ""  /* address1     */     
    FIELD add2            AS CHAR FORMAT "x(100)" INIT ""  /* address1     */  
    FIELD add3            AS CHAR FORMAT "x(100)" INIT ""  /* address1     */  
    FIELD add4            AS CHAR FORMAT "x(100)" INIT ""  /* address1     */
    FIELD tambon          AS CHAR FORMAT "x(35)" INIT ""    
    FIELD amper           AS CHAR FORMAT "x(35)" INIT ""    
    FIELD country         AS CHAR FORMAT "x(35)" INIT ""    
    FIELD caryear         AS CHAR FORMAT "x(4)"  INIT ""   /* year         */  
    FIELD eng             AS CHAR FORMAT "x(25)" INIT ""   /* engine       */  
    FIELD chasno          AS CHAR FORMAT "x(25)" INIT ""   /* chassis      */  
    FIELD engcc           AS CHAR FORMAT "x(5)"  INIT ""   /* weight       */  
    FIELD vehgrp          AS CHAR FORMAT "x(1)"  INIT ""   /* Vehicle Group      */
    FIELD vehreg          AS CHAR FORMAT "x(11)" INIT ""   /* licence no   */      /*A54-0112*/
    FIELD garage          AS CHAR FORMAT "x(1)"  INIT ""   /* garage       */  
    FIELD vehuse          AS CHAR FORMAT "x(1)"  INIT ""   /* vehuse       */  
    FIELD comdat          AS DATE   INIT ?                 /* comdat       */  
    FIELD expdat          AS DATE   INIT ?                 /* expiry date        */   
    FIELD si              AS CHAR FORMAT "x(15)" INIT ""   /* sum si       */  
    FIELD fire            AS CHAR FORMAT "x(15)" INIT ""   
    FIELD premt           AS CHAR FORMAT "x(15)" INIT ""   /*  prem.1            */  
    FIELD stk             AS CHAR FORMAT "x(25)" INIT ""   /* sticker            */  
    FIELD brand           AS CHAR FORMAT "x(50)" INIT ""   /* brand              */     
    FIELD benname         AS CHAR FORMAT "x(65)" INIT ""   /* beneficiary        */ 
    FIELD icno            AS CHAR FORMAT "x(13)"  INIT ""
    FIELD branch          AS CHAR FORMAT "x(5)"  INIT ""
    FIELD accesstxt       AS CHAR FORMAT "x(100)" INIT ""  
    FIELD receipt_name    AS CHAR FORMAT "x(50)" INIT ""   /* receipt name       */  
    FIELD prepol          AS CHAR FORMAT "x(25)" INIT ""   /* old policy         */     
    FIELD ncb             AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
    FIELD dspc            AS CHAR FORMAT "X(10)"  INIT ""  /* deduct disc.       */     
    FIELD tp1             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Person       */     
    FIELD tp2             AS CHAR FORMAT "X(14)" INIT ""   /* TPBI/Per Acciden  */     
    FIELD tp3             AS CHAR FORMAT "X(14)" INIT ""   /* TPPD/Per Acciden  */     
    FIELD covcod          AS CHAR FORMAT "x(1)"  INIT ""   /* covcod            */     
    FIELD cndat           AS CHAR FORMAT "x(10)" INIT ""   
    FIELD compul          AS CHAR FORMAT "x"        INIT "" 
    FIELD model           AS CHAR FORMAT "x(50)"    INIT ""   
    FIELD seat            AS CHAR FORMAT "x(2)"     INIT ""    
    FIELD remark          AS CHAR FORMAT "x(100)"     INIT ""    
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
    FIELD vatcode        AS CHAR FORMAT "x(10)"     INIT ""
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
    FIELD delerno        AS CHAR FORMAT "x(20)"     INIT ""  
    FIELD delername      AS CHAR FORMAT "x(60)"     INIT ""  
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
    FIELD GenStatus      AS CHAR FORMAT "x(10)" INIT "" .

DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0. 
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO. 
DEFINE NEW SHARED VAR  nv_batchyr_old   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt_old    AS INT FORMAT "99"              INIT 0. 
DEFINE NEW SHARED VAR  nv_batchno_old   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO. 
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
DEF VAR nv_txt1  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt2  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt3  AS CHAR FORMAT "x(100)"  .
DEF VAR nv_txt4  AS CHAR FORMAT "x(100)"  .
/*Add kridtiya i. A56-0037  */
DEFINE VAR  np_no            AS CHAR FORMAT "x(10)"  INIT "".   /* 1   No. */                                                                               
DEFINE VAR  np_cedpol        AS CHAR FORMAT "x(20)"  INIT "".   /* 2   TN# เลขที่สัญญา*/                                                                                 
DEFINE VAR  np_companynam    AS CHAR FORMAT "x(50)"  INIT "".   
DEFINE VAR  np_senddate      AS CHAR FORMAT "x(10)"  INIT "".   /* 3   วันที่แจ้งประกันภัย */                                                                 
DEFINE VAR  np_insurcename   AS CHAR FORMAT "x(50)"  INIT "".   /* 4   ชื่อผู้เอาประกันภัย */                                                                 
DEFINE VAR  np_ntitle        AS CHAR FORMAT "x(20)"  INIT "".   
DEFINE VAR  np_insurceno     AS CHAR FORMAT "x(10)"  INIT "".   /* 5   รหัสลูกค้า  */                                                                         
DEFINE VAR  np_addr1         AS CHAR FORMAT "x(100)" INIT "".   /* 6   ที่อยู่ผู้เอาประกันภัย  */                                                             
DEFINE VAR  np_model         AS CHAR FORMAT "x(60)"  INIT "".   /* 7   ยี่ห้อ/รุ่น */                                                                         
DEFINE VAR  np_vehreg        AS CHAR FORMAT "x(30)"  INIT "".   /* 8   ทะเบียนรถ   */  /*A54-0112*/
DEFINE VAR  np_caryear       AS CHAR FORMAT "X(4)"   INIT "".   /* 9   ปีจดทะเบียน */                                                                         
DEFINE VAR  np_cha_no        AS CHAR FORMAT "x(30)"  INIT "".   /* 10  เลขตัวถัง   */                                                                         
DEFINE VAR  np_engno         AS CHAR FORMAT "x(30)"  INIT "".   /* 11  เลขเครื่องยนต์  */                                                                     
DEFINE VAR  np_engCC         AS CHAR FORMAT "x(4)"   INIT "".   /* 12  ขนาดเครื่องยนต์ */                                                                     
DEFINE VAR  np_benname       AS CHAR FORMAT "x(40)"  INIT "".   /* 13  ผู้รับผลประโยชน์    */                                                                 
DEFINE VAR  np_showroomno    AS CHAR FORMAT "x(50)"  INIT "".   /* 14  โชว์รูม     */                                                                         
DEFINE VAR  np_showroom2     AS CHAR FORMAT "x(50)"  INIT "".   /* 14  โชว์รูม     */                                                                         
DEFINE VAR  np_stkno         AS CHAR FORMAT "x(20)"  INIT "".   /* 15  เครื่องหมาย พรบ */                                                                     
DEFINE VAR  np_pol72         AS CHAR FORMAT "x(15)"  INIT "".   /* 16  กรมธรรม์ พรบ    */                                                                     
DEFINE VAR  np_garage        AS CHAR FORMAT "x(30)"  INIT "".   /* 17  ศูนย์ซ่อมรถ */                                                                         
DEFINE VAR  np_covcod        AS CHAR FORMAT "x(30)"  INIT "".   /* 18  ประเภทความคุ้มครอง  */                                                                 
DEFINE VAR  np_comdate       AS CHAR FORMAT "x(10)"  INIT "".   /* 19  วันที่เริ่มคุ้มครอง */                                                                 
DEFINE VAR  np_si            AS CHAR FORMAT "x(20)"  INIT "".   /* 20  ทุนประกันภัย    */                                                                     
DEFINE VAR  np_premt         AS CHAR FORMAT "x(20)"  INIT "".   /* 21  เบี้ยประกันภัยภาคสมัครใจ    */                                                         
DEFINE VAR  np_premtcomp     AS CHAR FORMAT "x(20)"  INIT "".   /* 22  เบี้ยประกันภัยรวม พรบ   */                                                          
DEFINE VAR  np_deduct        AS CHAR FORMAT "X(20)"  INIT "".   /* 23  ความเสียหายส่วนแรก  */                                                                  
DEFINE VAR  np_tper          AS CHAR FORMAT "x(20)"  INIT "".   /* 24  ความรับผิดต่อบุคคลภายนอก (บาดเจ็บหรือเสียชีวิต ต่อคน)   */                              
DEFINE VAR  np_tpbi          AS CHAR FORMAT "x(20)"  INIT "".   /* 25  ความรับผิดต่อบุคคลภายนอก (บาดเจ็บหรือเสียชีวิต ต่อครั้ง)    */                          
DEFINE VAR  np_tppd          AS CHAR FORMAT "x(20)"  INIT "".   /* 26  ความรับผิดต่อบุคคลภายนอก (ทรัพย์สิน ต่อครั้ง)   */                                      
DEFINE VAR  np_si1           AS CHAR FORMAT "x(20)"  INIT "".   /* 27  ความเสียหายต่อรถยนต์ที่เอาประกันภัย(ความเสียหายต่อตัวรถ)    */                          
DEFINE VAR  np_fire          AS CHAR FORMAT "x(20)"  INIT "".   /* 28  ความเสียหายต่อรถยนต์ที่เอาประกันภัย(การสูญหายและไฟไหม้) */                               
DEFINE VAR  np_41            AS CHAR FORMAT "x(20)"  INIT "".   /* 29  ขยายความคุ้มครอง(การประกันอุบัติเหตุส่วนบุคคล คนละ) */                                 
DEFINE VAR  np_42            AS CHAR FORMAT "x(20)"  INIT "".   /* 30  ขยายความคุ้มครอง(การประกันค่ารักษาพยาบาล คนละ)  */             
DEFINE VAR  np_43            AS CHAR FORMAT "x(20)"  INIT "".   /* 31  ขยายความคุ้มครอง(การประกันตัวผู้ขับขี่คดีอาญา)  */                                                    
DEFINE VAR  np_feet          AS CHAR FORMAT "x(20)"  INIT "".   /* 32  ส่วนลดกลุ่ม */                                                                                        
DEFINE VAR  np_ncb           AS CHAR FORMAT "x(20)"  INIT "".   /* 33  ส่วนลดประวัติดี */                                                                                    
DEFINE VAR  np_other         AS CHAR FORMAT "x(20)"  INIT "".   /* 34  ส่วนลดอื่น ๆ  */                                             
DEFINE VAR  np_seats         AS CHAR FORMAT "x(3)"   INIT "".   /* 35  จำนวนที่นั่ง */                                             
DEFINE VAR  np_remark        AS CHAR FORMAT "x(100)" INIT "".   /* 36  หมายเหตุ  */                                                 
DEFINE VAR  np_recivename    AS CHAR FORMAT "x(50)"  INIT "".   /* 37  ออกใบเสร็จในนาม */                                             
DEFINE VAR  np_reciveaddr    AS CHAR FORMAT "x(100)" INIT "".   /* 38  ที่อยู่ในใบเสร็จ*/                                         
DEFINE VAR  np_recivename2   AS CHAR FORMAT "x(50)"  INIT "".   /* 37  ออกใบเสร็จในนาม */                                             
DEFINE VAR  np_reciveaddr2   AS CHAR FORMAT "x(100)" INIT "".   /* 38  ที่อยู่ในใบเสร็จ*/                                         
DEFINE VAR  np_accessory     AS CHAR FORMAT "x(30)"  INIT "".   /* 39  ContractNo  */                                                 
DEFINE VAR  np_subclass      AS CHAR FORMAT "x(10)"  INIT "".   /* 40  UserClosing */                                                 
DEFINE VAR  np_campaign      AS CHAR FORMAT "x(30)"  INIT "".   /* 41  Campaign    */ 
DEFINE VAR  np_icno          AS CHAR FORMAT "x(20)"  INIT "".   /* 42  icno    */  /*A56-0243*/
/* Add kridtiya i. A56-0037      */
            
