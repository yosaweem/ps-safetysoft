/*Programid   : wgwtscb1.w                                                                 */ 
/*programname : load text file SCB to GW                                                   */ 
/*Copyright   : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A56-0222 date . 27/06/2013                                     */ 
/*              เพิ่มโปรแกรมนำเข้างานต่ออายุ ธนาคารไทยพาณิชย์                              */
/*Modify by   : Kridtiya i. A58-0183 Add field for Layout new                              */
/*Modify by   : Sarinya c. A59-0396 add เบี้ยประกัน 2+ 3+                                  */
/*Modify by   : Sarinya C. A59-0426 add ปรับการนำเข้าเบี้ย Class Z                         */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....   */
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย                           */
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD policy      AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD notifydat   AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD notiuser    AS CHAR FORMAT "X(60)"  INIT ""  
    FIELD company     AS CHAR FORMAT "X(40)"  INIT ""    /*  11 บุคคล/นิติบุคคล */                        
    FIELD insnam      AS CHAR FORMAT "x(60)"  INIT ""    /*name*/
    FIELD name2       AS CHAR FORMAT "x(60)"  INIT ""    /*name*/
    FIELD name3       AS CHAR FORMAT "x(60)"  INIT ""    /*name*/
    FIELD prepol      AS CHAR FORMAT "x(20)"  INIT ""    
    FIELD body        AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD brand       AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""    
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""    /*vehicl registration*//*A54-0112*/
    FIELD provin      AS CHAR FORMAT "x(20)"  INIT ""    /*vehicl registration*//*A54-0112*/
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""    /*chasis no*/
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""    /*engine no*/
    FIELD covcod      AS CHAR FORMAT "x(20)"  INIT ""    /*cover type*/
    FIELD covcod1      AS CHAR FORMAT "x(20)"  INIT ""    /*A58-0183 cover type*/
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""    /*comm date*/
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT ""    /*voluntory premium*/
    FIELD premt       AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD si          AS CHAR FORMAT "x(25)"  INIT ""    /*sum insure*/
    FIELD fi          AS CHAR FORMAT "x(25)"  INIT ""    /*sum insure*/
    FIELD garage      AS CHAR FORMAT "x(25)"  INIT ""    
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)"    
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT ""    
    FIELD comdatcomp  AS CHAR FORMAT "x(10)"  INIT ""    /*expiry date*/
    FIELD precomp     AS CHAR FORMAT "x(20)"  INIT ""    /*expiry date*/
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD iadd5       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD comper      AS CHAR FORMAT "x(150)" INIT ""    
    FIELD comacc      AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD NO_41       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD NO_42       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD NO_43       AS CHAR FORMAT "x(45)"  INIT ""    
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""    
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""    
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD branch      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""    /*A55-0046*/
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""    /*policy type*/
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""    /*expiry date*/
    FIELD compul      AS CHAR FORMAT "x"      INIT ""    /*compulsory*/
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""    /*title*/
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""    /*premium package*/
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""    /*sub class*/
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""    /*vehicle use*/
    FIELD access      AS CHAR FORMAT "x"      INIT ""    /*accessories*/
    FIELD product     AS CHAR FORMAT "X(30)"  INIT ""    /*  Add A55-0073   */
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD deduct      AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD driverno    AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD driverid    AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD accessprm   AS CHAR FORMAT "x(150)"  INIT ""  
    FIELD statusno    AS CHAR FORMAT "x(30)"  INIT ""  
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""    /*benificiary*/
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD cancel      AS CHAR FORMAT "x(2)"   INIT ""    /*cancel*/
    FIELD WARNING     AS CHAR FORMAT "X(30)"  INIT ""    
    FIELD comment     AS CHAR FORMAT "x(512)" INIT ""    /*a490166 add format from 100 to 512*/
    FIELD seat41      AS INTE FORMAT "99"     INIT 0     
    FIELD pass        AS CHAR FORMAT "x"      INIT "n"       
    FIELD OK_GEN      AS CHAR FORMAT "X"      INIT "Y"        
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""      
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     /*note add*/
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     /*Note add Base Premium 25/09/2006*/
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    /*Account Date For 72*/
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    /*Docno For 72*/
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"   
    FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""   /*A55-0046*/   
    FIELD idno        AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD occup       AS CHAR FORMAT "x(100)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD insnamtyp   AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

    /* comment by Sarinya A59-0426 */
   /* FIELD drivername1 AS CHAR FORMAT "x(80)"  INIT ""    /*A59-0396*/
    FIELD drivnam     AS CHAR FORMAT "x" INIT "n"        /*A59-0396*/
    FIELD tpfire      AS CHAR FORMAT "x(14)" INIT ""     /*A59-0396*/
    FIELD deductda    AS CHAR FORMAT "X(14)" INIT ""     /*A59-0396*/
    FIELD deductpd    AS CHAR FORMAT "X(14)" INIT ""     /*A59-0396*/
    FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""     /*A59-0396 fleet*/
    FIELD dspp        AS CHAR FORMAT "x(10)" INIT ""     /*A59-0396 dspp*/
    FIELD uom1_v      AS CHAR FORMAT "x(10)" INIT ""
    FIELD uom2_v      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD uom5_v      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD drivername2 AS CHAR FORMAT "x(80)" INIT "" */  .  /*A59-0396*/
   /* end comment by Sarinya A59-0426 */




DEF VAR n_firstdat    AS CHAR FORMAT "x(10)" INIT ""  .  
def    NEW SHARED VAR nv_message   as   char.
DEF VAR               nv_riskgp    LIKE sicuw.uwm120.riskgp       NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm   AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg   AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat    AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno     AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR nv_batchyr   AS INT FORMAT "9999"         INIT 0.
DEFINE NEW SHARED VAR nv_batcnt    AS INT FORMAT "99"           INIT 0.
DEFINE NEW SHARED VAR nv_batchno   AS CHARACTER FORMAT "X(13)"  INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.  /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".  /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.   /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.   /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
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
def var np_dano         AS CHAR FORMAT "x(20)"  INIT "". 
def var np_datenoti     AS CHAR FORMAT "X(20)"  INIT "". 
def var np_namenoti     AS CHAR FORMAT "X(60)"  INIT "".  
def var np_company      AS CHAR FORMAT "X(40)"  INIT "".    /*  11 บุคคล/นิติบุคคล */                        
def var np_insname      AS CHAR FORMAT "x(60)"  INIT "".    /*name*/
def var np_prepol       AS CHAR FORMAT "x(20)"  INIT "".    
DEF VAR np_brsty        AS CHAR FORMAT "x(2)"   INIT "". 
def var np_cartyp       AS CHAR FORMAT "x(30)"  INIT "".    
def var np_brandmodel   AS CHAR FORMAT "x(50)"  INIT "".    
def var np_caryear      AS CHAR FORMAT "x(4)"   INIT "".    
def var np_vehreg       AS CHAR FORMAT "x(11)"  INIT "".    /*vehicl registration*//*A54-0112*/
def var np_provin       AS CHAR FORMAT "x(20)"  INIT "".    /*vehicl registration*//*A54-0112*/
def var np_engcc        AS CHAR FORMAT "x(10)"  INIT "".    
def var np_tons         AS CHAR FORMAT "x(10)"  INIT "".    
def var np_chassis      AS CHAR FORMAT "x(25)"  INIT "".    /*chasis no*/
def var np_engno        AS CHAR FORMAT "x(25)"  INIT "".    /*engine no*/
def var np_covcod       AS CHAR FORMAT "x(20)"  INIT "".    /*cover type*/
def var np_comdate      AS CHAR FORMAT "x(10)"  INIT "".    /*comm date*/
def var np_premium      AS CHAR FORMAT "x(20)"  INIT "".    /*voluntory premium*/
def var np_sumins       AS CHAR FORMAT "x(10)"  INIT "".    
def var np_garage       AS CHAR FORMAT "x(25)"  INIT "".    /*sum insure*/
def var np_sendfile     AS CHAR FORMAT "x(25)"  INIT "".    
def var np_cedpol       AS CHAR INIT "" FORMAT "x(255)". 
def var np_comdatecomp  AS CHAR FORMAT "x(25)"  INIT "".    
def var np_compprem     AS CHAR FORMAT "x(10)"  INIT "".    /*expiry date*/
def var np_addr1        AS CHAR FORMAT "x(20)"  INIT "".    /*expiry date*/
def var np_addr2        AS CHAR FORMAT "x(150)" INIT "".    
def var np_addr3        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_addr4        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_addr5        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr1  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr2  AS CHAR FORMAT "x(150)" INIT "".    
def var np_recipeaddr3  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr4  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_recipeaddr5  AS CHAR FORMAT "x(45)"  INIT "".    
def var np_stkno        AS CHAR FORMAT "x(45)"  INIT "".    
def var np_memo         AS CHAR FORMAT "x(15)"  INIT "".    
def var np_idno         AS CHAR FORMAT "x(100)" INIT "".
def var np_covcod1      AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 cover type*/
def var np_ncb          AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 NCB*/
def var np_deduct       AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_drino        AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_driverid     AS CHAR FORMAT "x(20)"  INIT "".    /*A58-0183 */
def var np_accessory    AS CHAR FORMAT "x(150)" INIT "".    /*A58-0183 */
def var np_status       AS CHAR FORMAT "x(30)" INIT "".    /*A58-0183 */


/*A59-0396 add for 2+,3+*/
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
/*A59-0396 add for 2+,3+*/
 DEF VAR  si          AS CHAR FORMAT "x(10)" INIT "".
 def var  fi          AS CHAR FORMAT "x(10)" INIT "".
 def var  uom1_v      AS CHAR FORMAT "x(10)" INIT "".
 def var  uom2_v      AS CHAR FORMAT "x(10)" INIT "" .
 def var  uom5_v      AS CHAR FORMAT "x(10)" INIT "" .
 /* add by Sarinya A59-0426 */
 DEFINE WORKFILE wacctext
    FIELD n_policytxt  AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc    AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc1   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc2   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc3   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc4   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc5   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc6   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc7   AS CHAR  INIT "" FORMAT "x(100)"  
    FIELD n_textacc8   AS CHAR  INIT "" FORMAT "x(100)"   
    FIELD n_textacc9   AS CHAR  INIT "" FORMAT "x(100)"   .
 DEF VAR n_product     AS CHAR  INIT "" FORMAT "x(30)"    .
 /* end add by Sarinya A59-0426 */
 DEFINE VAR nv_chkerror   AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
 DEFINE VAR np_campaignov AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
 DEFINE VAR np_occupation AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
 DEFINE VAR nv_codeocc    AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
 DEFINE VAR nv_codeaddr1  AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
 DEFINE VAR nv_codeaddr2  AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
 DEFINE VAR nv_codeaddr3  AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
 DEFINE VAR nv_postcd     AS CHAR INIT "". /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEF VAR nv_nptr     AS RECID.
DEF VAR n_index AS INTE INIT 0 .
DEF VAR n_index2 AS INTE INIT 0.
DEF VAR nc_r2    AS CHAR FORMAT "x(20)" INIT "".
def var nv_cnt   as  int  init  0.
def var nv_row   as  int  init 0.
/* A59-0396 Sarinya c.*/
DEF VAR nv_covplus AS CHAR INIT "". 
DEF VAR nv_fl AS CHAR INIT "".    /*fleet*/
DEF VAR nv_nc AS CHAR INIT "".    /*NCB*/
DEF VAR nv_ds AS CHAR INIT "".    /*DSSPC*/
DEF VAR ba1   AS CHAR INIT "".    /*Base1*/
DEF VAR ba3   AS CHAR INIT "".    /*Base3*/
/* A59-0396 Sarinya c.*/
DEF VAR np_ispno  as char format "x(15)" .  /*a63-0161*/
DEF VAR np_result as char format "x(250)" . /*a63-0161*/
DEF VAR np_send   as char format "x(50)" .  /*a63-0161*/
DEF VAR np_ben    as char format "x(70)" .  /*a63-0161*/
/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".

DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".

DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".

DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_ratatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt        AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv        AS LOGICAL . 
define var nv_uom1_c       as char .
define var nv_uom2_c       as char .
define var nv_uom5_c       as char .
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
    
/* end A64-0138 */
